#!/bin/bash

echo "############################################################"
echo "#           WORKFLOW Check & download taxon data           #"
echo "#                        Running...                        #"
echo "#             1) Checks program availability               #"
echo "#             2) Checks input/output arguments             #"
echo "#             3) Downloads taxon-specific data             #"
echo "############################################################"

# Input arguments
# Taxon of interest
taxonOfInterest=$1
# Can be 'RefSeq' ,'GenBank' or 'all'
dbSource=$2
# Output file name
outputFileName=$3

# Check if program exists or is in PATH
if ! datasets --version &> /dev/null
then
    echo "--------------------------------------------"
    echo "ERROR! NCBI datasets/dataformat missing not found."
    echo "  Check installation:"
    echo "      - Set PATH correctly in ~/.bashrc or ~/.zshrc"
    echo "        or"
    echo "      - Install 'conda install -c conda-forge ncbi-datasets-cli' (https://github.com/ncbi/datasets)"
    echo "--------------------------------------------"
    exit
else
    echo ""
    echo "Checking for program(s)..."
    echo "--------------------------------------------"
    echo "1) NCBI datasets/dataformat found."
    echo ""
fi

# Printing passed arguments if NCBI datasets is available.
echo "Submitted arguments..."
echo "--------------------------------------------"
echo "1) Taxon:\"$taxonOfInterest\""
echo "2) Database source:\"$dbSource\""
echo "3) Output:\"$outputFileName\""
echo ""

echo "Checking input and output info..."
echo "--------------------------------------------"
# Check taxon name is supplied
if [ -z "$taxonOfInterest" ]
then
    echo "1) Taxon input found: NO - \"$taxonOfInterest\""
    echo "    -Sad news!"
    echo "    -Enter a taxon name as first attribute to the script."
    echo "    -EXAMPLE: ./99-Scripts/110-s-download_ncbi_genomes-RefSeq.sh \"TAXON\""
    echo ""
    echo "--------------------------------------------"
    echo "ERROR"
    echo "--------------------------------------------"
    exit 9999 #exit code 9999
else
    echo "1) Taxon input found: YES - \"$taxonOfInterest\""
fi

# Check genome source is supplied
if [ -z "$dbSource" ] || [ "$dbSource" != "RefSeq" ] && [ "$dbSource" != "GenBank" ] && [ "$dbSource" != "all" ]
then
    echo "2) Fatal error!"
    echo "    -The repository was not provided or is incorrect: dbSource=\"$dbSource\""
    echo "    -The program requires a valid source and refuses to take that responsibility for you. :("
    echo "    -Expected input: 'GenBank', 'RefSeq' or 'all'"
    echo ""
    echo "--------------------------------------------"
    echo "ERROR"
    echo "--------------------------------------------"
    exit 9999 #exit code 9999
elif [ "$dbSource" = "all" ]
then
    echo "2) Repository correct: YES - \"$dbSource\""
    echo "    -WARNING! You selected the 'all' option this will include data from 'GenBank' AND 'RefSeq'."
    echo "              This is probably what you want. In any case, you can always rerun the analysis."
else
    echo "2) Repository correct: YES - \"$dbSource\""
fi

# 
pathWorkDir=$( dirname $PWD)
dir_main=$( basename "$PWD" )
summaryFields=${pathWorkDir}/${dir_main}/misc_data/genomic_metadata_fields.txt

# Check if output filename is supplied with path
if [ -z "$outputFileName" ]
then
    myDate=$( date '+%Y_%m_%d' )
    outName=${taxonOfInterest}-${dbSource}-${myDate}
    outDir=${pathWorkDir}/${dir_main}/test
    echo "3) Output (DIRECTORY / FILENAME): NO/NO - \"$outputFileName\""
    echo "    -This is not ideal, but you've come so far to be stopped by such a trival issue."
    echo "    -The program will find or create a DIRECTORY and FILENAME for you."
    echo "    -I hope you know what you are doing."
    echo "    -Data will be stored in the predefined DIRECTORY: \"$outDir\"."
    outputfileName=$outDir/$outName
    if [ -d $outDir ]
    then
        echo "3.1) Great news! Predefined DIRECTORY found: YES - \"$outDir\""
        if [ -f $outputfileName.txt ] || [ -f $outputfileName.json ] || [ -f $outputfileName.fasta ]
        then
            echo "3.2) Fatal error! :("
            echo "      -The output FILENAME already exists in the DIRECTORY: \"$outName\"(.txt, .json, .fasta)"
            echo "      -The program will not overwrite files to avoid loosing your valuable data."
            echo "      -Specify a different DIRECTORY and/or FILENAME."
            echo ""
            echo "--------------------------------------------"
            echo "ERROR"
            echo "--------------------------------------------"
            exit 9999 #exit code 9999
        else
            echo "3.2) Everything looks great! FILENAME accepted: YES - \"$outName\"(.txt, .json, .fasta)"
        fi
    else
        echo "3.1) Bad news! Predefined DIRECTORY found: NO - \"\""
        echo "     -Read this carefully. Either the folder was deleted, moved or renamed."
        echo "     -You probably had a good reason to do it (no judgement), but be adviced this is not standard."
        echo "     -In order for you to continue, the program will recreate the predefined DIRECTORY: \"$outDir\""
        echo "3.2) Everything looks great! FILENAME accepted: YES - \"$outName\"(.txt, .json, .fasta)"
        echo "      -Kudos!"
        mkdir $outDir
    fi
else
    outDir=$( dirname $outputFileName )
    outName=$( basename $outputFileName | sed 's/\.[^.]*$//' )
    if [[ "$outName" =~ [^a-zA-Z0-9_-] ]]
    then
        echo "3) Fatal error! :("
        echo "    -Special character(s) found in the FILENAME: \"$outName\""
        echo "    -Accepted characters are: alphanumeric, '_', and '-'"
        echo "    -Do NOT use the '.' (dot) as part of the filenme, it indicates the suffix(.txt, .json, .fasta)."
        echo "--------------------------------------------"
        exit 9999 #exit code 9999
    else
        echo "3) Output (DIRECTORY / FILENAME): YES/YES \"$outputFileName\""
        if [ -d $outDir ]
        then
            echo "3.1) Great news! DIRECTORY found: YES - \"$outDir\""
            if [ -f $outDir/$outName.txt ] || [ -f $outDir/$outName.json ] || [ -f $outDir/$outName.fasta ]
            then
                echo "3.2) Fatal error! :("
                echo "      -The output FILENAME already exists: \"$outDir/$outName\"(.txt, .json, .fasta)"
                echo "      -The program will not overwrite files to avoid loosing valuable data."
                echo "      -Specify a FILENAME and/or a different output DIRECTORY."
                echo "--------------------------------------------"
                exit 9999 #exit code 9999
            else
                echo "3.2) Everything looks great! FILENAME accepted: YES - \"$outName\"(.txt, .json, .fasta)"
            fi
        else
            echo "3.1) You are asking the program to create a new directory outDir=\"$outDir\""
            echo "    -You're that kind of person that likes to have everything under control."
            echo "    -DIRECTORY created!"
            mkdir -p $outDir
            echo "3.2) Everything looks great! FILENAME accepted: YES - \"$outName\"(.txt, .json, .fasta)"
            echo "    -Kudos!"
        fi
    fi
fi

# Create a vertical list of metadata traits wanted in the final output TSV file (example shown in genomesSummaryFields.txt)
# Store the list of traits in an array (horizontal)
#readarray -t myFieldsArray < $summaryFields
# Transform the array into a comma-separated list (horizontal)
#myFields=$( echo ${myFieldsArray[@]} | sed -e 's/ /,/g' )
myFields=$(cat misc_data/fields-genomic_metadata.txt | xargs | sed -e 's/ /,/g')

echo ""
echo -e "Downloading genomes and metadata for \"$taxonOfInterest\" from \"$dbSource\"."
echo "--------------------------------------------"
fileJson=01-${outName}.json
fileTxt=02-${outName}.txt
fileAssembly=03-${outName}-assembly_list.txt
dirGenomes=04-${outName}-genomes
# Download metadata for specific taxon in JSON format (one line per genome)
datasets summary genome taxon "$taxonOfInterest" --api-key ${NCBI_API_KEY} --assembly-source ${dbSource} --as-json-lines > ${outDir}/$fileJson
# Download metadata for specific taxon in TSV format (one line per genome)
datasets summary genome taxon "$taxonOfInterest" --api-key ${NCBI_API_KEY} --assembly-source ${dbSource} --as-json-lines | dataformat tsv genome --fields ${myFields} > ${outDir}/$fileTxt
# Download metadata for specific taxon in TSV format (one line per genome)
#datasets download genome taxon "$taxonOfInterest" --api-key ${NCBI_API_KEY} --assembly-source ${dbSource} --include genome > ${outDir}/${outName}-genomic
cat ${outDir}/$fileTxt | awk 'BEGIN{FS=OFS="\t"}NR>1{print $4}' | sed -e 's/GCF/GCA/' | sort -u > ${outDir}/$fileAssembly
cd ${outDir}
datasets download genome accession --inputfile "$fileAssembly" --api-key ${NCBI_API_KEY} --assembly-source GenBank --include genome
unzip ncbi_dataset.zip
mv ncbi_dataset $dirGenomes
rm -r README.md ncbi_dataset.zip
cd ..
echo ""
echo -e "Data stored in \"${outDir}/${outName}\"(.json, .txt, .fna)"
echo "--------------------------------------------"
echo ""
echo "DONE"
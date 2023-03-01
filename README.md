# Download genomes and metadata from NCBI (BETA)
This program will search and download taxon-specific genomic data and metadata. It employes **python scripts** and NCBI program **datasets** [https://github.com/ncbi/datasets].<br>
**Warning!** Some scripts are under construction and might not reflect the final vesion. *Use on your own risk!*.<br>
### Quick start (for those in a hurry!)
1. Download repository 
```bash
# Change a desired folder
cd $HOME/my/desired/directory
# Clone repository
git clone https://github.com/juliantom/Download_genomes_and_metadata_NCBI.git
# Change to repository
cd Download_genomes_and_metadata_NCBI
```
2. Make scripts execuatable and in path
```bash
# make programs executable and copy to bin
chmod +x 99-SCRIPTS/*.py
# Create bin folder
mkdir bin
# copy programs to bin
cp 99-SCRIPTS/01-check_programs_in_path.py bin/jt-check_programs_in_path
cp 99-SCRIPTS/101-s-download_ncbi_genomes.sh bin/jt-workflow_check_and_download
# make bin executable
export PATH="$PWD/bin:$PATH"
```
### Structure of program
1. Check you have the programs
```bash
# Check if NCBI datasets is installed and in the path
jt-check_programs_in_path datasets,dataformat
```
If the programs are not found check if they were installed in a conda environment or install it.
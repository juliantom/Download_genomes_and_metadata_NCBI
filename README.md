# Download genomes and metadata from NCBI (BETA)
This program will search and download genomic data for specific taxa using NCBI program \'datasets\'[https://github.com/ncbi/datasets].<br>
**Warning!** Some scripts are under construction and might not reflect the final vesion. *Use on your own risk*.<br>
1. Dowload genomes.
2. Download metadata.

### Quick start
1. Obtaining necessary files 
```bash
# Change a desired folder
cd $HOME/Desktop/Active_projects
# Clone repository
git clone https://github.com/juliantom/Download_genomes_and_metadata_NCBI.git
# Change to repository
cd Download_genomes_and_metadata_NCBI

# make programs executable and copy to bin
chmod +x 99-SCRIPTS/*.py
# copy programs to bin
cp 99-SCRIPTS/01-check_programs_in_path.py bin/jtm-01-check_programs_in_path

# make bin executable
export PATH="$PWD/bin:$PATH"
```
### Structure of program
```bash
1. a Mod
2. 4d
```
#!/bin/bash

#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --time=0-01:00:00
#SBATCH -p general

rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory

echo -e $1 manta "\n"

mkdir $rawdir/processed/manta/${1}
/Users/bader01/miniconda3/envs/py27/bin/configManta.py --exome --outputContig --bam $rawdir/rawdata/${1}sort.bam --referenceFasta /mnt/scratcha/sjlab/abader/genomes/hg38/GRCh38.p10.genome.fa --runDir $rawdir/processed/manta/${1}/ 

$rawdir/processed/manta/${1}/runWorkflow.py -m local -j 8



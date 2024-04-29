#!/bin/bash

#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --time=0-01:00:00
#SBATCH -p general

rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory

echo -e $2 strelka "\n"

mkdir $rawdir/processed/strelka/${2}_som
/Users/bader01/miniconda3/envs/py27/bin/configureStrelkaSomaticWorkflow.py --exome --normalBam $rawdir/rawdata/${1}sort.bam --tumorBam $rawdir/rawdata/${2}sort.bam --referenceFasta /mnt/scratcha/sjlab/abader/genomes/hg38/GRCh38.p10.genome.fa --runDir $rawdir/processed/strelka/${2}_som/ --indelCandidates $rawdir/processed/manta/${2}_som/results/variants/candidateSmallIndels.vcf.gz

$rawdir/processed/strelka/${2}_som/runWorkflow.py -m local -j 8


#!/bin/bash

#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=9
#SBATCH --mem=10G
#SBATCH --time=0-00:30:00
#SBATCH -p general

rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory

echo -e $1 fastp "\n"

fastp -g -w 8 -q 15 -u 40 -l 5 -A -h $rawdir/rawdata/fastqc/${1}_fastp.html -i $rawdir/rawdata/fastq/${1}_S*_R1_001.fastq.gz -I $rawdir/rawdata/fastq/${1}_S*_R2_001.fastq.gz --out1 $rawdir/rawdata/fastq/${1}_qc1.fq.gz --out2 $rawdir/rawdata/fastq/${1}_qc2.fq.gz





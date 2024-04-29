#!/bin/bash

#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=1-00:00:00
#SBATCH -p general

rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory

echo -e $1 bowtie2 "\n"

bowtie2 -t -p 15 --fr --maxins 10000 --dovetail -x /mnt/scratcha/sjlab/abader/genomes/hg38/hg38 \
-1 $rawdir/${1}.fq.1.gz -2 $rawdir/${1}.fq.2.gz --un-conc $rawdir/${1}_unal.fq \
| samtools view -bS - > ${1}_hsort.bam



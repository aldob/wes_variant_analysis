#!/bin/bash

#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=9
#SBATCH --mem=20G
#SBATCH --time=0-04:00:00
#SBATCH -p general

rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory

echo -e $1 bamcov "\n"

bamCoverage --bam $rawdir/rawdata/${1}sort.bam -o $rawdir/processed/wigs/${1}.bw -bs 20 --effectiveGenomeSize 2913022398 -p 8 --normalizeUsing CPM --extendReads 300 --maxFragmentLength 5000


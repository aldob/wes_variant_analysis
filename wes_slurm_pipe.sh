#!/bin/bash
#2>&1 | tee

rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory
srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # srcdir is the location of this script and should contain all other scripts
# sample_ID=("$@") # arguments are the list of samples
readarray -t sample_ID < $rawdir/samples.txt # instead of arguments, use a table of samples
echo ${sample_ID[*]}


echo -e "\n"Filtering reads
for sample in ${sample_ID[@]}
do
    sbatch -J=fp --output=$rawdir/log/fastp_${sample}.log --wait $srcdir/fastp_slurm.sh ${sample} & done
wait

echo -e "\n"Removing original fastq files
rm $rawdir/rawdata/fastq/*fastq.gz

echo -e "\n"Aligning
for sample in ${sample_ID[@]}
do
    sbatch -J=bt2 --output=$rawdir/log/bt2_${sample}.log --wait $srcdir/bt2_slurm.sh ${sample} & done
wait

echo -e "\n"Bigwig gen
for sample in ${sample_ID[@]}
do
    sbatch -J=bw --output=$rawdir/log/bamcov_${sample}.log --wait $srcdir/bamcov_slurm.sh ${sample} & done
wait


echo -e "\n"Running manta
for sample in ${sample_ID[@]}
do
    sbatch -J=mtag --output=$rawdir/log/mantagerm_${sample}.log --wait $srcdir/mantagerm_slurm.sh ${sample} & done
wait

echo -e "\n"Running strelka
for sample in ${sample_ID[@]}
do
    sbatch -J=strg --output=$rawdir/log/strelkagerm_${sample}.log --wait $srcdir/strelkagerm_slurm.sh ${sample} & done
wait



readarray -t sample_ID < $rawdir/samples1.txt

echo -e "\n"Running manta somatic
for sample in ${sample_ID[@]}
do
    sbatch -J=mtas --output=$rawdir/log/mantasom_${sample}.log --wait $srcdir/mantasom_slurm.sh rpe_atcc ${sample} & done
wait

echo -e "\n"Running strelka somatic
for sample in ${sample_ID[@]}
do
    sbatch -J=strs --output=$rawdir/log/strelkasom_${sample}.log --wait $srcdir/strelkasom_slurm.sh rpe_atcc ${sample} & done
wait



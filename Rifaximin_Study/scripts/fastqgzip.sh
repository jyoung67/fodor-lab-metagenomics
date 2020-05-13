#!/bin/bash
#=====OPTIONS=====
#PBS -q copperhead
#PBS -l procs=1
#PBS -l walltime=4:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16GB
#=====END PBS OPTIONS====

outDir="/nobackup/afodor_research/datasets/rifaximin/jyoung/R1"
cd ${outDir}
fastqFiles=*.fastq
now="$(date +'%Y/%m/%d %H:%M:%S')"
numOfFoundFiles=$(ls -l ${outDir}/*.fastq | wc -l)

printf "Number of '.fastq' files found in ${outDir}:  %d\n" "${numOfFoundFiles}"

i=1
for fastqFile in ${fastqFiles}; do
	echo "[${i}] Compressing File -> ${fastqFile}"
	gzip ${fastqFile} -v -f
	i=$((i+1))
done

printf "End Time:  %s\n" "$(date +'%Y/%m/%d %H:%M:%S')"
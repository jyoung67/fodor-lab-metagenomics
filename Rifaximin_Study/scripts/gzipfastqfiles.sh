#! /bin/bash
# call this script with one parameter
# $1 - path to directory
# Example: sh /projects/afodor_research/jyoung/srascripts/cd gzipfastqfiles.sh /nobackup/afodor_research/datasets/rifaximin/jyoung/R1

outDir=${1}
cd ${outDir}
fastqFiles=*.fastq
now="$(date +'%Y/%m/%d %H:%M:%S')"
numOfFoundFiles=$(ls -lR ${outDir}/*.fastq | wc -l)

printf "Number of '.fastq' files found in ${outDir}:  %d\n" "${numOfFoundFiles}"

i=1
for fastqFile in ${fastqFiles}; do
	echo "[${i}] Compressing File -> ${fastqFile}"
	gzip ${fastqFile} -v -f
	i=$((i+1))
done

printf "End Time:  %s\n" "$(date +'%Y/%m/%d %H:%M:%S')"
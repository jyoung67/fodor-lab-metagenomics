#! /bin/bash
# call this script with two parameters; 
# 1 - file path to directory
# 2 - path to adapter sequence filter

cd $1

for f in *.fastq; do
    echo "File -> $f"
    b=`echo $f | sed 's/\.fastq$//'` 
    echo "Working on -> $b"
    TrimmomaticSE $b.fastq $b.trim.fastq ILLUMINACLIP:$2:4:10:3 SLIDINGWINDOW:30:20 MINLEN:25  
    rm $b.fastq
    
done

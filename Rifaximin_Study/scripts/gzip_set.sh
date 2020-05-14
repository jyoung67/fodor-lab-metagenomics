#!/bin/bash
#=====OPTIONS=====
#PBS -q copperhead
#PBS -l procs=1
#PBS -l walltime=8:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16GB
#=====END PBS OPTIONS====

ids=(${1//,/ })
now="$(date +'%Y/%m/%d %H:%M:%S')"
printf "Start Time:  %s\n" "$now"
printf "Array length  %d\n" "$arrLength"
currentDir="/nobackup/afodor_research/datasets/rifaximin/jyoung/R1"

cd ${currentDir}

# download files via accession id
for i in ${!ids[@]}; do
   echo "**********($((i+1))/${arrLength}):compressing ${ids[$i]}**********"
   gzip ${ids[$i]} -v -f 
done

printf "End Time:  %s\n" "$(date +'%Y/%m/%d %H:%M:%S')"
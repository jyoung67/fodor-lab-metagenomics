#! /bin/bash
# call this script with one parameter
# $1 - comma-delimited SRA accession id's (no spaces)
# Example:  sradownload.sh SRR5799796,SRR5799797,SRR5799798,SRR5799799,SRR5799800,SRR5799801,SRR5799802,SRR5799803

now="$(date +'%Y/%m/%d %H:%M:%S')"
ids=(${1//,/ })
arrLength=${#ids[@]}
printf "Start Time:  %s\n" "$now"
printf "Array length  %d\n" "$arrLength"
outDir="/nobackup/afodor_research/datasets/rifaximin/jyoung/R1/"

# Explicitly loading later version of sra-tools, version 2.10.5 
# (TODO:  test the following two commands within this bash script)
# module unload sra-tools
# module load sra-tools/2.10.5

# download files via accession id
for i in ${!ids[@]}; do
    echo "**********($((i+1))/${arrLength}):Downloading ${ids[$i]}**********"
   fasterq-dump ${ids[$i]} --split-files --skip-technical -O ${outDir}
done

printf "End Time:  %s\n" "$(date +'%Y/%m/%d %H:%M:%S')"
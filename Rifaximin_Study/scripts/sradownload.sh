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

module load sra-tools

# download files via accession id
for i in ${!ids[@]}; do
    echo "**********($((i+1))/${arrLength}):Downloading ${ids[$i]}**********"
   fasterq-dump ${ids[$i]} --split-files --skip-technical -O ${outDir}
done


cd ${outDir}
# compress .fastq files
for f in *.fastq; do
    [ -f "${f}" ] || break
    echo "Compressing File -> ${f}"
    gzip ${f} -v
done

printf "End Time:  %s\n" "$(date +'%Y/%m/%d %H:%M:%S')"
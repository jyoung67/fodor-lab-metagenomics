getRemainingFastqFiles <- function(start=NaN,end=NaN)
{
  
  df <- read.table("/Users/young/Documents/GitHub/fodor-lab-metagenomics/Rifaximin_Study/remaining_fastq_files.tsv", sep="\t", header=FALSE)
  numOfRows = nrow(df)
  if(is.nan(start))
  {
    start = 1
  }
  if(is.nan(end))
  {
    end = numOfRows
  }
  
  compressionJobCmd <- paste("qsub -N remaining_fastq_files_", start, "_", end, " gzip_set.sh ", sep = "")
  for(aId in df[start:end,1])
  {
    compressionJobCmd <- paste(compressionJobCmd, aId, ",", sep = "")
  }
  compressionJobCmd <- substr(compressionJobCmd, 1, nchar(compressionJobCmd)-1)
  
  return (list(dataIds=df[,1], compressionJobCmd=compressionJobCmd, numOfRows=numOfRows))
  
}
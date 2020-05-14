reviewRifaximinDatasets <- function()
{
  sourceData <- as.vector(read.table("https://raw.githubusercontent.com/jyoung67/fodor-lab-metagenomics/master/Rifaximin_Study/SraRunTable.csv",sep=",",header=TRUE)$Run)
  
  tmpDf <- read.table("/Users/young/Documents/GitHub/fodor-lab-metagenomics/Rifaximin_Study/compressed_fastq_files.tsv", sep="\t", header=FALSE)
  frequencyCounts <- data.frame(table(substr(tmpDf[,1], 1,10))) 
  targetData <- unique(frequencyCounts$Var1)
  
  cat("Number of accession run Id's that do NOT have a count of two:  ", sum(frequencyCounts$Freq != 2), "\n")
  missingFiles <- sourceData[!sourceData %in% targetData]
  numOfMissingFiles <- length(missingFiles)
  cat("Number of missing downloaded files: ", numOfMissingFiles, "\n")
  sraDownloadScript <- "sh sradownload.sh "
  if(numOfMissingFiles > 0)
  {
    # print(missingFiles)
    
    for(f in missingFiles)
    {
      sraDownloadScript <- paste(sraDownloadScript, f, ",", sep = "")
    }
    print(sraDownloadScript)
  }
  
  return(list(sourceData=sourceData, targetData=targetData, frequencyCounts=frequencyCounts, sraDownloadScript=sraDownloadScript))
  
}
reviewRifaximinDatasets <- function()
{
  sourceData <- as.vector(read.table("https://raw.githubusercontent.com/jyoung67/fodor-lab-metagenomics/master/Rifaximin_Study/SraRunTable.csv",sep=",",header=TRUE)$Run)
  
  # tmpDf <- read.table("https://raw.githubusercontent.com/jyoung67/fodor-lab-metagenomics/master/Rifaximin_Study/rifaximin_data.tsv", sep="\t", header=FALSE)
  tmpDf <- read.table("/Users/young/Documents/GitHub/fodor-lab-metagenomics/Rifaximin_Study/mixed.tsv", sep="\t", header=FALSE)
  frequencyCounts <- data.frame(table(substr(tmpDf[,1], 1,10))) 
  targetData <- unique(frequencyCounts$Var1)
  
  cat("Number of accession run Id's that do NOT have a count of two:  ", sum(frequencyCounts$Freq != 2), "\n")
  missingFiles <- sourceData[!sourceData %in% targetData]
  numOfMissingFiles <- length(missingFiles)
  cat("Number of missing downloaded files: ", numOfMissingFiles, "\n")
  if(numOfMissingFiles > 0)
  {
    # print(missingFiles)
    sraDownloadScript <- "sh sradownload.sh "
    for(f in missingFiles)
    {
      sraDownloadScript <- paste(sraDownloadScript, f, ",", sep = "")
    }
    print(sraDownloadScript)
  }
  
  return(list(sourceData=sourceData, targetData=targetData, frequencyCounts=frequencyCounts, sraDownloadScript=sraDownloadScript))
  
}
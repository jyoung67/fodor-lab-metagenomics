reviewRifaximinDatasets <- function()
{
  sourceData <- as.vector(read.table("https://raw.githubusercontent.com/jyoung67/fodor-lab-metagenomics/master/Rifaximin_Study/SraRunTable.csv",sep=",",header=TRUE)$Run)
  
  tmpDf <- read.table("https://raw.githubusercontent.com/jyoung67/fodor-lab-metagenomics/master/Rifaximin_Study/compressed_fastq_files.tsv", sep="\t", header=FALSE)
  frequencyCounts <- data.frame(table(substr(tmpDf[,1], 1,10))) 
  targetData <- unique(frequencyCounts$Var1)
  cat("# of rows in source dataset (https://www.ncbi.nlm.nih.gov/bioproject/391915):  ", length(sourceData), "\n")
  cat("# of rows in downloaded/split/compressed dataset:  ", nrow(tmpDf), "\n")
  cat("# of accession run Id's that do NOT have a count of two:  ", sum(frequencyCounts$Freq != 2), "\n")
  missingFiles <- sourceData[!sourceData %in% targetData]
  numOfMissingFiles <- length(missingFiles)
  cat("# of missing downloaded files: ", numOfMissingFiles, "\n")
  sraDownloadScript <- "sh sradownload.sh "
  if(numOfMissingFiles > 0)
  {
    for(f in missingFiles)
    {
      sraDownloadScript <- paste(sraDownloadScript, f, ",", sep = "")
    }
  }
  
  return(list(sourceData=sourceData, targetData=targetData, frequencyCounts=frequencyCounts, sraDownloadScript=sraDownloadScript))
  
}
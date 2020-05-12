analyzeRunMetaData <- function()
{
  df <- read.table("/Users/young/Documents/Fodor_Lab/Rifaximin_Study/SraRunTable.csv",sep=",",header=TRUE)
  v <- as.vector(df$timepoint..run.)
  totalRunCount <- length(v)
  scheduledVisitsCount <- sum(v %in% c("V6","V3","V4","V7","V11"))
  unscheduledVisitsCount <- sum(!(v %in% c("V6","V3","V4","V7","V11")))
  cat("Total number of runs: ", length(v), "\n")
  cat("Unique time points: ", unique(v), "\n")
  cat("Scheduled visits: ", scheduledVisitsCount, "\n")
  cat("Unscheduled visits: ", unscheduledVisitsCount, "\n")
  accessionIds = ""
  for (val in df$Run[551:length(df$Run)])
  {
    accessionIds = paste(accessionIds, val, ",", sep="")
    
    
  }
  print(paste("sh sradownload.sh", accessionIds))
  
  
  
  return (df)
}
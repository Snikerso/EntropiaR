setwd("C:/Users/Lenovo/Desktop/Gaze/Licencjat/Analiza/Entropia")
getwd()

library(dplyr)
library(plyr)


myfiles <- list.files(path=getwd(), pattern="*Samples.txt", full.names=T)

names(myfiles) <- seq_along(as.list(myfiles))

names(myfiles)





for (binSIZE in seq(4, 16, 4)){
  results_entropy <- matrix(, nrow = 118, ncol = 2)
  names(results_entropy) <- c("p","entropy")
  index = 1
  
  
  for (p in myfiles) {
    
    filename <- paste(p)
    
    entro = read.table(filename,fill = TRUE, header=TRUE, sep = "\t",stringsAsFactors = FALSE)
    entrop <- select(entro, "Time","L.POR.X..px." , "L.POR.Y..px.",)
    names(entrop)=c("Time","gazeX", "gazeY")
    entrop <- filter(entrop,gazeX>0,gazeY>0)
    y2d = discretize2d(entrop$gazeX, entrop$gazeY, numBins1 = binSIZE, numBins2 = binSIZE)
    H12 = entropy(y2d)
    #Tu wk??adamy  do danej kolumny przy danym particypance
    results_entropy[index, 1] <- p
    results_entropy[index, 2] <- H12/(-log2(1/binSIZE^2))
    
    index <- index +1
    
  }
  #Zapis tabelek
  filename <- paste("ResultsEntro_Step", binSIZE, ".txt", sep ="")
  write.table(results_entropy, file = filename, append = FALSE, sep = "\t", row.names = FALSE,
              col.names = c("p","entropy"), quote = FALSE)
}

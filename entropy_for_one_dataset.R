
setwd("C:/Users/Lenovo/Desktop")


#odpakowywanie paczek
library(entropy)
library(ggplot2)
library(dplyr)
library(plyr)
library(readr)

#Odczyt danych

data <- read.table("aaa.txt", "\t",fill = TRUE , header = TRUE , sep = "\t",stringsAsFactors = FALSE,skip = 10)


entropy_data <- select(data, "Time","L.POR.X..px." , "L.POR.Y..px.",)

write.table(entropy_data, file = "dataentropy.txt", append = FALSE, sep = "\t", row.names = FALSE,
            col.names = c("Time","gazeX","gazeY"), quote = FALSE)

data1 <- read.table("C:/Users/Lenovo/Desktop/dataentropy.txt", "\t",fill = TRUE , header = TRUE , sep = "\t",stringsAsFactors = FALSE,skip = 10)


names(data1)=c("Time", "gazeX", "gazeY")

#Usuwam wartoœci zerowe, bo potem funkcja discretize2d() nie mo¿e dzia³aæ. 
dataready <- filter(data1,gazeX>0,gazeY>0)

########################################################################3
#Obliczanie entropii z jednego pliku
########################################################################
resultsENTRO <- matrix( , nrow = 1, ncol = 2)
binSIZE = 4
y2d = discretize2d(dataready$gazeX, dataready$gazeY, numBins1 = binSIZE, numBins2 = binSIZE)
H12 = entropy(y2d)
resultsENTRO[1, 1] <- 1
resultsENTRO[1, 2] <- H12/(-log2(1/binSIZE^2))



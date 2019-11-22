library(dplyr)

gameData <- read.table(file="UWvMSU_1-22-13.txt", header=TRUE) # read data file into data frame

UWdata <- gameData[gameData$team == "UW",] #subset out rows where UW scores

MSUdata <- gameData[gameData$team == "MSU",] # subset out rows where MSU scores

UWdata$UW_csum <- cumsum(UWdata$score) # add cumulative sum row in the subsetted UW data
UWdata$MSU_csum <- NA # add blank column of NA values called MSU_csum (necessary for subsequent merging)
MSUdata$MSU_csum <- cumsum(MSUdata$score)  # add cumulative sum row in the subsetted MSU data
MSUdata$UW_csum <- NA # add blank column of NA values called UW_csum (necessary for subsequent merging)
gameData <- rbind(UWdata, MSUdata) #merge the two subsetted data sets back into one

gameData <- gameData[order(gameData$time),] # sort the rows in order of time

library(tidyr) 

gameData <- gameData %>% fill(UW_csum) %>% fill(MSU_csum) # fill in NA values in each cumulative sum row with the last non-NA value in that column (filling in rows where that team didn't score, which threw off the cumulative sum function above)

gameData$MSU_csum[is.na(gameData$MSU_csum)] <- 0 # fill in the remaining NA values in the MSU cumulative sum column with zeros (since they scored second)

plot(gameData$time, gameData$UW_csum, type = "l", col = "red", xlab = "Time", ylab = "Score") # plotting cumulative sum score vs time; UW in red
lines(gameData$time, gameData$MSU_csum, col = "blue") # add MSU cumulative sum score in blue; 

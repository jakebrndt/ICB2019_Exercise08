library(dplyr)

gameData <- read.table(file="UWvMSU_1-22-13.txt", header=TRUE)

UWdata <- gameData[gameData$team == "UW",]

MSUdata <- gameData[gameData$team == "MSU",]

UWdata$UW_csum <- cumsum(UWdata$score)
UWdata$MSU_csum <- NA
MSUdata$MSU_csum <- cumsum(MSUdata$score)
MSUdata$UW_csum <- NA
gameData <- rbind(UWdata, MSUdata)

gameData <- gameData[order(gameData$time),]

library(tidyr)

gameData <- gameData %>% fill(UW_csum) %>% fill(MSU_csum)

gameData$MSU_csum[is.na(gameData$MSU_csum)] <- 0

plot(gameData$time, gameData$UW_csum, type = "l", col = "red", xlab = "Time", ylab = "Score")
lines(gameData$time, gameData$MSU_csum, col = "blue")

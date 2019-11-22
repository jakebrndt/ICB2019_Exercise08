# Part 1

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

#Part 2: guess my number

answer <- sample(1:100, 1) # take a random integer 1 through 100 and store in variable answer
print("I'm thinking of a number 1-100 ...") # print game intro
for(i in 1:10){ #sets loop of up to 10 possible iterations/guesses
  guess <- readline(prompt = "Guess:") #prompts the user to guess and stores guess in variable
  if (guess < answer){ # if guess is less than the answer, tell them "Higher"
    print("Higher") 
  } else if (guess > answer){ # if guess is higher than answer, tell them "Lower"
    print("Lower")
  } else { # otherwise (if guess is neither higher or lower than the answer), it must be correct; thus, print "Correct"; 
    print("Correct")
    break # if guessed correctly, break out of loop
  }
}
print("Game over ...") #print "Game Over" once game loop has ended

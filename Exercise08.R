# to make UWvMSU_1-22-13.txt into a table/variable
UWvMSU <- read.table("UWvMSU_1-22-13.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
# to make two variables for each team's data
UW=UWvMSU[UWvMSU[,2]=="UW",]
MSU=UWvMSU[UWvMSU[,2]=="MSU",]
# to make both team variables into data frames
as.data.frame(UW, row.names = NULL, optional = FALSE)
as.data.frame(MSU, row.names = NULL, optional = FALSE)
# to make a data frame for both teams, cumulative scores
UWcum <- as.data.frame(cumsum(UW[,3]))
MSUcum <- as.data.fram(cumsum(MSU[,3]))

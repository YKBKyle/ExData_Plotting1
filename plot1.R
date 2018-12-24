library(sqldf)
DataPath <- "../household_power_consumption.txt"

## Load only lines with date = 1/2/2007 or 2/2/2007
Data <- read.csv.sql(DataPath,
                     sql = "select * from file where Date in('1/2/2007','2/2/2007')",
                     head=TRUE, sep = ";")

## Convert character date time to Date/Time classes
DateTime <- strptime(paste(Data$Date,Data$Time),"%d/%m/%Y %H:%M:%S")
Data2 <- Data[,names(Data)!="Date" & names(Data)!="Time"]
Data3 <- data.frame(DateTime,Data2)


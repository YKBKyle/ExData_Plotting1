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

## plot 1: histogram
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg="transparent")
 # Note bg="transparent" set the background color as transparent

hist(Data3$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()

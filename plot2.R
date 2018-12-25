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

## plot 2: scatter plot on Global_active_power and add lines
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg="transparent")
 # Note bg="transparent" set the background color as transparent

plot(Data3$DateTime, Data3$Global_active_power,
     xlab = NA,
     ylab = "Global Active Power (kilowatts)",
     type = "l")

#lines(Data3$DateTime, Data3$Global_active_power)

dev.off()

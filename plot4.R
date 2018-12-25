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

## plot 4: mfrow = c(2,2)
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg="transparent")
 # Note bg="transparent" set the background color as transparent

par(mfrow = c(2,2))
 # plot on location (1,1)
plot(Data3$DateTime,
     Data3$Global_active_power,
     col = "black",
     xlab = NA,
     ylab = "Global Active Power",
     type = "l")

 # plot on location (1,2)
plot(Data3$DateTime,
     Data3$Voltage,
     col = "black",
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")

 # plot on location (2,1) - plot3
LinePlot <- function(x, y, col, xlab=NA, ylab=NA, type="l"){
    plot(x, y, col=col, xlab=xlab, ylab=ylab, type=type,
         ylim=range(Data3[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")]))
}
LinePlot(Data3$DateTime, Data3$Sub_metering_1, col="black")
par(new=TRUE)
LinePlot(Data3$DateTime, Data3$Sub_metering_2, col="red")
par(new=TRUE)
LinePlot(Data3$DateTime, Data3$Sub_metering_3, col="blue", ylab="Energy sub metering")
legend("topright",
       lty = 1,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       bty = "n") # turn off the border of legend

 # plot on location (2,2)
plot(Data3$DateTime,
     Data3$Global_reactive_power,
     col = "black",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l")
dev.off()

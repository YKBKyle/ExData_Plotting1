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

## plot 3: multiple lines on one plot
LinePlot <- function(x, y, col, xlab=NA, ylab=NA, type="l"){
    plot(x, y, col=col, xlab=xlab, ylab=ylab, type=type,
         ylim=range(Data3[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")]))
}

png(filename = "plot3.png", width = 480, height = 480, units = "px", bg="transparent")
 # Note bg="transparent" set the background color as transparent

LinePlot(Data3$DateTime, Data3$Sub_metering_1, col="black")
par(new=TRUE)
LinePlot(Data3$DateTime, Data3$Sub_metering_2, col="red")
par(new=TRUE)
LinePlot(Data3$DateTime, Data3$Sub_metering_3, col="blue", ylab="Energy sub metering")
legend("topright",
       lty = 1,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()

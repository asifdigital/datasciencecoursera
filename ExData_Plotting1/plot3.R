
library(dplyr)

## load test data 
fileData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors =FALSE)

## Clean data: Convert Date from Character to Date and Convert time to correct format
fileData$Date<-as.Date( as.character(fileData$Date),format = "%d/%m/%Y")
fileData$Time<-format(  strptime(fileData$Time,format="%H:%M:%S"), format="%H:%M:%S" )

## Get data subset for dates in between 2007-02-01 and 2007-02-02
powerData<-filter(fileData,Date>="2007-02-01" & Date<="2007-02-02")
xDateTime<-as.POSIXct(paste(powerData$Date, powerData$Time), format="%Y-%m-%d %H:%M:%S")

##Plot 3

png("plot3.png", width=480, height=480)
with(powerData, 
     plot(Sub_metering_1~xDateTime, type="l" , ylab="Energy sub metering", xlab=""))
points(powerData$Sub_metering_2~xDateTime, type="l", col="red")
points(powerData$Sub_metering_3~xDateTime, type="l", col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red","blue")
       ,lty=1, lwd=2)

dev.off()



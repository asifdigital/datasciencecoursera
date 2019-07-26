
library(dplyr)

## load test data 
fileData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors =FALSE)

## Clean data: Convert Date from Character to Date and Convert time to correct format
fileData$Date<-as.Date( as.character(fileData$Date),format = "%d/%m/%Y")
fileData$Time<-format(  strptime(fileData$Time,format="%H:%M:%S"), format="%H:%M:%S" )

## Get data subset for dates in between 2007-02-01 and 2007-02-02
powerData<-filter(fileData,Date>="2007-02-01" & Date<="2007-02-02")
xDateTime<-as.POSIXct(paste(powerData$Date, powerData$Time), format="%Y-%m-%d %H:%M:%S")

##Plot 4

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
with(powerData, 
     plot(Global_active_power~xDateTime, type="l" , ylab="Global Active Power", xlab=""))

with(powerData, 
     plot(Voltage~xDateTime, type="l" , ylab="Voltage", xlab="datetime"))

with(powerData, 
     plot(Sub_metering_1~xDateTime, type="l" , ylab="Energy sub metering", xlab=""))
points(powerData$Sub_metering_2~xDateTime, type="l", col="red")
points(powerData$Sub_metering_3~xDateTime, type="l", col="blue")

with(powerData, 
     plot(Global_reactive_power~xDateTime, type="l" , ylab="Global Reactive Power", xlab="datetime"))

dev.off()



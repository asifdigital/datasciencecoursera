

# fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileUrl,destfile = "power_data.zip")
# unzip("power_data.zip")

library(dplyr)

## load test data 
fileData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors =FALSE)

## Clean data: Convert Date from Character to Date and Convert time to correct format
fileData$Date<-as.Date( as.character(fileData$Date),format = "%d/%m/%Y")
fileData$Time<-format(  strptime(fileData$Time,format="%H:%M:%S"), format="%H:%M:%S" )

## Get data subset for dates in between 2007-02-01 and 2007-02-02
powerData<-filter(fileData,Date>="2007-02-01" & Date<="2007-02-02")

##Plot 1

png("plot2.png", width=480, height=480)
hist(as.numeric(powerData$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()





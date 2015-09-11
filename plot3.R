## To run this code, download the zip from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## and extract the file (household_power_consumption.txt) into a directory 
## called 'data' that is a sibling of the project directory

library(readr)
library(dplyr)
## read the data
consumption <- read_csv2("../data/household_power_consumption.txt", col_names = T, progress = T, na="?")
## only interested in data for 1/2/2007 and 2/2/2007
plotdata <- filter(consumption, Date=="1/2/2007" | Date=="2/2/2007")
## add a timestamp composed from the Date and Time columns
plotdata$datetime <- as.POSIXct(paste(plotdata$Date, plotdata$Time),format="%d/%m/%Y %H:%M:%S")

## open a png device (480 x 480)
png(filename = "plot3.png", width = 480, height = 480)

## plot the data and each set separately
plot(plotdata$datetime, plotdata$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
points(plotdata$datetime, plotdata$Sub_metering_1, type="l", col="black")
points(plotdata$datetime, plotdata$Sub_metering_2, type="l", col="red")
points(plotdata$datetime, plotdata$Sub_metering_3, type="l", col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), seg.len = 3, lwd = 1, bty="o")

## close the device
dev.off()
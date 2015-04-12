# Library to allow filter feature on data.frames
library(dplyr)

# Download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip", method="curl" )
unzip("data.zip")

# Read in data, but with ";" separator
alldata  <-  read.csv("household_power_consumption.txt", sep = ";")

# Convert date variables from a character format to POSIXlt time format
alldata$Date <- strptime(alldata$Date, format="%d/%m/%Y")
alldata$Date  <- as.Date(alldata$Date)

# Observations subsetted between specified dates; put into data.frame "workingdata"
workingdata  <- filter(alldata, Date >= "2007-02-01" & Date <= "2007-02-02")
workingdata$Global_active_power <- as.numeric(as.character(workingdata$Global_active_power))

# Use the mutate function to merge the date and time together
workingdata  <- mutate(workingdata, 
                       datetime = as.POSIXct(paste(Date,Time),
                                             format ="%Y-%m-%d %H:%M:%S"))

# Plot the data, as type "l" for line, and set the x and y labels.
with(workingdata, 
     plot(datetime, Global_active_power, 
          type="l",
          xlab="",
          ylab="Global Active Power (kilowatts)",
          # Scaled axis annotations and labels to 80%, to better fit the 480x480 PNG image.
          cex.axis=0.8,
          cex.lab=0.8))

title(main="Plot 2", adj=0)    # adj=0 produces left-justified text
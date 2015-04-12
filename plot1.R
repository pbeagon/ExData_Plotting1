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

# Draw a histrogram, setting the breaks, bar colour, main title and x limits but *not* axes
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
hist(workingdata$Global_active_power,
     breaks=seq(0,8,0.5),
     freq=TRUE,
     col="red",
     main="Global Active Power",
     xlim=c(0,6),
     xlab="Global Active Power (kilowatts)",
     axes=FALSE
     )

# Draw customised axes on the bottom then the left, with 80% scaled text.
# The smaller axes' text all appear in the 480x480 .png image.
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2), cex.axis=0.8)
axis(side=2, at=seq(0,1200,200), labels=seq(0,1200,200), cex.axis=0.8)

title(main="Plot 1", adj=0, outer=TRUE)    # adj=0 produces left-justified text

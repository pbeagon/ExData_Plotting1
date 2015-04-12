# Library to allow dyply filter and mutate feature on data.frames
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

# Convert variable values to numeric datatype from factor datatype
workingdata$Global_active_power <- as.numeric(as.character(workingdata$Global_active_power))
workingdata$Sub_metering_1 <- as.numeric(as.character(workingdata$Sub_metering_1))
workingdata$Sub_metering_2 <- as.numeric(as.character(workingdata$Sub_metering_2))
workingdata$Sub_metering_3 <- as.numeric(as.character(workingdata$Sub_metering_3))
workingdata$Voltage <- as.numeric(as.character(workingdata$Voltage))
workingdata$Global_reactive_power <- as.numeric(as.character(workingdata$Global_reactive_power))


# Use the mutate function to merge the date and time together
workingdata  <- mutate(workingdata, 
                       datetime = as.POSIXct(paste(Date,Time),
                                             format ="%Y-%m-%d %H:%M:%S"))

#####  Plots in a 2 x 2 layout  #################
par(mfrow = c(2, 2), mar = c(3, 3, 1, 1), oma = c(1, 0, 1, 0), mgp = c(2,1,0))

###########  Plot 1  #############
# Plot the data, as type "l" for line, and set the x and y labels.
with(workingdata, 
     plot(datetime, Global_active_power, 
          type="l",
          xlab="",
          ylab="Global Active Power", 
          cex.axis=0.6,               # Scaled axis annotations and labels to 60%
          cex.lab=0.5))

###########  Plot 2  #############
with(workingdata, 
     plot(datetime, Voltage, 
          type="l",
          ylab="Voltage", 
          yaxt="n",
          cex.axis=0.6,   # Scaled axis annotations and labels to 60% 
          cex.lab=0.6))
axis(2, at=seq(234,246,2), labels=seq(234,246,2), cex.axis=0.6)

###########  Plot 3  #############
with(workingdata, 
     plot(datetime, Sub_metering_1,
          type="l",               # Set type plot as "line"
          xlab="",                # Empty X axis label
          ylab="Energy sub metering",
          ylim=c(0,40),
          yaxt="n",               # Y axis is labelled and annotated below in axis() 
          cex.axis=0.6,           # Scaled axis annotations to 80%
          cex.lab=0.5))           # Scaled axis labels to 80%
axis(2, at=seq(0,30,10), labels=seq(0,30,10), cex.axis=0.6)

par(new=T)                        # should not clean the frame before drawing the next new plot
with (workingdata, 
      plot(datetime, Sub_metering_2,
           type="l",
           axes=FALSE,            # Do not draw new X and Y axes
           col="red",             # Colour the plot 
           xlab="",ylab="",       # Empty X & Y axis labels
           ylim=c(0,40)))         # Repeat the Y axis limits from 1st plot

par(new=T)                        # should not clean the frame before drawing the next new plot
with (workingdata, 
      plot(datetime, Sub_metering_3,
           type="l",
           axes=FALSE,            # Do not draw new X and Y axes
           col="blue",            # Colour the plot 
           xlab="",ylab="",       # Empty X & Y axis labels
           ylim=c(0,40)))         # Repeat the Y axis limits from 1st plot

legend("top", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1,                        # Set legend as line type
       col=c("black","red","blue"),  # Re-use same colouts as plots 
       bty="n",
       cex=0.5)

###########  Plot 4  #############
with(workingdata, 
     plot(datetime, Global_reactive_power, 
          type="l",
          cex.axis=0.6,   # Scaled axis annotations and labels to 60% 
          cex.lab=0.6))
mtext("Plot 4", outer = TRUE, adj=0)    # adj=0 produces left-justified text


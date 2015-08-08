# This file contains commands that will create a line graph of the energy sub
# metering vs. time for the dates Feb. 1 and Feb. 2, 2007.

# Import a reader function in myreader.R to save space in this script.
source("myreader.R")

# Read the data from the data file
febdata <- myreader(file = "household_power_consumption.txt",
                    dates = c("01/02/2007", "02/02/2007"))

# Create a character string from the Date and Time column in febdata. This will
# be in the format dd/mm/yyyy hh:mm:ss
stamp <- paste(febdata$Date, febdata$Time)
# Convert the time stamps to POSIXlt values
chrons <- as.POSIXlt(stamp, format = "%d/%m/%Y %H:%M:%S")

# Open the PNG graphics device
png(filename = "plot3.png")

# Plot the data for sub meter 1.
plot(x = chrons, y = as.numeric(febdata$Sub_metering_1), type = "l", xlab = "",
     ylab = "Energy sub metering")

# Plot the data for sub meter 2
lines(x = chrons, y = as.numeric(febdata$Sub_metering_2), col = "red")

# Plot the data for sub meter 3
lines(x = chrons, y = as.numeric(febdata$Sub_metering_3), col = "blue")

# Add a legend to the plot
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")

# Close the graphics device.
dev.off()

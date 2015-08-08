# This file contains commands that will create four separate graphs of global
# active power, voltage, Energy sub metering, and global reactive power vs. date
# and time.

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
png(filename = "plot4.png")

par(mfrow = c(2,2))

# Make the global active power vs. date-time plot in the top left corner.
        plot(x = chrons, y = as.numeric(febdata$Global_active_power), type = "l",
             xlab = "", ylab = "Global Active Power")

# Make the Voltage vs. date-time plot in the top right corner.
        plot(x = chrons, y = as.numeric(febdata$Voltage), type = "l",
             xlab = "datetime", ylab = "Voltage")

# Make the energy sub metering vs. date-time plot in the lower left corner.
        # Plot the data for sub meter 1.
        plot(x = chrons, y = as.numeric(febdata$Sub_metering_1), type = "l",
             xlab = "", ylab = "Energy sub metering")

        # Plot the data for sub meter 2
        lines(x = chrons, y = as.numeric(febdata$Sub_metering_2), col = "red")
        
        # Plot the data for sub meter 3
        lines(x = chrons, y = as.numeric(febdata$Sub_metering_3), col = "blue")
        
        # Add a legend to the plot
        legend(x = "topright", bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"), lty = "solid")

# Make the global reactive power vs. date-time plot in the lower right.
        plot(x = chrons, y = as.numeric(febdata$Global_reactive_power),
             type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Close the graphics device.
dev.off()

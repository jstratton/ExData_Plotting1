# This file contains commands that will create a line graph of global active
# power vs. time for the dates Feb. 1 and Feb. 2, 2007.

# Import a reader function in myreader.R to save space in this script.
source("myreader.R")

# Read the data from the data file
febdata <- myreader(file = "household_power_consumption.txt",
                    dates = c("01/02/2007", "02/02/2007"))

# Convert global active power to numeric values
global_active_pow <- as.numeric(febdata$Global_active_power)

# Create a character string from the Date and Time column in febdata. This will
# be in the format dd/mm/yyyy hh:mm:ss
stamp <- paste(febdata$Date, febdata$Time)
# Convert the time stamps to POSIXlt values
chrons <- as.POSIXlt(stamp, format = "%d/%m/%Y %H:%M:%S")

# Open the PNG graphics device
png(filename = "plot2.png")

# Draw the bars.
plot(x = chrons, y = global_active_pow, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Close the graphics device.
dev.off()

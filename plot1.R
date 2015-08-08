# This file contains commands that will create a histograph of global active
# power on the dates Feb. 1 and Feb. 2, 2007.

# I stored a reader program in myreader.R to save space in this script.
source("myreader.R")

# Read the data from the data file
febdata <- myreader(file = "household_power_consumption.txt",
                    dates = c("01/02/2007", "02/02/2007"))

# Convert global active power to a numeric value
global_active_pow <- as.numeric(febdata$Global_active_power)

# Open the PNG graphics device
png(filename = "plot1.png")

# Draw the bars.
hist(x = global_active_pow, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", axes = FALSE)

# Add axes to the plot
axis(side = 1, at = seq(from = 0, to = 6, by = 2))
axis(side = 2, at = seq(from = 0, to = 1200, by = 200))

# Close the graphics device.
dev.off()

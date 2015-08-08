# This file contains commands that will create a histograph of global active
# power on the dates Feb. 1 and Feb. 2, 2007.

# This function reads the dataset and returns it as a dataframe. The data is
# returned in character format.
myreader <- function(file, datadir = getwd(), dates = NULL){
        # file is the name of the file
        
        # datadir is the directory the file is located in. By default this is the
        # current working directory.
        
        # dates is a character vector containing the specific dates to return.
        # dates are in d/m/y format and support a dd/mm/yyyy format.
        dates <- as.Date(dates, "%d/%m/%Y")
        
        # Create a path to the data set from file.
        path <- paste(datadir, "/", file, sep = "")
        
        # Make sure that the specified file exists
        if(file.exists(path)){
                # Read the data from the dateset
                epc <- read.table(file = path, header = TRUE, sep = ";",
                                  na.strings = "?", colClasses = "character")
                
                # Check to see if the user limited the load by start date
                if(is.null(dates)){
                        # In this case, the user wants to load all of
                        # the data in the dataset.
                        return(epc)
                }
                else{
                        # In this case, the user wants specific dates
                        
                        # Split the electric power consumption data by date to
                        # make searching it go faster.
                        epcsplit <- split(epc, epc$Date)
                        
                        # Determine which days need to be returned.
                        days <- sapply(epcsplit, function(x){
                                # Returns part of the data if any dates
                                # correspond to the dates the user is
                                # interested in.
                                if(sum(dates == as.Date(x[1,1], "%d/%m/%Y")) > 0){
                                        return(TRUE)}
                                
                                else{return(FALSE)}
                                
                        })
                        
                        # Create a data.frame out of the selected days.
                        output <- do.call("rbind", epcsplit[days])
                        # Eliminate the output's row names to reduce clutter.
                        row.names(output) <- NULL
                        
                        return(output)
                }
        }
        
        else{stop("Error: File Not Found")}
}

# Use the above function to read the data from the data file, assuming it is
# saved in the working directory.
febdata <- myreader(file = "household_power_consumption.txt",
                    dates = c("01/02/2007", "02/02/2007"))

# Open the PNG graphics device
png(filename = "plot1.png")

# Draw the bars.
hist(x = as.numeric(febdata$Global_active_power), col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", axes = FALSE)

# Add axes to the plot
axis(side = 1, at = seq(from = 0, to = 6, by = 2))
axis(side = 2, at = seq(from = 0, to = 1200, by = 200))

# Close the graphics device.
dev.off()

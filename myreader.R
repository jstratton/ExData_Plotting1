# This file contains the commands for specifically reading the electric power
# consumption data set.

# This function reads the dataset and returns it as a dataframe.
myreader <- function(file, dates){
        # file is the name of the file, assuming that the file is in the working
                # directory.
        
        # dates is a character vector containing the date range to read.
        
        # Create a path to the data set from file.
        path <- paste(getwd(), "/", file, sep = "")
}
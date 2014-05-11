## Plot a Global_active_power Histogram from 1/2/2007 to 2/2/2007
## Example: plot1("household_power_consumption.txt")
plot1<-function(fileName) {
    ## Load sqldf, which will be used to query based on Dates
    require("sqldf")
    
    ## SQL query statement
    sqlQuery <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
    
    ## Read data based on SQL query
    data <- suppressWarnings(read.csv.sql(fileName, sql=sqlQuery, sep=";"))
    
    ## str(data)
    
    ## Histogram with red color, x label, and title
    hist(data$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main="Global Active Power")
    
    ## Copy the image from the window to the png file
    dev.copy(png, file="plot1.png")
    
    ## Turn off the device
    dev.off()
}

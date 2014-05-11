## Plot a Global_active_power line chart from 1/2/2007 to 2/2/2007
## Example: plot2("household_power_consumption.txt")
plot2<-function(fileName) {
    ## Load sqldf, which will be used to query based on Dates
    require("sqldf")
    
    ## SQL query statement
    sqlQuery <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
    
    ## Read data based on SQL query
    data <- suppressWarnings(read.csv.sql(fileName, sql=sqlQuery, sep=";"))
    
    ## Combining Date and Time
    data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M") 
      
    ## Line chart with x label
    plot(data$DateTime, data$Global_active_power, pch=NA_integer_, xlab='', ylab='Global Active Power (kilowatts)')
    lines(data$DateTime, data$Global_active_power)
    
    ## Copy the image from the window to the png file
    dev.copy(png, file="plot2.png")
    
    ## Turn off the device
    dev.off()
}

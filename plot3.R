## Plot a Energy sub metering line chart from 1/2/2007 to 2/2/2007
## Example: plot3("household_power_consumption.txt")
plot3<-function(fileName) {
  ## Load sqldf, which will be used to query based on Dates
  require("sqldf")
  
  ## SQL query statement
  sqlQuery <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  
  ## Read data based on SQL query
  data <- suppressWarnings(read.csv.sql(fileName, sql=sqlQuery, sep=";"))
  
  data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M") 
  
  ## Line chart with x label
  plot(data$DateTime, data$Sub_metering_1, pch=NA_integer_, xlab='', ylab='Energy sub metering')
  lines(data$DateTime, data$Sub_metering_1)
  lines(data$DateTime, data$Sub_metering_2, col='red')
  lines(data$DateTime, data$Sub_metering_3, col='blue')
  legend('topright', lty=c(1, 1, 1), col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
  
  ## Copy the image from the window to the png file
  dev.copy(png, file="plot3.png")
  
  ## Turn off the device
  dev.off()
}

## Plot Multiple Base Plots from 1/2/2007 to 2/2/2007
## Example: plot4("household_power_consumption.txt")
plot4<-function(fileName) {
  ## Load sqldf, which will be used to query based on Dates
  require("sqldf")
  
  ## SQL query statement
  sqlQuery <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  
  ## Read data based on SQL query
  data <- suppressWarnings(read.csv.sql(fileName, sql=sqlQuery, sep=";"))
  
  data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M") 
  
  ## Layout
  par(mfrow=c(2,2), mar=c(5,5,1,1))
  
  ## Plot
  with(data, {       
    plot(DateTime, Global_active_power, pch=NA_integer_, xlab='', ylab='Global Active Power')
    lines(DateTime, Global_active_power)
    
    plot(DateTime, Voltage, pch=NA_integer_, xlab='datetime', ylab='Voltage')
    lines(DateTime, Voltage)
      
    plot(data$DateTime, Sub_metering_1, pch=NA_integer_, xlab='', ylab='Energy sub metering')
    lines(data$DateTime, Sub_metering_1)
    lines(data$DateTime, Sub_metering_2, col='red')
    lines(data$DateTime, Sub_metering_3, col='blue')
    legend('topright', lty=c(1, 1, 1), col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), cex=0.5, pt.cex = cex, box.lwd=0, box.col='white', inset=0.05)
    
    plot(DateTime, Global_reactive_power, pch=NA_integer_, xlab='datetime')
    lines(DateTime, Global_reactive_power)
  })
  
  ## Copy the image from the window to the png file
  dev.copy(png, file="plot4.png")
  
  ## Turn off the device
  dev.off()
}

## Download, unzip, and read the dataset:
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "Household_power_consumption.zip"
datafile <- "household_power_consumption.txt"

if (!file.exists(filename)){
  download.file(dataURL, filename, method="curl")
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}
HHPowConsumption <- read.table(file = datafile, header = TRUE,sep = ";",na.strings = "?", stringsAsFactors = FALSE, dec = ".")
HHPowConsumption$Date <- as.Date(HHPowConsumption$Date, format = "%d/%m/%Y")

## Subset the Data
HHPowCon <- subset(HHPowConsumption,subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(HHPowConsumption)

## Converting the Dates
DatetoRDate <- paste(as.Date(HHPowCon$Date),HHPowCon$Time)
HHPowCon$DateTime <- as.POSIXct(DatetoRDate)

## Plot 4
png("plot4.png", width = 480, height = 480) ## Sets the graphic device to PNG and creates the file
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) ## Sets the parameters for the 
                                                  ## 2-row/2-col of matrix of plots
with(HHPowCon, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="") ## Plots first graph (Top-Left)
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="") ## Plots second graph (Top-Right)
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) ## Plots third graph (Bottom-Left)
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="") ## Plots fourth graph (Bottom-Right)
})
dev.off()
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

## Plot 1
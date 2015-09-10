## reading the data from downloaded file in WD
if (!file.exists("household_power_consumption.txt")) 
{
  getwd()
  stop ("file not found in working dir: household_power_consumption.txt")
}
## read the data from the file
filename = "household_power_consumption.txt"
epcdata <- read.table(filename, sep =";", header = TRUE, na.strings = "?", quot="")

## convert the time and date , time into timestamp to avoid adding current date
epcdata$Time <- strptime(paste(epcdata$Date, epcdata$Time), "%d/%m/%Y %H:%M:%S")
epcdata$Date <- as.Date(epcdata$Date, "%d/%m/%Y")

## subset to use only the dates 2007-02-01 and 2007-02-02
epcdata <- epcdata[epcdata$Date == "2007-02-01" | epcdata$Date =="2007-02-02",]

## generate the plot
## on screen device
hist(epcdata$Global_active_power, xlab ="Global Active Power (kilowatts)",col= 2, main = "Global Active Power")

## copy from screen device to .png file
dev.copy(png, file = "plot1.png") ## Copy screen plot to a PNG file
dev.off() ## close the png file
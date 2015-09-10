#### reading the data from downloaded file in WD
if (!file.exists("household_power_consumption.txt")) 
{
  getwd()
  stop ("file not found in working dir: household_power_consumption.txt")
}
## read the data from the file
filename = "household_power_consumption.txt"
epcdata <- read.table(filename, sep =";", header = TRUE, na.strings = "?", quot="")
##
## convert the time and date , time into timestamp to avoid adding current date
epcdata$Time <- strptime(paste(epcdata$Date, epcdata$Time), "%d/%m/%Y %H:%M:%S")
epcdata$Date <- as.Date(epcdata$Date, "%d/%m/%Y")

## subset to use only the dates 2007-02-01 and 2007-02-02
epcdata <- epcdata[epcdata$Date == "2007-02-01" | epcdata$Date =="2007-02-02",]

## generate the plot3 and output
## to file immediately
## making sure that the days are in English
Sys.setlocale("LC_TIME", "English")
## set up png device
png(filename ="plot3.png", width = 960 , height = 960) ## double the  default size
## generate the plot
with(epcdata, plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab = "" ,type ="l" ))
with(epcdata, points(Time, Sub_metering_2,col = "red", type ="l"))
with(epcdata, points(Time, Sub_metering_3,col = "blue", type ="l"))
legend( "topright", lty = "solid", col = c("black","red","blue"), colnames(epcdata)[7:9])

dev.off() ## close the png file
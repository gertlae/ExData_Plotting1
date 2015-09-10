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
png(filename ="plot4.png", width = 480 , height = 480) 

## generate the plot

## display 2 x 2 graphs
par(mfcol = c(2, 2))

## the first one: global active power
with(epcdata, {plot(Time, Global_active_power, ylab = "Global Active Power", xlab = "" ,type ="l" )

## the second one: energy submerting
               {plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab = "" ,type ="l" )
                points(Time, Sub_metering_2,col = "red", type ="l")
                points(Time, Sub_metering_3,col = "blue", type ="l")
                legend( "topright", lty = "solid", col = c("black","red","blue"), colnames(epcdata)[7:9], bty ="n")}

## the third one: voltage
              plot(Time, Voltage, ylab = "voltage", xlab = "datetime" ,type ="l" )

## the fouth one: global reactive power
              plot(Time, Global_reactive_power, ylab = "Global_reactive_power", xlab ="datetime" ,type ="l")
              })

dev.off() ## close the png file
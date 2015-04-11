##EY Spahn for Coursera/JHU Exploratory Data Analytics
##Apr 8, 2015
##plot1.R
##FOR DATA FROM FEB 2007
##Histogram of Global Active Power (kilowatts) - column 4
# 
# Data Information:    
# 1.date: Date in format dd/mm/yyyy 
# 2.time: time in format hh:mm:ss 
# 3.global_active_power: household global minute-averaged active power (in kilowatt) 
# 4.global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
# 5.voltage: minute-averaged voltage (in volt) 
# 6.global_intensity: household global minute-averaged current intensity (in ampere) 
# 7.sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). 
# 8.sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. 
# 9.sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


#If the unzipped file does not exist, download and unzip it
if (!file.exists("househhold_power_consumption.txt")) {
    #download zip file
    url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile="householdpoweruse.zip")
    downloadDate<-date()
    
    #unzip file
    unzip("householdpoweruse.zip") #unzips to "household_power_consumption.txt"
} 


#read in the Date, Time & Global_active_power columns (col 1, 2, 3) 
data<-read.table("household_power_consumption.txt", header=TRUE,
                 sep=";", stringsAsFactors=FALSE, na.strings="?",
                 colClasses= c("character", "character", "numeric", rep("NULL",6)))
datetime<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#set boundaries of times in question
begintime<-strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
endtime<-strptime("3/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
#find indicies corresponding to data in this time frame
validind<-which(datetime>=begintime & datetime<endtime)

#Plot histogram for Feb 2007
hist(data$Global_active_power[validind], col="red",
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

#Set up png device
dev.copy(png, file="plot1.png",width = 480, height = 480, units = "px")

#Close out png file
dev.off()


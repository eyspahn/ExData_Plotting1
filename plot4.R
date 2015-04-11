##EY Spahn for Coursera/JHU Exploratory Data Analytics
##Apr 8, 2015
##plot4.R

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
if (!file.exists("househhold_power_consumption.txt"))  {
    #download zip file
    url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"    download.file(url, destfile="householdpoweruse.zip")
    downloadDate<-date()
    filename="householdpoweruse.zip"
    #Note, file contains "household_power_consumption.txt"
    
    #unzip file
    unzip("householdpoweruse.zip") #unzips to "household_power_consumption.txt"
}


#read in the data
data<-read.table("household_power_consumption.txt", header=TRUE,
                 sep=";", stringsAsFactors=FALSE, na.strings="?",
                 colClasses= c("character", "character", rep("numeric",7)))
datetime<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
#add these dates to data frame
data$datetime<-datetime

#set boundaries of times in question
begintime<-strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
endtime<-strptime("3/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
#find indicies corresponding to data in this time frame
validind<-which(datetime>=begintime & datetime<endtime)


#Set up png device
dev.copy(png, file="plot4.png",width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

#Plot sub metering data
#set up plotting window

 
#topleft
plot(datetime[validind], data$Global_active_power[validind], type="l",
     ylab="Global Active Power", xlab=" ")

#topright
plot(data$datetime[validind], data$Voltage[validind], type="l",
     ylab="Voltage", xlab="datetime")

#bottlom left
plot(data$datetime[validind], data$Sub_metering_1[validind],
     ylab="Energy sub metering", xlab="", type="n")

with(data, lines(data$datetime[validind], data$Sub_metering_1[validind],
             type="l", col="black"))
with(data, lines(data$datetime[validind], data$Sub_metering_2[validind],
             type="l", col="red"))
with(data, lines(data$datetime[validind], data$Sub_metering_3[validind],
             type="l", col="blue"))
legend("topright", col=(c("black", "red", "blue")), lty=1, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#bottom right
plot(datetime[validind], data$Global_reactive_power[validind], type="l",
     ylab="Global_reactive_power", xlab="datetime")
    

#Close out png file
dev.off()


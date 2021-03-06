#Get Data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
mydata <- read.table(unz(temp, "household_power_consumption.txt"),header = TRUE, sep=";", na.strings = "?")
unlink(temp)

#Subset data for 2 day period in February, 2007
mydata2 <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007")

#convert to calender dates and combine column with time of day
mydata2$Date <- as.Date(mydata2$Date, "%d/%m/%Y")
mydata2 <- cbind(mydata2, "WeekDay" = as.POSIXct(paste(mydata2$Date, mydata2$Time)))

#Create line plot with Weekday on the x-axis and Global_active_power on the y-axis
with(mydata2, plot(Global_active_power ~ WeekDay, type= "l", xlab= "", ylab="Global Active Power (kilowatts)"))

#Create the PNG File
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()    #Closes the PNG device
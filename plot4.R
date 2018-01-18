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

#Create the four plots
par(mfrow=c(2,2))
#First plot (top left)
with(mydata2, plot(Global_active_power ~ WeekDay, type = "l", xlab = " ", ylab = "Global Active Power"))
#Second plot (top right)
with(mydata2, plot(Voltage ~ WeekDay, type = "l", xlab = "datetime", ylab = "Voltage"))
#Third plot (bottom left)
with(mydata2, plot(Sub_metering_1 ~ WeekDay, type = "l", xlab = " ", ylab = "Energy sub metering"))
with(mydata2, lines(Sub_metering_2 ~ WeekDay, col = "red"))
with(mydata2, lines(Sub_metering_3 ~ WeekDay, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n", xpd = TRUE, inset = c(0.2, -0.07))
#Fourth plot (bottom right)
with(mydata2, plot(Global_reactive_power ~ WeekDay, type="l", xlab = "datetime"))

#Create the PNG File
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()    #Closes the PNG device
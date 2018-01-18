#Get Data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
mydata <- read.table(unz(temp, "household_power_consumption.txt"),header = TRUE, sep=";", na.strings = "?")
unlink(temp)

#Subset data for 2 day period on February, 2007
mydata2 <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007")
 
#Create Histogram and Annotate
with(mydata2, hist(as.numeric(as.character(Global_active_power)),
     main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))
title(main = "Global Active Power")

#Create the PNG File
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()    #Closes the PNG device
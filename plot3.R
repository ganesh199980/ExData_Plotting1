powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


# coverting to time data type

powerdata$Date<- as.Date(powerdata$Date,"%d/%m/%Y")

# subsetting 
powerdata<- subset(powerdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))


powerdata <- powerdata[complete.cases(powerdata),]

dateTime <- paste(powerdata$Date, powerdata$Time)

dateTime <- setNames(dateTime, "DateTime")


powerdata <- powerdata[ ,!(names(powerdata) %in% c("Date","Time"))]



powerdata <- cbind(dateTime, powerdata)


powerdata$dateTime <- as.POSIXct(dateTime)

png("plot3.png", width=480, height=480)



with(powerdata, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()
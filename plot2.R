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

png("plot2.png", width=480, height=480)



plot(powerdata$Global_active_power~powerdata$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")



dev.off()


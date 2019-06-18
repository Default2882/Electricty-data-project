library(lubridate)
data <- read.csv("data1.txt", sep = ";", colClasses = c(rep("character", 7)))
date <- data$Date
date <- dmy(date)
check <- c(ymd("20070201"), ymd("20070202"))
log <- date == check[1] | date == check[2]
date <- date[date == check[1] | date == check[2]]
data <- data[log,]
days <- weekdays(date)
time <- data$Time
time <- strptime(time, format = "%H:%M:%S")
time[1:1440] <- format(time[1:1440], "2007-02-01 %H:%M:%S")
time[1441:2880] <- format(time[1441:2880], "2007-02-02 %H:%M:%S")
par(mfrow = c(2,2))
par(mar = c(2,2,1,1))
png("plot4.png")
     plot(time, as.numeric(as.character(data$Global_active_power)), ylab = "Global active Power (kilowatts)", type = "l")
     plot(time, as.numeric(as.character(data$Voltage)), type = "l" , xlab = "datetime" , ylab = "Voltage")
     plot(time, as.numeric(data$Sub_metering_1),type="n",ylab="Energy sub metering")
     with(data,lines(time,as.numeric(as.character(Sub_metering_1))))
     with(data,lines(time,as.numeric(as.character(Sub_metering_2)),col="red"))
     with(data,lines(time,as.numeric(as.character(Sub_metering_3)),col="blue"))
     legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
     plot(time,as.numeric(as.character(data$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
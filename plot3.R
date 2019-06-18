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
png("plot3.png")
plot(time,as.numeric(data$Sub_metering_1),type="n",xlab="",ylab="Energy sub metering")
with(data,lines(time,as.numeric(as.character(Sub_metering_1))))
with(data,lines(time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(data,lines(time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
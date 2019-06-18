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
png("plot2.png")
plot(time, as.numeric(as.character(data$Global_active_power)), ylab = "Global active Power (kilowatts)", type = "l")
dev.off()
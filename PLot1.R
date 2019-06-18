library(lubridate)
data <- read.csv("data1.txt", sep = ";", colClasses = c(rep("character", 7)))
date <- data$Date
date <- dmy(date)
check <- c(ymd("20070201"), ymd("20070202"))
log <- date == check[1] | date == check[2]
data <- data[log,]
png("plot1.png")
hist(as.numeric(data$Global_active_power) , xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
library(dplyr)
# reading & subseting data
tempdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
dataset <- tbl_df(tempdata)
rm(tempdata)
data1 <- filter(dataset, Date == "1/2/2007")
data2 <- filter(dataset, Date == "2/2/2007")
data <- merge(data1, data2, all = TRUE)
rm(dataset)
rm(data1)
rm(data2)
# formating data
data <- mutate(data, Date = as.Date(Date, format = "%d/%m/%Y"))
data <- mutate(data, Time = paste(Date, Time))
# ploting data
par(mfrow=c(2,2))
# plot[1,1]
plot(strptime(data$Time, format = "%Y-%m-%d %H:%M:%S"), data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
# plot[1,2]
plot(strptime(data$Time, format = "%Y-%m-%d %H:%M:%S"), data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
# plot[2,1]
plot(strptime(data$Time, format = "%Y-%m-%d %H:%M:%S"), data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(strptime(data$Time, format = "%Y-%m-%d %H:%M:%S"), data$Sub_metering_2, col = "red")
lines(strptime(data$Time, format = "%Y-%m-%d %H:%M:%S"), data$Sub_metering_3, col = "blue")
legend("topright", "x,y", c("Sub_metering_1", "Sub_metering_2" , "Sub_metering_3"), lty = 1, col = c('black', 'red', 'blue'), bty = "n", cex = 1)
# plot[2,2]
plot(strptime(data$Time, format = "%Y-%m-%d %H:%M:%S"), data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

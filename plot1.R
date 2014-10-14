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
hist(as.numeric(data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

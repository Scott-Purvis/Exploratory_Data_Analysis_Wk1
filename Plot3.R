library(dplyr)
library(tidyr)
library(lubridate)
library(data.table)

#Download and unzip the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp, mode = "wb")
unzip(temp, "household_power_consumption.txt")
pcdata <- fread("household_power_consumption.txt",
                sep = ";",
                header = TRUE,
                na.strings = "?",
                colClasses = c(Sub_metering_1="integer",Sub_metering_2 = "numeric", Sub_metering_3="numeric"))

pcdata$Date <- dmy(pcdata$Date) #converts Date Variable to Date class
pcdata <- pcdata %>% filter(Date >= "2007-02-01" & Date<= "2007-02-02") # filters dataframe by dates

#Combine date and time variable
pcdata$DateTime <- as.POSIXct(paste(pcdata$Date,pcdata$Time))

plot(pcdata$Sub_metering_1~pcdata$DateTime,
     type="l",
     xlab = "",
     ylab = "Energy sub metering")
lines(pcdata$DateTime, pcdata$Sub_metering_2, col = "red")
lines(pcdata$DateTime, pcdata$Sub_metering_3, col = "blue")
legend("top",
       legend=c("Sub_meter1","Sub_meter2","Sub_meter3"),
       lty = c(1,1),
       col = c("black", "red", "blue"),
       cex = 0.75,
       xpd = FALSE)

# Save to PNG
dev.copy(png,"Plot3.png")
dev.off()

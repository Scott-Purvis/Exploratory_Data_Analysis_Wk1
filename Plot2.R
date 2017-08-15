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

#Plot
plot(pcdata$Global_active_power~pcdata$DateTime,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")


# Save to PNG
dev.copy(png,"Plot2.png")
dev.off()
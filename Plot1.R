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


pcdata$Date <- dmy(pcdata$Date) #converts Date variable to Date class
pcdata <- pcdata %>% filter(Date >= "2007-02-01" & Date<= "2007-02-02") # filters dataframe by dates


#Plot
hist(pcdata$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     main = "Global Active Power",
     xlim = c(0,6)
     )


# Save to PNG
dev.copy(png,"Plot1.png")
dev.off()
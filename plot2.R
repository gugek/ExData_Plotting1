# project 1 plot2.R
setwd("~/Desktop/Coursera/exploratory/project1")
library(dplyr)
library(data.table)
library(lubridate)

data_url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if (!file.exists('household_power_consumption.zip')) {
    download_date <- date()
    download.file(data_url, 'household_power_consumption.zip', method = 'curl')
}

if (!file.exists('household_power_consumption.txt')) {
    unzip_date <- date()
    unzip('household_power_consumption.zip')
}

data <- fread('household_power_consumption.txt', na.strings="?")

dt.data <- tbl_dt(data)

# fix the date for a filter
dt.data$LDate <- dmy(dt.data$Date)

# subset for only the 2007-02-01 and 2007-02-02 data
dt.data.subset <- filter(dt.data, LDate == ymd('20070201') | 
                                  LDate == ymd('20070202'))

# make sure the labels end up days of week POSIXlt?
datetimes <- strptime(paste(dt.data.subset$Date, 
                            dt.data.subset$Time, sep=" "),
                      "%d/%m/%Y %H:%M:%S")
power <- select(dt.data.subset, Global_active_power)
# set up device
png(file="plot2.png", width=480, height=480)
# plot
plot(datetimes, power, type="lines", xlab="", ylab="Global Active Power (kilowatts)")
# close our device
dev.off()




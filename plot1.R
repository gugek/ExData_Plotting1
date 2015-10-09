# project 1 plot1.R
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

# fix the date
dt.data$Date <- dmy(dt.data$Date)
# Fix the time
dt.data$Time <- hms(dt.data$Time)

# subset for only the 2007-02-01 and 2007-02-02 data
dt.data.subset <- filter(dt.data, Date == ymd('2007-02-01') | 
                                  Date == ymd('2007-02-02'))

# set up device
png(file="plot1.png", height=480, width=480)
# make histogram
hist(data.matrix(select(dt.data.subset, Global_active_power)), 
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
# close our device
dev.off()








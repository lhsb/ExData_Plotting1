require(data.table)

# Download data set
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "exdata_data_household_power_consumption.zip",
              method = "curl")

# unzip the zipped data set
unzip(zipfile="exdata_data_household_power_consumption.zip", files="household_power_consumption.txt")

# read data set but only from the dates 2007-02-01 and 2007-02-02
df = fread("household_power_consumption.txt", sep=";", 
           skip=66637,nrows = 2880)

# rename variables
setnames(df,
         c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9"),
         c("Date", "Time", "Global_active_power", "Global_reactive_power",
           "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
           "Sub_metering_3"))

# initiate PNG device
png("plot1.png", width=480, height=480)

# create plot
hist(df[,Global_active_power], main="Global Active Power", col="red",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

# close PNG device
dev.off()

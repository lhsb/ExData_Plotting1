invisible(Sys.setlocale("LC_MESSAGES", "C"))
invisible(Sys.setlocale("LC_TIME", "C"))

# Download data set
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "exdata_data_household_power_consumption.zip",
              method = "curl")

# unzip the zipped data set
unzip(zipfile="exdata_data_household_power_consumption.zip", files="household_power_consumption.txt")

# read data set but only from the dates 2007-02-01 and 2007-02-02
df = read.csv("household_power_consumption.txt", sep=";", header=F,
              skip=66637, nrows = 2880, stringsAsFactors=F)

# rename variables
colnames(df) = c("Date", "Time", "Global_active_power", "Global_reactive_power",
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                 "Sub_metering_3")


# initiate PNG device
png("plot3.png", bg="transparent", width=480, height=480)

# format date and time
df$Date = strptime(paste(df[,1], df[,2]), "%d/%m/%Y %H:%M:%S")

# create plot
plot(df$Date, df$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(df$Date, df$Sub_metering_2, col="red")
lines(df$Date, df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)

# close PNG device
dev.off()

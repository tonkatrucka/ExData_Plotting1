# This script will produce plot4.png, a set of 4 exploratory graphs ####

# 1. Read the table in that is unzipped into the working folder ####
household.power.consumption <- 
  read.table("~/household_power_consumption.txt"
             ,header = TRUE
             ,sep = ";"
             ,stringsAsFactors = FALSE)

# 2. Date and number format conversion ####
options(warn = -1)
household.power.consumption$Date <- as.Date(household.power.consumption$Date,"%d/%m/%Y")
household.power.consumption$Time <- format(strptime(household.power.consumption$Time,"%H:%M:%S")
                                           , format="%H:%M:%S")
household.power.consumption$Global_active_power <- as.numeric(household.power.consumption$Global_active_power)

# 3. Subset based on dates required ####
hhpc <- subset(household.power.consumption, Date >= "2007-02-01" & Date <= "2007-02-02")
hhpc$DateTime <- strptime(paste(hhpc$Date,hhpc$Time), "%Y-%m-%d %H:%M:%S")
hhpc$Day <- weekdays(hhpc$Date)
options(warn = 0)

# 4. plot4.png creation ####

dev.copy(png,"plot4.png")
par(mfrow=c(2,2))
plot(hhpc$DateTime,hhpc$Global_active_power,type = "l",ylab = "Global Active Power",xlab = "")
plot(hhpc$DateTime,hhpc$Voltage,type = "l", xlab = "datetime",ylab = "Voltage")
plot(hhpc$DateTime,hhpc$Sub_metering_1,type = "l"
     ,xlab = ""
     ,ylab = "Energy sub metering")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red", "blue"), lwd = 1,bty = "n")
lines(hhpc$DateTime,hhpc$Sub_metering_2,col="red")
lines(hhpc$DateTime,hhpc$Sub_metering_3,col="blue")
plot(hhpc$DateTime,hhpc$Global_reactive_power,xlab = "datetime",ylab="Global_reactive_power", type = "l")
dev.off()
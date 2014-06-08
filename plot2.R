# This script will produce plot2.png, a line graph of global active power over time ####

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

# 4. plot2.png creation ####
dev.copy(png,"plot2.png")
par(mfrow=c(1,1))
plot(hhpc$DateTime,hhpc$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)",xlab = "")
dev.off()
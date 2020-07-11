##################################################
## Exploratory Data Analysis - Course Project 1 ##
##################################################


## Read file & Data wrangling ##

# Read file as dataframe
EPC <- read.csv2(file = "household_power_consumption.txt",sep = ";" )

# Convert date format
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")

# Filter required dates
EPC <- EPC[EPC$Date == as.Date("2007-2-1") | EPC$Date == as.Date("2007-2-2"),]

# Rearranging the dataframe
Temp <- data.frame(paste(EPC$Date, EPC$Time))

names(Temp) <- "Date_Time"

EPC <- EPC[,-c(1,2)]

EPC <- cbind(Temp, EPC)

rm(Temp)

# Convert Date & Time into POSIXct
EPC$Date_Time <- as.POSIXct(EPC$Date_Time)

# Convert the rest of the coloumn to numeric
for (i in 2:8) {
  EPC[,i] <- as.numeric(as.character(EPC[,i]))
}


## PLot 4 ##

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(formula = Global_active_power ~ Date_Time, data = EPC, type="l", ylab = "Global Active Power (kilowatts)", xlab ="")

plot(formula = Voltage ~ Date_Time, data = EPC, type = "l", ylab = "Voltage (volt)", xlab="")

plot(formula = Sub_metering_1 ~ Date_Time, data = EPC, type="l", ylab ="Global Active Power (kilowatts)", xlab ="")
    lines(formula = Sub_metering_2 ~ Date_Time, data = EPC, col ='Red')
    lines(formula = Sub_metering_3 ~ Date_Time, data = EPC, col ='Blue')
    legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), bty="n",  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(formula = Global_reactive_power ~ Date_Time, data = EPC, type = "l", ylab = "Global Rective Power (kilowatts)",xlab ="")

# Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

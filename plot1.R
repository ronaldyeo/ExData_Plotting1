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


## PLot 1 ##

hist(EPC$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
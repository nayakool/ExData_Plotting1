temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep = ";",header = TRUE)
unlink(temp)
data$Time<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data_to_use<-data[data$Date>='2007-02-01' & data$Date<='2007-02-02',]
data_to_use$Global_active_power<-as.numeric(as.character(data_to_use$Global_active_power))

data_to_use$Sub_metering_1<-as.numeric(as.character(data_to_use$Sub_metering_1))
data_to_use$Sub_metering_2<-as.numeric(as.character(data_to_use$Sub_metering_2))
data_to_use$Sub_metering_3<-as.numeric(as.character(data_to_use$Sub_metering_3))

data_to_use$Voltage<-as.numeric(as.character(data_to_use$Voltage))
data_to_use$Global_reactive_power<-as.numeric(as.character(data_to_use$Global_reactive_power))

png(filename = "plot4.png",width = 480,height = 480)

par(mfrow=c(2,2))

#1st Graph
plot(data_to_use$Time,data_to_use$Global_active_power,type = "l",xlab="",ylab = "Global Active Power")

#2nd Graph
plot(data_to_use$Time,data_to_use$Voltage,type = "l",xlab="datetime",ylab = "Voltage")

#3rd Graph
plot(data_to_use$Time,data_to_use$Sub_metering_1,type="l",xlab = "",ylab = "Energy sub metering")
lines(data_to_use$Time,data_to_use$Sub_metering_2,col="RED")
lines(data_to_use$Time,data_to_use$Sub_metering_3,col="BLUE")
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","red","blue"))

#4th Graph
plot(data_to_use$Time,data_to_use$Global_reactive_power,type = "l",xlab="datetime",ylab = "Global_reactive_power")

dev.off()

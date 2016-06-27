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

png(filename = "plot3.png",width = 480,height = 480)

plot(data_to_use$Time,data_to_use$Sub_metering_1,type="l",xlab = "",ylab = "Energy sub metering")
lines(data_to_use$Time,data_to_use$Sub_metering_2,col="RED")
lines(data_to_use$Time,data_to_use$Sub_metering_3,col="BLUE")
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","red","blue"))
dev.off()

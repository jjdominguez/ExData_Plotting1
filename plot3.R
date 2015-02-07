data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

mydata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

Sys.setlocale("LC_TIME", "C")

png("plot3.png")
par(mfrow=c(1,1), cex.lab=0.8, cex.axis =0.8)
with(mydata, plot(Time, Sub_metering_1,                  
                  type="n",               
                  xlab="",
                  ylab="Energy sub metering"))
with(mydata, lines (Time, Sub_metering_1, col="black"))
with(mydata, lines (Time, Sub_metering_2, col="red"))
with(mydata, lines (Time, Sub_metering_3, col="blue"))
legend("topright" , 
       lty=1, 
       cex =0.8,
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

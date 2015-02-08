# data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
header <-read.table("household_power_consumption.txt",header=TRUE, nrows=1, sep=";")
data <-read.csv(pipe("grep ^[1-2]/2/2007 household_power_consumption.txt"), header=FALSE, sep=";")
colnames(data) <- colnames(header)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

mydata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

Sys.setlocale("LC_TIME", "C")


png("plot4.png")
par(mfrow=c(2,2), cex.lab=0.8, cex.axis =0.8)

with(mydata, plot(Time, Global_active_power,
                  type="l",
                  xlab="",
                  ylab="Global Active Power"))

with(mydata, plot(Time, Voltage,
                  type="l",
                  xlab="datetime"
))

with(mydata, plot(Time, Sub_metering_1,                  
                  type="n",
                  xlab="",
                  ylab="Energy sub metering"))
with(mydata, lines (Time, Sub_metering_1, col="black"))
with(mydata, lines (Time, Sub_metering_2, col="red"))
with(mydata, lines (Time, Sub_metering_3, col="blue"))
legend("topright", 
       lty=1, 
       col=c("black","red","blue"), 
       legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       bty = "n")

with(mydata, plot(Time, Global_reactive_power,
                  type="l",
                  xlab="datetime"
                  ))
dev.off()

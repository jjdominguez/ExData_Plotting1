# data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
header <-read.table("household_power_consumption.txt",header=TRUE, nrows=1, sep=";")
data <-read.csv(pipe("grep ^[1-2]/2/2007 household_power_consumption.txt"), header=FALSE, sep=";")
colnames(data) <- colnames(header)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

mydata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

png("plot1.png")
par(mfrow=c(1,1), cex.lab=0.8, cex.axis =0.8, cex.main=0.85)
with( mydata, hist(Global_active_power, 
                   col="red", 
                   xlab="Global Active Power (kilowatts)", 
                   main="Global Active Power"))
dev.off()

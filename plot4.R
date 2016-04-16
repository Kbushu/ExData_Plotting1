# Step 1 - Read the data
# Select the file (assuming it been downloaded 20Mb, see downloads/coursera)
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
file1 <- file.choose(new = FALSE)
# Get info on the raw data
initial <- read.table(file1, header = TRUE, nrows = 100, sep = ";", dec = ".")
classes <- sapply(initial, class)
# Read from 2007-02-01(line 66638) and 2007-02-02(line 69517) (2880 lines)
df <- read.table(file1, header = FALSE, skip = 66637, nrows = 2880, sep = ";", dec = ".")
# Set col names
names(df) <- names(initial)
# strptime()  and as.Date()
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- strptime(x = as.character(paste(df$Date, df$Time)), format = "%Y-%m-%d %H:%M:%S")

# Step 2 - Create the plot, base plotting
png(filename = "plot4.png", width = 480, height = 480)
# Set 2 x 2 pairs
        par(mfrow=c(2,2))
# Plot Top Left
        plot(x = df$Time,y = df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
# Plot Top Right
        plot(x = df$Time,y = df$Voltage, type = "l", xlab = "", ylab = "Voltage")
# Plot Bottom Left
        x <- df$Time
        m1 <- df$Sub_metering_1
        m2 <- df$Sub_metering_2
        m3 <- df$Sub_metering_3
        plot(x, m1, type = "l", xlab = "", ylab = "Energy sub metering") 
        lines(x,m2, col = "red")
        lines(x,m3, col = "blue")
        legend('topright', 
               col = c("black","red","blue"), 
               lwd = c(1,1,1), 
               legend = colnames(df[,7:9]), 
               cex = 0.8)
# Plot Bottom Right
        plot(x = df$Time,y = df$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")
        
dev.off()
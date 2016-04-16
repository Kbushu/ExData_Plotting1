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
png(filename = "plot2.png", width = 480, height = 480)
plot(x = df$Time,y = df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
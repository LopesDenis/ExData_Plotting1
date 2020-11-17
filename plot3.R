# Plot3 - ExData Plotting Coursera



#### commom parts


# Files 
url       <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
fileZip  <- "Data.zip"
fileName <- "household_power_consumption.txt"


# Check if the data is downloaded and download when applicable
# and delete zip file
if (!file.exists(fileName)) {
      download.file(url, destfile = fileZip)
      unzip(fileZip)
      file.remove(fileZip)
}


# Reading the file
library(data.table)
DT <- fread(fileName,
            sep = ";",
            header = TRUE,
            colClasses = rep("character",9))


# DT size
print(object.size(DT), units = "auto") #143.1 Mb


# Convert "?" in NAs
DT[DT == "?"] <- NA


# Convert Date and Selecting adequate lines
DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
DT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02"),]




###  Plot 3

# Joining day and time to create a new posix date
DT$posix <- as.POSIXct(strptime(paste(DT$Date, DT$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))



# Convert column that we will use to correct class
DT$Global_active_power <- as.numeric(DT$Global_active_power)
DT$Sub_metering_1 <- as.numeric(DT$Sub_metering_1)
DT$Sub_metering_2 <- as.numeric(DT$Sub_metering_2)
DT$Sub_metering_3 <- as.numeric(DT$Sub_metering_3)



# Graph
png(file = "plot3.png", width = 480, height = 480, units = "px")
  plot(DT$posix,
       DT$Sub_metering_1,
       type = "l",
       xlab = "" ,
       ylab = "Energy sub metering"
       )
  points(DT$posix,
       DT$Sub_metering_2,
       type = "l",
       col = "red"
      )
  points(DT$posix,
         DT$Sub_metering_3,
         type = "l",
         col = "blue"
      )
  legend("topright", col = c("black", "red", "blue"),
          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty = 1)
dev.off()  # Close the png file device

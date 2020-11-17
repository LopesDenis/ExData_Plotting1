# Plot1 - ExData Plotting Coursera


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


# Convert column that we will use to correct class
DT$Global_active_power <- as.numeric(DT$Global_active_power)


# Graph
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(DT$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()  # Close the png file device

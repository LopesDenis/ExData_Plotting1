Curiosity exData
================

# tidy data

### read Data

``` r
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
```

    ## 143.1 Mb

``` r
# Convert "?" in NAs
DT[DT == "?"] <- NA
```

### Select specific range to look

``` r
# Convert Date and Selecting adequate lines
DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
DT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02"),]
```

Choose indicate in project

### Adjust type of data

``` r
###  Plot 4

# Joining day and time to create a new posix date
DT$posix <- as.POSIXct(strptime(paste(DT$Date, DT$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))



# Convert column that we will use to correct class
DT$Global_active_power <- as.numeric(DT$Global_active_power)
DT$Sub_metering_1 <- as.numeric(DT$Sub_metering_1)
DT$Sub_metering_2 <- as.numeric(DT$Sub_metering_2)
DT$Sub_metering_3 <- as.numeric(DT$Sub_metering_3)
DT$Voltage <- as.numeric(DT$Voltage)
DT$Global_reactive_power <- as.numeric(DT$Global_reactive_power)
DT$Global_intensity <- as.numeric(DT$Global_intensity)
```

# Curisity exData

### plot graphs

``` r
 par(mfrow=c(4,2) ,mar=c(2,4,1,1) )
 plot(DT$posix,
     DT$Global_active_power,
     type = "l",
     xlab = "" ,
     ylab = "" ,
     main = "Global Active Power"
  )

  plot(DT$posix,
     DT$Sub_metering_1,
     type = "l",
     xlab = "" ,
     ylab = "" ,
     main = "Sub_metering_1"
  )
  
  plot(DT$posix,
     DT$Global_reactive_power,
     type = "l",
     ylab = "" ,
     ylim = c(0.0, 1),
     main = "Global Reactive Power"
  )
 
  plot(DT$posix,
     DT$Sub_metering_2,
     type = "l",
     xlab = "" ,
     ylab = "" ,
     main = "Sub_metering_2"
  )
  
 plot(DT$posix,
     DT$Voltage,
     type = "l",
     xlab = "" ,
     ylab = "" ,
     main = "Voltage"
  )

   plot(DT$posix,
     DT$Sub_metering_3,
     type = "l",
     xlab = "" ,
     ylab = "" ,
     main = "Sub_metering_3"
  )
   
  plot(DT$posix,
     DT$Global_intensity,
     type = "l",
     xlab = "" ,
     ylab = "" ,
     main = "Global_intensity"
  )  
```

![](curiosity_exData_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Apparently, the voltage drops in mean with global intensit and Global
Reactive Power induce noise in voltage.

### Actice Power x voltage

``` r
  par(mfrow=c(2,1) ,mar=c(1,4,1,1) )
 plot(DT$posix,
     DT$Global_active_power,
     type = "l",
     xlab = "" ,
     ylab = "Global Active Power"
  )
 plot(DT$posix,
     DT$Voltage,
     type = "l",
     xlab = "" ,
     ylab = "Voltage"
  )
```

![](curiosity_exData_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Voltage drop with consuption, but not direct,

### Test other with voltage

``` r
  par(mfrow=c(3,1) ,mar=c(1,4,1,1) )
 plot(DT$posix,
     DT$Global_reactive_power,
     type = "l",
     ylim = c(0.0, 1),
     xlab = "" ,
     ylab = "Global Active Power"
  )
  plot(DT$posix,
     DT$Global_active_power,
     type = "l",
     xlab = "" ,
     ylab = "Global Active Power"
  )
 plot(DT$posix,
     DT$Voltage,
     type = "l",
     xlab = "" ,
     ylab = "Voltage"
  )
```

![](curiosity_exData_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

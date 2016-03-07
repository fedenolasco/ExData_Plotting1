## ESTIMATE MEMORY SIZE FOR DATASET 
#
# Each row estimated to 1896 btes
# Total rows estimated to 2075258 rows x 1896 = 3.5Gb total ram

# Download file url only if file does not exist in work folder
if(!file.exists("household_power_consumption.txt")){
  fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl,destfile="household_power_consumption.zip")
  unzip("household_power_consumption.zip",exdir=".")
}

## LOAD ALL ROWS
df<- read.table("household_power_consumption.txt", header=T, sep=";",na.strings = "?",colClasses =c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
# SUBSETTING DATE "1/2/2007" OR "2/2/2007"
df<-df[df$Date=="1/2/2007" | df$Date=="2/2/2007",]
# CONCATANATE DATE + TIME and add new variable DateTime
df<-transform(df,DateTime=as.POSIXct(paste(df$Date,df$Time), format="%d/%m/%Y %H:%M:%S",tz=""))
#
#Plot 1
par(mfrow=c(1,1))
hist(df$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")
## Don't forget to close the PNG device!
dev.off()

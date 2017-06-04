dataAddress <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataAddress,"data.zip")

aux <- read.table(unz("data.zip","household_power_consumption.txt"),sep=';', header=TRUE)
aux$Date <- as.Date(aux$Date, format="%d/%m/%Y")
#aux$Time <- strptime(as.character(aux$Time), format="%h:%m:%s") 
aux <- aux[(aux$Date >= as.Date("2007-02-01"))&(aux$Date <= as.Date("2007-02-02")),]

aux$DateTime <- strptime(paste(as.character(aux$Date),as.character(aux$Time),sep= " "),
                         format = "%Y-%m-%d %H:%M:%S")

for (ind1 in 1:nrow(aux)){
  for (ind2 in 1:ncol(aux)){
    if (as.character(aux[ind1,ind2])==as.character('?')){aux[ind1,ind2] <- NA}
    #print(paste(ind1,ind2,sep=":"))
  }
}

aux$Global_active_power <- as.numeric(as.character(aux$Global_active_power))

png(filename="plot2.png",width = 480, height = 480)
plot(aux$DateTime,aux$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (killowatts)")
dev.off()
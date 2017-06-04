dataAddress <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataAddress,"data.zip")

aux <- read.table(unz("data.zip","household_power_consumption.txt"),sep=';', header=TRUE)
aux$Date <- as.Date(aux$Date, format="%d/%m/%Y")
#aux$Time <- strptime(as.character(aux$Time), format="%h:%m:%s") 
aux <- aux[(aux$Date >= as.Date("2007-02-01"))&(aux$Date <= as.Date("2007-02-02")),]

for (ind1 in 1:nrow(aux)){
  for (ind2 in 1:ncol(aux)){
    if (as.character(aux[ind1,ind2])==as.character('?')){aux[ind1,ind2] <- NA}
    #print(paste(ind1,ind2,sep=":"))
  }
}

aux$Global_active_power <- as.numeric(as.character(aux$Global_active_power))

png(filename="plot1.png",width = 480, height = 480)
hist(aux$Global_active_power, main = "Global Active Power", col = "orangered3", xlab = "Global Active Power (killowatts)")
dev.off()
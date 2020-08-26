library(ggplot2)
filename <- "exdata_data_NEI_data.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, filename, method="curl")
}  

if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
{ 
  unzip(filename)
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
mergedd <- merge(NEI,SCC, by = "SCC")
Bpm2.51 <- subset(mergedd, fips == "24510")
Bpm2.52 <- subset(mergedd, fips =="06037")
Bpm2.5 <- rbind(Bpm2.51,Bpm2.52)
matchedveh1<- grepl("vehicles | vehicle", x = Bpm2.5$Short.Name, ignore.case = T)
source_veh <- Bpm2.5[matchedveh1,]
total_pm2.5 <- aggregate(Emissions ~ year + fips,source_veh, FUN=sum)
total_pm2.5$city[1:4]<- "Los Angeles"
total_pm2.5$city[5:8] <- "Baltimore City"
png("plot6.png", width = 640, height = 680)
p <- ggplot(total_pm2.5, aes(as.factor(year), Emissions, fill = city))
p + geom_bar(stat="identity") + facet_grid(.~fips) +
ggtitle("PM2.5 Emissions from the Motor vehicle sources from 1999 to 2008",subtitle = " Baltimore City vs Los Angeles ")  +
ylab(expression('Total PM'[2.5]*" Emissions"))+
xlab("year")
dev.off()

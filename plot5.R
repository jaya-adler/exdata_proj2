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
Bpm2.5 <- subset(mergedd, fips == "24510")
matchedvehicles<- grepl("vehicles", x = Bpm2.5$Short.Name, ignore.case = T)
source_coal <- Bpm2.5[matchedvehicles,]
total_pm2.5 <- aggregate(Emissions ~ year,source_coal, FUN=sum)
png("plot5.png", width = 640, height = 480)
p <- ggplot(total_pm2.5, aes(as.factor(year), Emissions))
p + 
  geom_bar(stat="identity") + 
  ggtitle(expression("Total PM2.5 Emissions in Baltimore City from the Motor vehicle sources from 1999 to 2008"))  + 
  ylab(expression('Total PM'[2.5]*" Emissions")) + 
  xlab("year")
dev.off()

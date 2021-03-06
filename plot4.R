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
matchedcoal<- grepl("coal", x = SCC$Short.Name, ignore.case = T)
source_coal <- mergedd[matchedcoal,]
total_pm2.5 <- aggregate(Emissions ~ year,source_coal, FUN=sum)
png("plot4.png", width = 640, height = 480)
p <- ggplot(total_pm2.5, aes(year, Emissions))
p + 
  geom_line() + 
  ggtitle(expression("Total PM2.5 Emissions from source coal from 1999 to 2008")) + 
  geom_smooth(method = "lm") + 
  ylab(expression('Total PM'[2.5]*" Emissions"))
dev.off()

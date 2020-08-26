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
Bpm2.5 <- subset(NEI, fips == "24510")
splitby_Type_year <- aggregate(Emissions ~ year + type, Bpm2.5, sum)
rm(NEI)
png("plot3.png")
g <- ggplot(splitby_Type_year, aes(year, Emissions, col = type))
g + geom_line() + geom_smooth() + ggtitle("Pm2.5 Emissions in Baltimore at various years")
dev.off()


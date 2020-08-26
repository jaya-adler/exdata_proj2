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
total_by_year <- aggregate(Bpm2.5$Emissions, by=list(Bpm2.5$year), FUN=sum)
rm(NEI)
png("plot2.png")
plot(x = total_by_year$Group.1,y = total_by_year$x, ylab = "total PM2.5 emission", xlab = "years",type = "b", main = "Total PM2.5 Emissions in Baltimore City at various years")
dev.off()

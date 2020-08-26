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
total_by_year <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
rm(NEI)
png("plot1.png")
plot(x = total_by_year$Group.1,y = total_by_year$x, ylab = "total PM2.5 emission", xlab = "years",type = "b", main = "Total PM2.5 Emissions in United states at various years")
dev.off()



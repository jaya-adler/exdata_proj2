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
matchedcoal<- grepl("coal", x = SCC$Short.Name, ignore.case = T)
source_coal <- NEI$SCC[matchedcoal]
neicoal <- NEI[source_coal,]
total_pm2.5 <- aggregate(Emissions ~ year,neicoal, FUN=sum)
p <- ggplot(total_pm2.5, aes(year, Emissions))
p + geom_bar()

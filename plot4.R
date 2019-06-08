#library Use

library(dplyr)
library(ggplot2)


#set working directory
setwd("C:/Users/CPUser/Desktop/Data analytics/C4_Exploratory Data Analysis/Assignment Course Project 2/exdata_data_NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

combustion_coal <- grepl("Coal", SCC$EI.Sector)
combustion_coal_sources <- SCC[combustion_coal,]
emissions_coal_combustion <- NEI[(NEI$SCC %in% combustion_coal_sources$SCC), ]
emissions_coal_related <- summarise(group_by(emissions_coal_combustion, year), Emissions=sum(Emissions))

p4 <- ggplot(emissions_coal_related,aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) + geom_bar(stat="identity") + xlab("year") + ylab(expression("total PM2.5 emissions in kilotons")) + ggtitle("Emissions from coal combustion-related sources in kilotons")+ geom_label(aes(fill = year),colour = "red", fontface = "bold")

print(p4)
ggsave(filename="plot4.png", plot=p4, dpi = 300,limitsize = TRUE)
dev.off()

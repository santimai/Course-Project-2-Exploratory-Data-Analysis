#library Use

library(dplyr)
library(ggplot2)


#set working directory
setwd("C:/Users/CPUser/Desktop/Data analytics/C4_Exploratory Data Analysis/Assignment Course Project 2/exdata_data_NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

city_emissions_type<-summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))

p3 <- ggplot(city_emissions_type,aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) + geom_bar(stat="identity") + facet_grid(. ~ type) + labs(x = "year")+labs(y = expression("Total PM2.5 (Ton)"))+labs(title = "PM2.5 in Emissions  for Baltimore City by various source types")+geom_label(aes(fill = type), colour = "black", fontface = "bold")

print(p3)
ggsave(filename="plot3.png", plot=p3, dpi = 300,width = 40, height = 20, units = "cm",limitsize = TRUE)
dev.off()


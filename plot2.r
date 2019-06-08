#library Use

library(dplyr)
library(RColorBrewer)


#set working directory
setwd("C:/Users/CPUser/Desktop/Data analytics/C4_Exploratory Data Analysis/Assignment Course Project 2/exdata_data_NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

city_emissions<-summarise(group_by(filter(NEI, fips == "24510"), year), Emissions=sum(Emissions))
cols <- brewer.pal(4,"PiYG")
p2<-barplot(height=city_emissions$Emissions/1000, names.arg=city_emissions$year,xlab="years", ylab=expression('total PM2.5 emission in kilotons'),ylim=c(0,4),main=expression('Total PM2.5 emissions in Baltimore City-MD (kilotons) '),col=cols)

## Add text at top of bars
text(x = p2, y = round(city_emissions$Emissions/1000,2), label = round(city_emissions$Emissions/1000,2), pos = 3, cex = 1, col = "black")
dev.copy(png,file = 'plot2.png')
dev.off()

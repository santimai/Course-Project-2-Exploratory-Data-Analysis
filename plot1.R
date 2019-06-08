#library Use

library(dplyr)
library(RColorBrewer)


#set working directory
setwd("C:/Users/CPUser/Desktop/Data analytics/C4_Exploratory Data Analysis/Assignment Course Project 2/exdata_data_NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

total_Emi <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
cols <- brewer.pal(4,"BuGn")
p1 <-barplot(height = total_Emi$Emissions/1000,names.arg = total_Emi$year,  xlab="years", ylab=expression('total PM 2.5 emission (kilotons)'), main=expression('Total PM 2.5 emissions at various years'),col = cols,ylim=c(0,8000))

text(x = p1, y = round(total_Emi$Emissions/1000,2), label = round(total_Emi$Emissions/1000,2), pos = 3, cex = 1, col = "black")

dev.copy(png,file = 'plot1.png')
dev.off()
             
             
             
             


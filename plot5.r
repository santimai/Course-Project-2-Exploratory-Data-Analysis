#library Use

library(dplyr)
library(ggplot2)
library(RColorBrewer)


#set working directory
setwd("C:/Users/CPUser/Desktop/Data analytics/C4_Exploratory Data Analysis/Assignment Course Project 2/exdata_data_NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#5.How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
baltimore_motor <- filter(NEI, fips =="24510"& type=="ON-ROAD" )
baltimore_motor_year <- summarise(group_by(baltimore_motor,year),Emissions=sum(Emissions))

cols <- brewer.pal(4,"PiYG")

p5 <- ggplot(baltimore_motor_year,aes(x = factor(year),y = Emissions, fill = year,label = round(Emissions,2)))+geom_bar(stat="identity")+xlab("year") + ylab(expression("total PM2.5 emissions in tons")) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City")+
    geom_label(aes(fill = year),colour = "red", fontface = "bold")

print(p5)
ggsave(filename="plot5.png", plot=p5, dpi = 300,limitsize = TRUE)
dev.off()

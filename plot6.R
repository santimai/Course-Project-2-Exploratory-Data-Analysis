#library Use

library(dplyr)
library(ggplot2)
library(gridExtra)


#set working directory
setwd("C:/Users/CPUser/Desktop/Data analytics/C4_Exploratory Data Analysis/Assignment Course Project 2/exdata_data_NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == “06037”). Which city has seen greater changes over time in motor vehicle emissions?

baltimore_motor <- filter(NEI, fips =="24510"& type=="ON-ROAD" )
baltimore_motor_year <- summarise(group_by(baltimore_motor,year),Emissions=sum(Emissions))
LA_motor <- filter(NEI, fips =="06037"& type=="ON-ROAD" )
LA_motor_year <- summarise(group_by(LA_motor,year),Emissions = sum(Emissions))
LA_motor_year <-rename(LA_motor_year,LA_Emi = Emissions )
baltimore_motor_year <-rename(baltimore_motor_year,Baltimore_Emi = Emissions )

LA_BAL <- baltimore_motor_year %>% left_join(LA_motor_year, by = c("year")) 

p6 <- ggplot(LA_BAL,aes(x = factor(year),y = Baltimore_Emi, fill = year,label = round(Baltimore_Emi,2)))+geom_bar(stat="identity")+xlab("year") + ylab(expression("total PM2.5 emissions in tons")) +
    ggtitle("Emissions  in Baltimore City")+
    geom_label(aes(fill = year),colour = "red", fontface = "bold")

p7 <- ggplot(LA_BAL,aes(x = factor(year),y = LA_Emi, fill = year,label = round(LA_Emi,2)))+geom_bar(stat="identity")+xlab("year") + ylab(expression("total PM2.5 emissions in tons")) +
    ggtitle("Emissions in Los Angeles  City")+
    geom_label(aes(fill = year),colour = "White", fontface = "bold")

p8 <- grid.arrange(p6, p7, ncol=2)

print(p8)
ggsave(filename="plot6.png", plot=p8, dpi = 300,limitsize = TRUE)
dev.off()




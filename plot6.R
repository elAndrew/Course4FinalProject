NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

vehicleSCC <- SCC[grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE),]
#subset just those observations that contain the word "vehicle" in the EI.Sector field

vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC$SCC,]
#subset our main dataframe to just those observations that have a SCC that is also in the vehicleSSC dataframe we just created

vehicleNEIbalLA <- vehicleNEI[vehicleNEI$fips == "24510" | vehicleNEI$fips == "06037",]
vehicleNEIbalLA$fips[vehicleNEIbalLA$fips == "24510"] <- "Baltimore"
vehicleNEIbalLA$fips[vehicleNEIbalLA$fips == "06037"] <- "Los Angeles"

totallevels <- with(vehicleNEIbalLA, tapply(Emissions, list(year, fips), sum))
totallevels

library(reshape2)
totallevels <- as.data.frame(totallevels)
totallevels$year <- rownames(totallevels)
totallevels

totallevels <- melt(totallevels,
                    id.vars = c(3),
                    measure.vars = c(1,2)
)
names(totallevels) <- c("year", "City", "Emissions")
totallevels$year <- as.numeric(totallevels$year)
totallevels

library(ggplot2)

png(file = "plot6.png", 
    width = 480,
    height = 480)

p2 <- ggplot(totallevels, aes(year)) +
  geom_bar(aes(weight = Emissions)) +
  facet_grid(~City) +
  geom_text(aes(y=Emissions, label = round(Emissions)), vjust = -.11) +
  theme_bw() +
  xlab("") +
  ylab("Total measured PM2.5 levels, tons
       from motor vehicle sources") +
  scale_x_continuous(breaks = c(1999, 2002, 2005, 2008),
                     labels = c("1999", "2002", "2005", "2008")) +
  labs(title = 
         "Emissions from motor vehicle sources have seen greater 
       changes in Baltimore than in Los Angeles, both in absolute 
       and relative terms, when comparing 1999 to 2008 values") +
  theme(plot.title = element_text(hjust = .5))
p2

dev.off()
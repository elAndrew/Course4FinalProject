NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

vehicleSCC <- SCC[grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE),]
#subset just those observations that contain the word "vehicle" in the EI.Sector field

vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC$SCC,]
#subset our main dataframe to just those observations that have a SCC that is also in the vehicleSSC dataframe we just created

vehicleNEIbal <- vehicleNEI[vehicleNEI$fips == "24510",]

Ballevels <- with(vehicleNEIbal, tapply(Emissions, as.factor(year), sum))

png(file = "plot5.png", 
    width = 480,
    height = 480)

par(mar = c(3,5,5,1))
plot(names(Ballevels), Ballevels, 
     type = "h", lwd = 100, lend = 1, xaxt = 'n',
     ylab = "Total measured PM.25 levels in tons\nBaltimore City, Maryland", xlab = "", 
     pch = 19, cex = 2, xlim = c(1998, 2009), col = "grey")
axis(side = 1, at = names(Ballevels))
title(main = "Emissions from motor vehicle sources have\ndecreased overall in Baltimore from 1999 to 2008")

dev.off()
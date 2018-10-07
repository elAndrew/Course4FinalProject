NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

coalSCC <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE),]
#subset just those observations that contain the word "coal" in the EI.Sector field

coalNEI <- NEI[NEI$SCC %in% coalSCC$SCC,]
#subset our main dataframe to just those observations that have a SCC that is also in the coalSSC dataframe we just created

totallevels <- with(coalNEI, tapply(Emissions, as.factor(year), sum))

png(file = "plot4.png", 
    width = 480,
    height = 480)

par(mar = c(3,5,5,1))
par(mar = c(3,5,5,1))
plot(names(totallevels), totallevels, 
     type = "h", lwd = 100, lend = 1, xaxt = 'n', yaxt = 'n',
     ylab = "Total measured PM.25 levels in tons\nU.S., Nationwide", xlab = "", 
     pch = 19, cex = 2, xlim = c(1998, 2009), col = "grey")
axis(side = 1, at = names(totallevels))
axis(side = 2, at = c(350000, 450000, 550000), 
     labels = (c("350,000", "450,000", "550,000")))
title(main = "Across the United States, emissions\nfrom coal combustion-related sources\nhave decreased from 1999 - 2008")

dev.off()
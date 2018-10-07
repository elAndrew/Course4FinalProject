NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

totallevels <- with(NEI, tapply(Emissions, as.factor(year), sum))

png(file = "plot1.png", 
    width = 480,
    height = 480)

par(mar = c(3,5,3,1))
plot(names(totallevels), totallevels, 
     type = "h", lwd = 100, lend = 1, xaxt = 'n', yaxt = 'n',
     ylab = "Total measured PM.25 levels in tons\nU.S., Nationwide", xlab = "", 
     pch = 19, cex = 2, xlim = c(1998, 2009), col = "grey")
axis(side = 1, at = names(totallevels))
axis(side = 2, at = c(4000000, 5000000, 6000000, 7000000), 
     labels = (c("4 mil.", "5 mil.", "6 mil.", "7 mil.")))
title(main = "Total emissions from PM2.5 have decreased\nin the U.S. from 1999 to 2008")

dev.off()
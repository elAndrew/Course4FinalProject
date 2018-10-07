NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEIbal <- NEI[NEI$fips == "24510",]
Ballevels <- with(NEIbal, tapply(Emissions, as.factor(year), sum))

png(file = "plot2.png", 
    width = 480,
    height = 480)

par(mar = c(3,5,3,1))
plot(names(Ballevels), Ballevels, 
     type = "h", lwd = 100, lend = 1, xaxt = 'n',
     ylab = "Total measured PM.25 levels in tons\nBaltimore City, Maryland", xlab = "", 
     pch = 19, cex = 2, xlim = c(1998, 2009), col = "grey")
axis(side = 1, at = names(Ballevels))
title(main = "Total emissions from PM2.5 have decreased\nin Baltimore comparing 1999 to 2008")

dev.off()
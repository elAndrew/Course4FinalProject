NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEIbal <- NEI[NEI$fips == "24510",]

library(ggplot2)

png(file = "plot3.png", 
    width = 480,
    height = 480)

p1 <- ggplot(NEIbal, aes(year)) +
  geom_bar(aes(weight = Emissions)) +
  facet_wrap(~type)+
  theme_bw() +
  xlab("") +
  ylab("Total measured PM2.5 levels, tons") +
  scale_x_continuous(breaks = c(1999, 2002, 2005, 2008),
                     labels = c("1999", "2002", "2005", "2008")) +
  labs(title = "All sources in Baltimore show a decrease in PM2.5 emissions 
       from 1999 - 2008, aside from the source \"POINT\"") +
  theme(plot.title = element_text(hjust = 0.5))
p1

dev.off()
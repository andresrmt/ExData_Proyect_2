#### *** Question 3 *** ####
## --------------------------------------------------------------------------------
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
## -------------------------------------------------------------------------------- 

# *** Load ggplot2 ***
library(ggplot2)

# *** Read only needed dataset ***
NEI <- readRDS('summarySCC_PM25.rds')              # PM2.5 emissions

# *** Data exploration ***
Baltimore <- subset(NEI, fips == "24510")

# Get the total emissions in Baltimore, grouped by type and year
ty_emissions <- aggregate(Emissions ~ type + year, Baltimore, FUN = sum)

# *** Output ***
# Open png device
png(filename = 'plot3.png', width=720, height=480, units='px')

# Plot
g <- ggplot(ty_emissions, aes(x=year, y=Emissions, color=factor(year)) )
g <- g + geom_line(color = "darkcyan", size = 0.1) + geom_point()
g + labs(title = 'PM2.5 Emissions by type in Baltimore City, Maryland',
         y = 'PM2.5 Emissions (tons)', x = 'Year') +  facet_wrap(~ type)

# Close png device
dev.off()
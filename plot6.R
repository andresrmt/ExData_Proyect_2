#### *** Question 6 *** ####
## --------------------------------------------------------------------------------
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
## -------------------------------------------------------------------------------- 

# *** Load ggplot2 ***
library(ggplot2)

# *** Read datasets ***
NEI <- readRDS('summarySCC_PM25.rds')              # PM2.5 emissions
SCC <- readRDS('Source_Classification_Code.rds')   # Emission source classification


# *** Data exploration ***
BLA_Emissions <- subset(NEI, fips %in% c("24510","06037") & type == "ON-ROAD")

# Get the total emissions grouped by type and year
fy_emissions <- aggregate(Emissions ~ fips + year, BLA_Emissions, FUN = sum)
# Modify column to identify city for plotting purposes
fy_emissions[fy_emissions$fips == '24510', 'fips'] = 'Baltimore City'
fy_emissions[fy_emissions$fips == '06037', 'fips'] = 'Los Angeles County'


# *** Output ***
# Open png device
png(filename = 'plot6.png', width=720, height=300, units='px')

# Plot
g <- ggplot(fy_emissions, aes(x=year, y=Emissions, color=factor(year)) )
g <- g + geom_line(color = "darkcyan", size = 0.1) + geom_point()
g + labs(title = 'PM2.5 Emissions in Baltimore and Los Angeles',
         y = 'PM2.5 Emissions (tons)', x = 'Year') +  facet_wrap(~ fips)

# Close png device
dev.off()
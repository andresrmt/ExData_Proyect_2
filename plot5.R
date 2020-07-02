#### *** Question 5 *** ####
## --------------------------------------------------------------------------------
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
## -------------------------------------------------------------------------------- 

# *** Read only needed dataset ***
NEI <- readRDS('summarySCC_PM25.rds')              # PM2.5 emissions

# *** Data exploration ***
# motor vehicle sources (type = ON-ROAD)
Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")

# Aggregate data by year from emissions
year_emissions <- with(Baltimore, tapply(Emissions, year, sum, na.rm = TRUE))
year_emissions <- data.frame(     year = names(year_emissions), 
                                  emissions = as.vector(year_emissions))

# *** Output ***
# Open png device
png(filename = 'plot5.png', width=480, height=480, units='px')

# Plot
options(scipen=10)                            # plot aesthetics for vertical axis
with(year_emissions, plot(year, emissions, 
                          xlab = 'Year', ylab = 'PM2.5 Emissions (tons)', 
                          main = 'Total PM2.5 Emissions from motor vehicle sources in Baltimore',
                          col = 'darkcyan', 
                          type='b'))

# Close png device
dev.off()
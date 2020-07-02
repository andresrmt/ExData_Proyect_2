#### *** Question 2 *** ####
## --------------------------------------------------------------------------------
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
## -------------------------------------------------------------------------------- 

# *** Read only needed dataset ***
NEI <- readRDS('summarySCC_PM25.rds')              # PM2.5 emissions

Baltimore <- subset(NEI, fips == "24510")

# Aggregate data by year from emissions
year_emissions <- with(Baltimore, tapply(Emissions, year, sum, na.rm = TRUE))
year_emissions <- data.frame(     year = names(year_emissions), 
                             emissions = as.vector(year_emissions))

# Open png device
png(filename = 'plot2.png', width=480, height=480, units='px')

# Plot
options(scipen=10)                            # plot aesthetics for vertical axis
with(year_emissions, plot(year, emissions, 
              xlab = 'Year', ylab = 'PM2.5 Emissions (tons)', 
              main = 'Total PM2.5 Emissions in Baltimore City, Maryland',
              col = 'darkcyan', 
              type='b'))

# Close png device
dev.off()
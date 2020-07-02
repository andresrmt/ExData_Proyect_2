#### *** Question 1 *** ####
## --------------------------------------------------------------------------------
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
## -------------------------------------------------------------------------------- 

# *** Read only needed dataset ***
NEI <- readRDS('summarySCC_PM25.rds')              # PM2.5 emissions

# Aggregate data by year from emissions
year_emissions <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))
year_emissions <- data.frame(     year = names(year_emissions), 
                             emissions = as.vector(year_emissions))

# Open png device
png(filename = 'plot1.png', width=480, height=480, units='px')

# Plot
options(scipen=10)                            # plot aesthetics for vertical axis
with(year_emissions, plot(year, emissions, 
              xlab = 'Year', ylab = 'PM2.5 Emissions (tons)', 
              main = 'Total PM2.5 Emissions in the US',
              col = 'darkcyan',
              type='b'))

# Close png device
dev.off()
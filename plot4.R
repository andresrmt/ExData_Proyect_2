#### *** Question 4 *** ####
## --------------------------------------------------------------------------------
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?
## -------------------------------------------------------------------------------- 

# *** Read datasets ***
NEI <- readRDS('summarySCC_PM25.rds')              # PM2.5 emissions
SCC <- readRDS('Source_Classification_Code.rds')   # Emission source classification


# *** Data exploration ***
# Use the 'Short.Name' field to find the coal combustion-related sources
Coal <- SCC[grep('coal', SCC$Short.Name, ignore.case = TRUE), ]

# Get the emissions from coal combustion-related sources
Coal_E <- subset(NEI, SCC %in% Coal$SCC)

# Aggregate data by year from emissions
year_emissions <- with(Coal_E, tapply(Emissions, year, sum, na.rm = TRUE))
year_emissions <- data.frame(     year = names(year_emissions), 
                                  emissions = as.vector(year_emissions))

# *** Output ***
# Open png device
png(filename = 'plot4.png', width=480, height=480, units='px')

# Plot
options(scipen=10)                            # plot aesthetics for vertical axis
with(year_emissions, plot(year, emissions, 
                          xlab = 'Year', ylab = 'PM2.5 Emissions (tons)', 
                          main = 'Total PM2.5 Coal-Related Emissions in the US',
                          col = 'darkcyan', 
                          type='b'))

# Close png device
dev.off()
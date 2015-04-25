#setwd("C:/Users/Mi/Desktop/Schoolwork/QR260/Final Project/ACS")


# Data from Massachusetts 2013 American Community Survey - person level
# Download from here: http://www2.census.gov/acs2013_1yr/pums/
# Coding here: http://www.census.gov/acs/www/Downloads/data_documentation/pums/DataDict/PUMSDataDict13.pdf

data<-read.csv('ss13pma.csv')
attach(data)

# Clean data: columns we actually want are 'PINCP': income, 'RAC1P' race code,
# 'MIGSP': migration code (NA = lived in same house a year ago, state/country codes)

mig<-is.na(MIGSP) # Logical vector indicating lived in the same house last year or not
use<-data.frame(PINCP,RAC1P,MIGSP,mig)

# Notes-Julia 4/24: This looks like a workable data set- 68725 units. 
# potential issues: vast majority white, I can't find an age variable, are these people from
# the same households? If so, we can sample 1 from each household
#
# CP said in class that we shouldn't run tests until exploring data graphically.

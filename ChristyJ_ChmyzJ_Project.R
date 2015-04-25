#setwd("C:/Users/Mi/Desktop/Schoolwork/QR260/Final Project/ACSp")

# Data from US 2013 American Community Survey - person level
# Download from here: http://www2.census.gov/acs2013_1yr/pums/
# Coding here: http://www.census.gov/acs/www/Downloads/data_documentation/pums/DataDict/PUMSDataDict13.pdf

data<-read.csv('ss13pus.csv')

#get random subset of households from huge-ass data set
subset(data, SERIALNO %in% sample(levels(data$SERIALNO), 5000))

# Clean data: columns we actually want are 'PINCP': income, 'RAC1P' race code,
# 'MIGSP': migration code (NA = lived in same house a year ago, state/country codes)

#migrant status as true/false
data$mig<-is.na(MIGSP) # Logical vector indicating lived in the same house last year or not
data$mig<-1-data$mig #switch, so that 1 indicates a mover
data$mig[data$MIGSP==data$ST]<-0 #drop intrastate movers 

#household size, income, and representive generation
inds = data.frame
for i < maxHHnumber{
  if len(data$SERIALNO[data$SERIALNO == i] != 0{
    data$hhsize=len(data$SERIALNO[data$SERIALNO == i])
    
    data$PINCP[data$SERIALNO == i][data$PINCP == NA] = 0
    data$hhinc=sum(data$SERIALNO[data$SERIALNO == i])
    
    ind=(data$SERIALNO[data$SERIALNO == i],1)
    inds = rbind(subset,ind)
  }
}
attach(inds)

use<-data.frame(RAC1P,MIGSP,mig,hhinc,hhsize)



#setwd("C:/Users/Mi/Desktop/Schoolwork/QR260/Final Project/ACSp/split")

# Data from US 2013 American Community Survey - person level
# Download from here: http://www2.census.gov/acs2013_1yr/pums/
# Coding here: http://www.census.gov/acs/www/Downloads/data_documentation/pums/DataDict/PUMSDataDict13.pdf

data<-read.csv('ss13pusa_chunk1.csv')
set.seed(1)

#get random subset of households from huge-ass data set
datasub = subset(data, data$SERIALNO %in% sample(levels(data$SERIALNO), 150))
attach(datasub)

# Clean data: columns we actually want are 'PINCP': income, 'RAC1P' race code,
# 'MIGSP': migration code (NA = lived in same house a year ago, state/country codes)

#migrant status as true/false
datasub$mig<-is.na(datasub$MIGSP) # Logical vector indicating lived in the same house last year or not
datasub$mig<-1-datasub$mig #switch, so that 1 indicates a mover
datasub$mig[as.numeric(datasub$MIGSP)==as.numeric(datasub$ST)]<-0 #drop intrastate movers 

#seperate out the migrants and non, and drop excess non
migrant = subset(datasub,datasub$mig == 1)
nonmig = subset(datasub,datasub$mig == 0)
nonmig = subset(nonmig, as.numeric(nonmig$SERIALNO) %in% sample(unique(as.numeric(nonmig$SERIALNO)),
                                                    length(unique(as.numeric(migrant$SERIALNO)))))

#household size, income, and representive generation
inds = cbind(datasub[1,])
j=1
for (i in unique(as.numeric(datasub$SERIALNO))) {
  hhsize[j]=nrow(subset(datasub,as.numeric(datasub$SERIALNO) == i))
    
  hhinc[j]=sum(as.numeric(subset(datasub,as.numeric(datasub$SERIALNO) == i)$PINCP))
    
  inds = rbind(inds,(subset(datasub,as.numeric(datasub$SERIALNO) == i)[sample(hhsize[j],1),])) 
  j = j + 1
}

inds = cbind(inds[2:151,],hhsize,hhinc)
attach(inds)

write.csv(inds, file = "people.csv")
use<-data.frame(RAC1P,MIGSP,mig,hhinc,hhsize)




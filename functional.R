setwd("C:/Users/Mi/Desktop/Schoolwork/QR260/Final Project/ACSp/split")

set.seed(1)

getInd <- function(type){
  inds = cbind(type[1,])
  j=1
  hhsize=NULL
  hhinc=NULL
  for (i in unique(as.numeric(type$SERIALNO))) {
    hhsize[j]=nrow(subset(type,as.numeric(type$SERIALNO) == i))
    hhinc[j]=sum(as.numeric(subset(type,as.numeric(type$SERIALNO) == i)$PINCP))
    inds = rbind(inds,(subset(datasub,as.numeric(datasub$SERIALNO) == i)[sample(hhsize[j],1),]))
    j = j + 1
  }
  cleandata = cbind(inds[2:j,],hhsize,hhinc)
}

clean <- function(datachunk){
  
  data=read.csv(datachunk)
  #get random subset of households from huge-ass data set
  datasub = subset(data, as.numeric(data$SERIALNO) %in% sample(unique(as.numeric(data$SERIALNO)), 500))
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
  inds = cbind(migrant[1,])
  j=1
  hhsize=NULL
  hhinc=NULL
  for (i in unique(as.numeric(migrant$SERIALNO))) {
    hhsize[j]=nrow(subset(migrant,as.numeric(migrant$SERIALNO) == i))
    hhinc[j]=sum(as.numeric(subset(migrant,as.numeric(migrant$SERIALNO) == i)$PINCP))
    inds = rbind(inds,(subset(migrant,as.numeric(datasub$migrant) == i)[sample(hhsize[j],1),])) 
    j = j + 1
  }
  cleandata = cbind(inds[2:j,],hhsize,hhinc)
  
  inds = cbind(nonmig[1,])
  j=1
  hhsize=NULL
  hhinc=NULL
  for (i in unique(as.numeric(nonmig$SERIALNO))) {
    hhsize[j]=nrow(subset(nonmig,as.numeric(nonmig$SERIALNO) == i))
    hhinc[j]=sum(as.numeric(subset(nonmig,as.numeric(nonmig$SERIALNO) == i)$PINCP))
    inds = rbind(inds,(subset(nonmig,as.numeric(nonmig$SERIALNO) == i)[sample(hhsize[j],1),])) 
    j = j + 1
  }
  
  cleandata = rbind(cleandata,cbind(inds[2:j,],hhsize,hhinc))
  #use<-cbind(cleandata$RAC1P,cleandata$mig,cleandata$hhinc,cleandata$hhsize)
  
  return(cleandata)
}

cleandata2 <- rbind(
	clean('ss13pusa_chunk1.csv'),
	clean('ss13pusa_chunk2.csv'),
	clean('ss13pusa_chunk3.csv'),
	clean('ss13pusa_chunk4.csv'),
	clean('ss13pusa_chunk5.csv'),
	clean('ss13pusa_chunk6.csv'),
	clean('ss13pusa_chunk7.csv'),
	clean('ss13pusa_chunk8.csv'),
	clean('ss13pusa_chunk9.csv'),	
	clean('ss13pusa_chunk10.csv'),
	clean('ss13pusa_chunk11.csv'),
	clean('ss13pusa_chunk12.csv'),
	clean('ss13pusa_chunk13.csv'),
	clean('ss13pusa_chunk14.csv'),
	clean('ss13pusa_chunk15.csv'),
	clean('ss13pusa_chunk16.csv'),
	clean('ss13pusa_chunk17.csv'),
	clean('ss13pusa_chunk18.csv'),
	clean('ss13pusa_chunk19.csv'),

	clean('ss13pusa_chunk20.csv'),
	clean('ss13pusa_chunk21.csv'),
	clean('ss13pusa_chunk22.csv'),
	clean('ss13pusa_chunk23.csv'),
	clean('ss13pusa_chunk24.csv'),
	clean('ss13pusa_chunk25.csv'),
	clean('ss13pusa_chunk26.csv'),
	clean('ss13pusa_chunk27.csv'),
	clean('ss13pusa_chunk28.csv'),
	clean('ss13pusa_chunk29.csv'),
	clean('ss13pusa_chunk30.csv'),

	clean('ss13pusa_chunk31.csv'),
	clean('ss13pusa_chunk32.csv'),
	clean('ss13pusa_chunk33.csv'),

	clean('ss13pusb_chunk1.csv'),
	clean('ss13pusb_chunk2.csv'),
	clean('ss13pusb_chunk3.csv'),
	clean('ss13pusb_chunk4.csv'),
	clean('ss13pusb_chunk5.csv'),
	clean('ss13pusb_chunk6.csv'),
	clean('ss13pusb_chunk7.csv'),
	clean('ss13pusb_chunk8.csv'),
	clean('ss13pusb_chunk9.csv'),

	clean('ss13pusb_chunk10.csv'),
	clean('ss13pusb_chunk11.csv'),
	clean('ss13pusb_chunk12.csv'),
	clean('ss13pusb_chunk13.csv'),
	clean('ss13pusb_chunk14.csv'),
	clean('ss13pusb_chunk15.csv'),
	clean('ss13pusb_chunk16.csv'),
	clean('ss13pusb_chunk17.csv'),
	clean('ss13pusb_chunk18.csv'),
	clean('ss13pusb_chunk19.csv'),

	clean('ss13pusb_chunk20.csv'),
	clean('ss13pusb_chunk21.csv'),
	clean('ss13pusb_chunk22.csv'),
	clean('ss13pusb_chunk23.csv'),
	clean('ss13pusb_chunk24.csv'),
	clean('ss13pusb_chunk25.csv'),
	clean('ss13pusb_chunk26.csv'),
	clean('ss13pusb_chunk27.csv'),
	clean('ss13pusb_chunk28.csv'),
	clean('ss13pusb_chunk29.csv'),
	clean('ss13pusb_chunk30.csv'),

	clean('ss13pusb_chunk31.csv'))

write.csv(cleandata, file = "people.csv")




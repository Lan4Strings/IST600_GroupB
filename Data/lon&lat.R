#get longtitude and latitude
data<-read.csv("2017.1-2018.1.csv")
datanew<-data.frame(data,full_add=paste(data$StNum,data$StName))
library(ggmap)
datanew$full_add<-as.character(datanew$full_add)
dim(datanew[datanew$Occupancy=='Vacant Residential',])
latlon<-geocode(datanew$full_add[datanew$Occupancy=='Vacant Residential'])

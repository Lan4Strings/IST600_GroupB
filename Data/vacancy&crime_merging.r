data<-read.csv("2017.1-2018.1.csv")
datanew<-data.frame(data,full_add=paste(data$StNum,data$StName))
library(ggmap)
datanew$full_add<-as.character(datanew$full_add)
dim(datanew[datanew$Occupancy=='Vacant Residential',])
latlon<-geocode(datanew$full_add[datanew$Occupancy=='Vacant Residential'])




data<-read.csv("2017.1-2018.1.csv")
datanew<-data.frame(data)
datanew$block.address<-gsub("AVE","AV",datanew$block.address)
datanew$block.address<-tolower(datanew$block.address)
datanew$block.address<-gsub("\\s?&.*$","",datanew$block.address)
datanew$block.address<-gsub(" rear.*$","",datanew$block.address)
datanew$block.address<-gsub(" to .*$","",datanew$block.address)
datanew$block.address<-gsub(" #.*$","",datanew$block.address)

crimedata<-read.csv("crime2017.csv")
datacrime<-data.frame(crimedata)
datacrime$Aggravated.assault[is.na(datacrime$Aggravated.assault)]<-0
datacrime$Arson[is.na(datacrime$Arson)]<-0
datacrime$Burglary[is.na(datacrime$Burglary)]<-0
datacrime$Larceny[is.na(datacrime$Larceny)]<-0
datacrime$Murder[is.na(datacrime$Murder)]<-0
datacrime$Robbery[is.na(datacrime$Robbery)]<-0
datacrime$Vehicle.theft[is.na(datacrime$Vehicle.theft)]<-0
datacrime$Address<-tolower(datacrime$Address)
South<-unlist(gregexpr(" s ",datacrime$Address))
South<-as.numeric(gsub(-1,0,South))
datacrime$Address<-gsub(" s "," ",datacrime$Address)
datacrime$Address[South==TRUE]<-paste(datacrime$Address[South==TRUE],"s")

North<-unlist(gregexpr(" n ",datacrime$Address))
North<-as.numeric(gsub(-1,0,North))
datacrime$Address<-gsub(" n "," ",datacrime$Address)
datacrime$Address[North==TRUE]<-paste(datacrime$Address[North==TRUE],"n")

East<-unlist(gregexpr(" e ",datacrime$Address))
East<-as.numeric(gsub(-1,0,East))
datacrime$Address<-gsub(" e "," ",datacrime$Address)
datacrime$Address[East==TRUE]<-paste(datacrime$Address[East==TRUE],"e")

West<-unlist(gregexpr(" w ",datacrime$Address))
West<-as.numeric(gsub(-1,0,West))
datacrime$Address<-gsub(" w "," ",datacrime$Address)
datacrime$Address[West==TRUE]<-paste(datacrime$Address[West==TRUE],"w")

datamerged<-merge(datanew,datacrime,by.x="block.address",by.y="Address",all.y=TRUE)



sum(datamerged$Total[is.na(datamerged$Sec_Block)])
sum(datamerged$Total)

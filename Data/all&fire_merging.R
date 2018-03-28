datafire<-read.csv("fire_counts_2017.csv")
datafire$Address<-gsub("Ave","AV",datafire$Address)
datafire$Address<-tolower(datafire$Address)
South<-unlist(gregexpr(" s ",datafire$Address))
South<-as.numeric(gsub(-1,0,South))
datafire$Address<-gsub(" s "," ",datafire$Address)
datafire$Address[South==TRUE]<-paste(datafire$Address[South==TRUE],"s")



North<-unlist(gregexpr(" n ",datafire$Address))
North<-as.numeric(gsub(-1,0,North))
datafire$Address<-gsub(" n "," ",datafire$Address)
datafire$Address[North==TRUE]<-paste(datafire$Address[North==TRUE],"n")

East<-unlist(gregexpr(" e ",datafire$Address))
East<-as.numeric(gsub(-1,0,East))
datafire$Address<-gsub(" e "," ",datafire$Address)
datafire$Address[East==TRUE]<-paste(datafire$Address[East==TRUE],"e")

West<-unlist(gregexpr(" w ",datafire$Address))
West<-as.numeric(gsub(-1,0,West))
datafire$Address<-gsub(" w "," ",datafire$Address)
datafire$Address[West==TRUE]<-paste(datafire$Address[West==TRUE],"w")


datamergedfire<-merge(datamerged,datafire,by.x="newaddress",by.y="Address"
                      ,all.y=TRUE)


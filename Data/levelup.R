data<-read.csv("2015.1-2016.1.csv")
datanew<-data.frame(data)
str(datanew)
list<-as.character(datanew$StNum)
list<-as.numeric(gsub("-.*","",list))
floor(list/100)*100

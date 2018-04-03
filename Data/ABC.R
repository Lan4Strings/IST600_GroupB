dataC<-read.csv('groupC_FinalData.csv')
colnames(dataC)[1]<-"Address"
load('datamerged.Rdata')
datamerged$block.address<-paste(datamerged$block.address,", Syracuse, NY")
dataABC<-merge(datamerged,dataC,by.x="block.address",by.y="Address")
                      #,all.x=TRUE,all.y=TRUE)
noAB<-dataABC[is.na(dataABC$Sec_Block),]
noC<-dataABC[is.na(dataABC$Occupied),]
sum(datamerged$Total[is.na(datamerged$Sec_Block)])
sum(datamerged$Total)
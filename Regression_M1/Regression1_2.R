##Zhaoheng Li
##3/1/2018



#View
#View(datamerged$WaterService)

library(car)

#read in datamerged
load("datamerged.RData")

#data cleaning 
#Choosing variables
colnames(datamerged)

#WaterService ##replace I with 0, replace A with 1
#View(datamerged$WaterService)
datamerged$WaterService<-gsub("I","0",datamerged$WaterService)
datamerged$WaterService<-gsub("A","1",datamerged$WaterService)


summary(datamerged$YearBuilt)


criticPredictors <- c("Seizable","Total.Taxes.Owed","VacantBuilding","WaterService","Aggravated.assault","Arson",
                      "Burglary","Larceny","Murder","Robbery","Vehicle.theft","Total")
regression.data<-datamerged[criticPredictors]
#View(regression.data)

#Data cleaning #VacantBuilding. Y, vacant; N,occupied
regression.data$VacantBuilding<-gsub("N","0",regression.data$VacantBuilding)
regression.data$VacantBuilding<-gsub("Y","1",regression.data$VacantBuilding)

#View(regression.data$VacantBuilding)
#View(regression.data$VacantBuilding)

##Clean Vacant Building, delete NA'
regression.data<-regression.data[which(regression.data$VacantBuilding!="NA"),]
sum(is.na(regression.data$VacantBuilding))
regression.data$VacantBuilding <- as.numeric(regression.data$VacantBuilding)


##Change format of tax owned 
##own something 1, own nothing 0
regression.data$Total.Taxes.Owed[regression.data$Total.Taxes.Owed!="0"]<-1
str(regression.data$Total.Taxes.Owed)


#Model codes 
lm1 <-glm(formula = VacantBuilding~Total.Taxes.Owed+WaterService+Aggravated.assault+Arson+Burglary+Larceny+
            Murder+Robbery+Vehicle.theft,data = regression.data,family = binomial(logit))
summary(lm1)




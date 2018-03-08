##Zhaoheng Li
##3/1/2018

#################################################################################
#read in datamerged
#View
#View(datamerged$WaterService)

load("C:/Users/zli50/knime-workspace/IST600_GroupB/Data/datamerged.Rdata")

library(car)

#data cleaning 

#Choosing variables
#.colnames(datamerged)

#WaterService ##replace I with 0, replace A with 1
#.View(datamerged$WaterService)

datamerged$WaterService<-gsub("I","0",datamerged$WaterService)
datamerged$WaterService<-gsub("A","1",datamerged$WaterService)


#.summary(datamerged$YearBuilt)


criticPredictors <- c("Seizable","Total.Taxes.Owed","VacantBuilding","WaterService","Aggravated.assault","Arson",
                      "Burglary","Larceny","Murder","Robbery","Vehicle.theft","Total")
regression.data<-datamerged[criticPredictors]
  #.View(regression.data)

#Data cleaning #VacantBuilding. Y, vacant; N,occupied
regression.data$VacantBuilding<-gsub("N","0",regression.data$VacantBuilding)
regression.data$VacantBuilding<-gsub("Y","1",regression.data$VacantBuilding)
  #.View(regression.data$VacantBuilding)
  #.View(regression.data)

###########################Debug################
################################################
structure(regression.data$VacantBuilding)

#omite NA for vacantBuilding
regression.data <- regression.data[which(regression.data$VacantBuilding!="NA")]
regression.data$VacantBuilding <- as.numeric(regression.data$VacantBuilding)
str(regression.data$VacantBuilding)

#as.numeric for waterservice
regression.data$WaterService <-as.numeric(regression.data$WaterService)

#################################################
#Model codes 
#logit modeling
lm1 <-glm(formula = VacantBuilding~WaterService+Aggravated.assault+Arson+Burglary+Larceny+
            Murder+Robbery+Vehicle.theft,data = regression.data,family = binomial(logit))
summary(lm1)



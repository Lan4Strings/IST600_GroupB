##############################
####Random Forest
install.packages("randomForest")
library("randomForest")
Syr_18 <- read.csv(choose.files(), 
                   header = TRUE)
Syr_18_new<-data.frame(Syr_18$Nhood, Syr_18$Num.Open.Violations,Syr_18$Total.Taxes.Owed,Syr_18$SURA, Syr_18$Seizable, Syr_18$TaxYrsDelinqu, Syr_18$AmtDelinqu, Syr_18$WaterService,  Syr_18$STARS)
Syr_18_new_NA<-na.omit(Syr_18_new)
dim(Syr_18_new_NA)
train=sample(1:nrow(Syr_18_new_NA),2500)
#We are going to use variable 'Syr_18$Num.Open.Violations' as the Response variable. We will fit 500 Trees.
#Fitting the Random Forest
#We will use all the Predictors in the dataset.

Syr_18_new_NA.rf<-randomForest(Syr_18.Num.Open.Violations ~ Syr_18.Nhood+Syr_18.Total.Taxes.Owed+Syr_18.SURA+Syr_18.Seizable+Syr_18.TaxYrsDelinqu+Syr_18.AmtDelinqu+Syr_18.WaterService+Syr_18.STARS , data = Syr_18_new_NA , subset = train)
Syr_18_new_NA.rf
#The above Mean Squared Error and Variance explained are calculated using Out of Bag Error Estimation.
#In this \(\frac23\) of Training data is used for training and the remaining \( \frac13 \) is used to 
#Validate the Trees. Also, the number of variables randomly selected at each split is 2.
#Plotting the Error vs Number of Trees Graph.

plot(Syr_18_new_NA.rf)
str(Syr_18_new_NA.rf)
#Now we can compare the Out of Bag Sample Errors and Error on Test set
#The above Random Forest model chose Randomly 2 variables to be considered at each split. 
#We could now try all possible 9 predictors which can be found at each split.
oob.err<-double(9)
test.err<-double(9)

##mtry is no of Variables randomly chosen at each split 
for(mtry in 1:9)
{
  rf=randomForest(Syr_18.Num.Open.Violations ~ . , data = Syr_18_new_NA , subset = train,mtry=mtry,ntree=500) 
  oob.err[mtry] = rf$mse[200] #Error of all Trees fitted
  
  pred<-predict(rf,Syr_18_new_NA[-train,]) #Predictions on Test Set for each Tree
  test.err[mtry]= with(Syr_18_new_NA[-train,], mean( (Syr_18.Num.Open.Violations - pred)^2)) #Mean Squared Test Error
  
  cat(mtry," ") #printing the output to the console
  
}
#Test Error

test.err
##  [1] 23.17994 23.92253 24.37945 24.72271 25.40540 25.53978 25.72206 25.86822 25.51475

#Out of Bag Error Estimation

oob.err
##  [1] 34.17986 34.80210 35.35758 35.83910 36.79176 37.12853 37.19232 38.44921 37.98618

#Plotting both Test Error and Out of Bag Error
matplot(1:mtry , cbind(oob.err,test.err), pch=19 , col=c("red","blue"),type="b",ylab="Mean Squared Error",xlab="Number of Predictors Considered at each Split")
legend("topright",legend=c("Out of Bag Error","Test Error"),pch=19, col=c("red","blue"))

######################
###Regression tree
install.packages("rpart")
library("rpart")
fit_18<-rpart(Syr_18.Num.Open.Violations~., data = Syr_18_new_NA, method="anova")

printcp(fit_18) # display the results 
plotcp(fit_18) # visualize cross-validation results
?printcp
summary(fit_18)
plot(fit_18)
# plot tree 
plot(fit_18, uniform=TRUE, 
     main="Regression Tree for Syr_17~18 ")
text(fit_18, use.n=TRUE, all=TRUE, cex=.8)
##################
install.packages("tree")
library("tree")
summary(tree(Syr_18.Num.Open.Violations~., data = Syr_18_new_NA))
#####??????Error in tree(Syr_18.Num.Open.Violations ~ ., data = Syr_18_new_NA) : factor predictors must have at most 32 levels
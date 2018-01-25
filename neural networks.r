setwd("directory name")
getwd()
concrete=read.csv("concrete.csv")
str(concrete)

#changing name of 9th column
colnames(concrete)[9]="strength"

#lets create a function called normalize to minimize the range of our columns
normalize<-function(x){
  return((x-min(x))/(max(x)-min(x)))
}

#normalizing the data 
concrete_norm<-as.data.frame(lapply(concrete,normalize))

#to confirm that normalizing worked,we can see that strength of min an max
summary(concrete_norm$strength)

#lets compare max and min values before normalization
summary(concrete$strength)

#train and test
concrete_train<-concrete_norm[1:773,]
concrete_test<-concrete_norm[774:1030,]


#training a model on the data
install.packages("neuralnet")
library(neuralnet)


concrete_model<-neuralnet(strength ~ cement+blast_furnace_slag+fly_ash+water+superplasticizer+coarse_aggregate+fine_aggregate+age,data=concrete_train)

#we can visualise the network topology
plot(concrete_model)

#testing 
concrete_model_test<-(compute(concrete_model,concrete_test[1:8]))
predicted_strength<-concrete_model_test$net.result
cor(predicted_strength,concrete_test$strength)


#improving model performance
concrete_model2<-neuralnet(strength ~ cement+blast_furnace_slag+fly_ash+water+superplasticizer+coarse_aggregate+fine_aggregate+age,data=concrete_train,hidden = 5)
plot(concrete_model2)


#applying same steps to compare the predictedvalues to true values
model_result2<-compute(concrete_model2,concrete_test[1:8])
predicted_strength2<-model_result2$net.result

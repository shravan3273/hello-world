#multiple regression 
data=read.csv("50_Startups.csv")
#encoding the state variable
data$State=factor(data$State,levels=c('New York','California','Florida'),labels=c(1,2,3 ))


#splitting the dataset into train and test
library(caTools)
split=sample.split(data$Profit,SplitRatio=0.8)
train=subset(data,split==TRUE)
test=subset(data,split==FALSE)


#fitting multiple linear regression to train set
regressor=lm(formula = Profit ~ .,data=train)


#predictions on test sets
y_pred=predict(regressor,test)
y_pred


#building the optional model using backward Elimination 
regressor=lm(formula = Profit ~ R.D.Spend+Administration+Marketing.Spend+State,data=data)
summary(regressor)

#removing state
regressor=lm(formula = Profit ~ R.D.Spend+Administration+Marketing.Spend,data=data)
summary(regressor)



#removing admnistration
regressor=lm(formula = Profit ~ R.D.Spend+Marketing.Spend,data=data)
summary(regressor)

#marketing spend
regressor=lm(formula = Profit ~ R.D.Spend,data=data)
summary(regressor)







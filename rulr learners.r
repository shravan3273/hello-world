setwd("C:/Users/PAVAN KUMAR/Documents/data science")
getwd()
mushroom=read.csv("mushrooms.csv",stringsAsFactors = TRUE)
str(mushroom)

#17th variable is fishy that a factor has only one level and doesnt provide any valuable information 
mushroom<-mushroom[-17]

#changing colnames
colnames(mushroom)[1]="type"

#distribution of mushroom "type" variable
table(mushroom$type)

#installing package
install.packages("RWeka")
library(RWeka)


#consider all possible features in the mushroom data
mushroom_1R<-OneR(type ~ .,data=mushroom)


#examine the rules it created
mushroom_1R

#obtain additional details about classifier
summary(mushroom_1R)


#let's train Jrip() rule learner
mushroom_JRip<-JRip(type ~ .,data=mushroom)
mushroom_JRip



---
title: "New York City Precipitation Prediction"
author: "Chi Dao Lam"
date: "11/9/2020"
output: html_document
---

#Load add-on packages
library(tidyverse)
library(caret)
library(broom)

#Read in data set
df <- read.csv(file = 'nyc_weather.csv') #Data set from FiveThrityEight's GitHub
head(df)

#Data manipulation
##Create "precip" variable with binary value: "yes" & "no"
df$precip[df$actual_precipitation > 0] <- 'yes'
df$precip[df$actual_precipitation == 0.00] <- 'no'

##Create new variable "day_num"
df <- df %>% 
  mutate(day_num = c(1:365))

##Create new data frame with three variables: "actual_min_temp", "actual_max_temp", and "precip".
df2 <- df %>% 
  select(c(3,4,14))

head(df2)

#Data visualization
##"actual_min_temp"
ggplot(data=df, aes(x=day_num, y=actual_min_temp, color = precip)) +
  geom_line()+
  geom_point()+
  labs(title="Figure n: line plot of acutal minimum temperature of the 365 days")

##"actual_max_temp"
ggplot(data=df, aes(x=day_num, y=actual_max_temp, color = precip)) +
  geom_line()+
  geom_point()+
  labs(title="Figure n: line plot of acutal maximum temperature of the 365 days")

#Train-test split: 80 - 20
set.seed(1)
train.index <- createDataPartition(y = df2$precip, p = 0.80, list = F)

weather.train <- df2 %>% 
  slice(train.index)

weather.test <- df2 %>% 
  slice(-train.index)

#Data normalization
weather.train.proc <- preProcess(weather.train, method = c("center","scale"))

weather.train.transformed <- predict(weather.train.proc, weather.train)
weather.test.transformed <- predict(weather.train.proc, weather.test)

#Model building: K-nearest neighbor
weather.train.knn <- train(form = precip ~ ., method = "knn", data = weather.train.transformed)

#Hyperparameter tuning
weather.knn.big.grid <- train(form = precip ~ .,
                              method = "knn",
                              data = weather.train.transformed,
                              tuneGrid = data.frame(k = c(1:30)))

##Graphing number of neighbors against accuracy
plot <- ggplot(weather.knn.big.grid, highlight = T)
print(plot + ggtitle("Figure n: # of Neighbors VS. Accuracy"))

#Prediction
weather.y.hat.big.grid <- predict(weather.knn.big.grid, weather.test.transformed)
confusionMatrix(table(weather.y.hat.big.grid, weather.test.transformed$precip))

#Data manipulation: change "precip" variable into binary values: 1 & 0
check.train <- ifelse(weather.train$precip == 'yes', 1,0)
weather.train$precip <- check.train

check.test <- ifelse(weather.test$precip == 'yes', 1,0)
weather.test$precip <- check.test

#Model building: logistic regression
m.weather.fit <- glm(precip ~ actual_min_temp + actual_max_temp,data = weather.train,family = binomial)

#Prediction
m.weather.fit.pred <- predict(m.weather.fit,newdata = weather.test,type = 'response')

m.weather.fit.pred.answers <- ifelse(m.weather.fit.pred >= 0.5, 1,0)

confusionMatrix(table(m.weather.fit.pred.answers,weather.test$precip))

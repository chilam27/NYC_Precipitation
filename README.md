# NYC_Precipitation_Prediction

Use temperatures as features in order to deduce whether or not it will precipitate on a given day in New York City using k-nearest neighbor classification and logistic regression. With input data downloaded from FiveThirtyEight's GitHub, I will compare to see which model predicts better than the other.

## TL;DR



## Table of Contents

* [Background and Motivation](#background-and-motivation)
* [Prerequisites](#prerequisites)
* [Project Outline](#project-outline)
  * [Data Preprocessing](#data-preprocessing)
  * [Exploratory Data Analysis](#eda)
  * [Model Building](#model-building)
  * [Overall Model Performance](#overall-model-performance)
* [Conclusion](#conclusion)
* [Author](#author)
* [Acknowledgments](#acknowledgments)

## Background and Motivation

I picked this fairly simple topic with two main purposes: practice my R skill and to see whether temperature alone is good enough to predict the precipitation. NYC rains pretty often and people have to adjust their lifestyles accordingly to the environment. My friends told me not to rely on the weather forecast too much when visiting the city and just always be prepared instead. Sure, carrying an umbrella with me is not too bad. But considering other aspects, such as an outdoor business or an outdoor concert, it would be a big deal for them to know what the weather is going to be like to plan accordingly.

Before starting this project, I asked myself "how hard can it be to predict the weather?". Nowadays weather forecasting has become as accurate as it has ever been. With the amount of technology and data involved, there is no doubt that it is the case. Frankly, the data set I got only has information about the temperature and precipitation of NYC. The question that I hope to be answered if I finished the project is how accurate I can be using just temperature data and machine learning models to predict whether it is going to rain in the city or not?

## Prerequisites

R version: 3.6.1

Packages: tidyverse, caret, broom.

## Project Outline

1. Data Preprocessing: read in and clean the [data set](https://github.com/fivethirtyeight/data/blob/master/us-weather-history/KNYC.csv) from FiveThirtyEight's GitHub; select only features I need for the project.

2. Exploratory Data Analysis (EDA): analyze the target variable (precipitation) against other variables to analyze any visible relationship.

3. Model Building: split the data into the train-test split (80-20) and build two machine learning models: k-nearest neighbors and logistic regression.

4. Overall Model Performance: use accuracy scores from the confusion matrix as the main metric to compare the two models.

### Data Preprocessing

* Read in the CSV data set and glance through it to have a general understanding of the records and variables.

<p align="center">
  <img width="800" height="400" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f1.png">
</p>

* Create a new variable, "precip", that transforms numeric precipitation data value into categorical values of yes (did precipitate) or no (did not precipitate).

* Create a new variable, "day_num", that returns values from 1 to 365 to indicate the number of dates in the data set.

* Create a sub data frame with only three variables: "actual_min_temp", "actual_max_temp", and "precip". These are the only variables in the data frame that is worth taking into consideration when building my machine learning prediction model.

<p align="center">
  <img width="500" height="300" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f2.png">
</p>

### EDA

* I plot this first line graph to see if there is any visible relationship pattern of the actual minimum temperature (Fahrenheit). The clearest observation is the data pattern itself. Since the first data is recorded in July of 2014 and ended in June of 2015, the temperature starts high (around 68 F) then drops significantly (around 10 F) after 200 days (winter period) and then raises again to the temperature it starts at. The most interesting pattern I observed from the graph is, especially for the colder periods, NYC precipitates more often when the actual minimum temperature is higher than average for those periods. When it comes to the warmer periods, that pattern is not as clear anymore. 

<p align="center">
  <img width="700" height="400" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f3.png">
</p>

* I also plot this second line graph with the same concept as the one above, but this is for the actual minimum temperature. Besides the obvious data pattern (with a different scale) I stated above, my temperature and precipitation observation can also be seen a little bit more clear in this graph. This time, I can see in the warmer periods that the city precipitates more often when the actual maximum temperature is below average for those periods.

<p align="center">
  <img width="700" height="400" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f4.png">
</p>

### Model Building

* Split the sub data frame into training (80%) and testing (20%) sets using `createDataPartition()`

* Normalize both data sets using `preProcess()` with the "center" and "scale" as the function's method. "center" subtracts the mean of the predictor's data from the predictor values while "scale" divides by the standard deviation.

* K-nearest neighbor (knn): the first model I create is knn. But instead of just perform a simple knn model with a random k value, I will apply hyperparameter tunning to bet the best k value for the model. I test out k values range from 1 to 30 using `train()` then plot the line graph of the number of neighbors against the accuracy score. According to figure 5, the best k value we should use for our model is 30 (which returns around a 0.64 accuracy score).

```r
weather.knn.big.grid <- train(form = precip ~ .,
                              method = "knn",
                              data = weather.train.transformed,
                              tuneGrid = data.frame(k = c(1:30)))
```

<p align="center">
  <img width="600" height="400" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f5.png">
</p>

* Using the best k value for the knn model, I apply it to the testing set and return the prediction information by printing the confusion matrix and related statistics using `confusionMatrix()`.

<p align="center">
  <img width="500" height="700" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f6.png">
</p>

* Logistic regression: before building the model, I need to translate the values in "precip" variables from categorical into binary values 1 ("yes") or 0 ("no"). Then, I build the logistic regression model with the training set.

```r
m.weather.fit <- glm(precip ~ actual_min_temp + actual_max_temp,data = weather.train,family = binomial)
```

* Similar to the knn model above, I use the model to predict the testing set and return the prediction information using `confusionMatrix()`.

<p align="center">
  <img width="500" height="700" src="https://github.com/chilam27/NYC_Precipitation_Prediction/blob/main/readme_image/f7.png">
</p>

### Overall Model Performance

Based on the accuracy scores from the two models' confusion matrixes, the logistic regression model performs a little better (with an accuracy score of 0.68) compare to the k-nearest neighbor model (with an accuracy score of 0.62). Besides the accuracy score, the confusion matrix also tells us whether the model is worth using by telling us the rate of false-negative (FN) and false-positive (FP). From the logistic regression model, the rate of FN is 22 while the rate for FP is only 1. This means that the model tends to predict that it will not precipitate when it will (this is also the case for the knn model). 

## Conclusion

With an accuracy score slightly above 0.5 and knowing its FN and FP rates, I can say that the logistic regression model is an average model to use for predicting the precipitation in NYC (user should expect that the model sometime will predict it will not precipitate when it will). I reach the conclusion that just temperature data alone is not good enough to predict the precipitation.

If I want to improve this project in the future, there are two areas I would want to change. First, I should gather more features (such as wind speed, humidity, etc.) to strengthen the prediction. I do not know if more data records would be necessary but that is something that I can take into consideration. Lastly, I want to use more classification models to see whether they would give a better prediction than the ones I used above.

## Author

* **Chi Lam**, _student_ at Michigan State University - [chilam27](https://github.com/chilam27)

## Acknowledgments

[Bronshtein, Adi. “A Quick Introduction to K-Nearest Neighbors Algorithm.” Medium, Noteworthy - The Journal Blog, 11 Apr. 2017.](https://blog.usejournal.com/a-quick-introduction-to-k-nearest-neighbors-algorithm-62214cea29c7)

[Olson, Randy. “Fivethirtyeight/Data.” GitHub, Fivethirtyeight, 21 July 2015.](github.com/fivethirtyeight/data/blob/master/us-weather-history/KNYC.csv)

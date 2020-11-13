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

1. Data Preprocessing: read in and clean the data; select only features I need for the project.

2. Exploratory Data Analysis (EDA): analyze the target variable (precipitation) against other variables to analyze any visible relationship.

3. Model Building: split the data into the train-test split (80-20) and build two machine learning models: k-nearest neighbors and logistic regression.

4. Overall Model Performance: use accuracy scores and confusion matrix as the main metric to compare the two models.

### Data Preprocessing



### EDA



### Model Building



### Overall Model Performance



## Conclusion



## Author

* **Chi Lam**, _student_ at Michigan State University - [chilam27](https://github.com/chilam27)

## Acknowledgments

[Bronshtein, Adi. “A Quick Introduction to K-Nearest Neighbors Algorithm.” Medium, Noteworthy - The Journal Blog, 11 Apr. 2017.](https://blog.usejournal.com/a-quick-introduction-to-k-nearest-neighbors-algorithm-62214cea29c7)

[Olson, Randy. “Fivethirtyeight/Data.” GitHub, Fivethirtyeight, 21 July 2015.](github.com/fivethirtyeight/data/blob/master/us-weather-history/KNYC.csv)

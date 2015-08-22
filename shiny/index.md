---

title       : A Shiny and Slidify Project
subtitle    : Coursera Data products RStudio Presentation 
author      : Usha
job         : August 21 2015
framework   : revealjs        # {io2012,revealjs, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

The shiny app under development allows a user to input some basic information about mtcars, and obtain a prediction for its MPG(Miles Per Gallon). The app relies on  MLR on “mtcars” dataset.This app has tabbed panel where user can select  predict/summary/HTML table view/Diagnostic Plots of mtcars dataset. Depending upon user selection mtcars data is displayed.

Access to the application

<a href="https://sony111.shinyapps.io/Cars"> Live version on ShinyApps</a>

<a href="https://github.com/Sony111/Developing-Data-Products"> Code and data on GitHub </a>

--- .class #id 

##  MLR and Prediction

A multiple linear regression (MLR) model that describes a dependent variable y by independent variables x1, x2, ..., xp with error.For example, in the built-in data set mtcars from observations of a Motor Trend car road Tests comprises fuel consumption,automobile design and performance. First Transform the dataset (cyl,gear,am,vs as factor variables).lm is used to fit linear model by taking all the dependent variables into account.Choose a model by AIC in a stepwise Algorithm by this leaner model as an argument.Then, the obtained model has 3 (wt,qsec,am) independent variables. Thus independent variables values are taken as user inputs and predict the dependent variable i.e MPG 


--- 

We now apply the predict function and set the predictor variable in the newdata argument. We also set the interval type as predict and use the default 0.95 confidence level.
               
               

```r
# transforming into factor variables
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)

# mtcars structure after tranformation 
str(mtcars)

# fitting linear model
model <- lm(mpg ~. ,  data=mtcars)

# Choose a model by AIC in a Stepwise Algorithm
best_model <- step(model,direction="both")

# generate model summary
summary(best_model)
# we ,Qsec,Trans are user inputs from ui.R
    #  newdata = data.frame(wt=we(),qsec=input$Qsec, am=input$Trans)
    # user inputs are sending as a parameter for predict function
    #  myp  <- predict(best_model,newdata , interval = "predict")
```

--- 

## Summary / Table view / Diagnostic Plots

user can view Summary or HTML table view of mtcars dataset.Diagnostic plots provide checks for heteroscedasticity, normality, and influential observerations.


```r
# to display summary of mtcars 
summary(mtcars)
# Generate an HTML table view of the data (in server.R)
     data.frame(mtcars)
# optional 4 graphs/page (written in server.R)
     layout(matrix(c(1,2,3,4),2,2,byrow=T))
     plot(best_model)
```


--- 

## Shiny app

All you have to do is to enter the values click on the Predict! button and immediately you will see the predicted MPG values with upper and lower bound limits (in red color). It was tested and worked fine.





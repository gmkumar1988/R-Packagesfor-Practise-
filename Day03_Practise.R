library(kernlab)
data("spam")
spam$capitalAvesq <- spam$capitalAve^2
head(spam$capitalAvesq)

library(ISLR)
library(caret)
data(Wages)
Intrain <- createDataPartition(y = Wage$wage,
                               p = 0.7, list = FALSE)
training <- Wage[Intrain,]
testing <- Wage[-Intrain,]

View(training)

table(training$jobclass)

dummies <- dummyVars(wage ~ jobclass, data = training )
head(predict(dummies, newdata = training ))

###Removing Zero Covariance###
nsu <- nearZeroVar(training, saveMetrics = TRUE)
nsu

###Spline Basis###
library(splines)
bsBasics <- bs(training$age, df = 3)
bsBasics

###Fitting curves with SP lines ###
lm1 <- lm(wage ~ bsBasics, data = training)
plot(training$age, training$wage, pch = 19, cex = 0.5)
points(training$age, predict(lm1, newdata = training), col = "red",pch = 19, cex = 0.5)

predict(bsBasics, age = testing$age)





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


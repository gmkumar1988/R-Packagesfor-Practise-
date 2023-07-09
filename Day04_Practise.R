###Correlated Predictors###
library(kernlab)
library(ISLR)
library(caret)
data(spam)

inTraining <- createDataPartition(y = spam$type, 
                                  p = 0.7, list = FALSE)
training <- spam[inTraining,]
testing <- spam[-inTraining,]
M<- abs(cor(training[,-58]))
View(M)
diag(M) <- 0 
which(M > 0.8, arr.ind = T)
names(spam) [c(34,32)]
plot(spam[,34], spam[,32], xlab = "Spam of 34", ylab = "Spam of 32")

###Predicting with Regression###
#Fit Simple regression model 
library(caret)
data("faithful")
set.seed(333)
intrain <- createDataPartition(y= faithful$waiting,
                                  p = 0.5, list = FALSE)

# rm(trainfaith)
trainfaith <- faithful[intrain,]
testfaith <- faithful[-intrain,]

head(trainfaith)
plot(trainfaith$waiting, trainfaith$eruptions, pch = 19, col="blue",
     xlab = "Waiting", ylab = "Eruptions")

lml <- lm(trainfaith$eruptions ~ trainfaith$waiting)
summary(lml)

plot(trainfaith$waiting, trainfaith$eruptions, pch = 19, col="blue",
     xlab = "Waiting", ylab = "Eruptions")
lines(trainfaith$waiting, lml$fitted.values, lwd = 3)
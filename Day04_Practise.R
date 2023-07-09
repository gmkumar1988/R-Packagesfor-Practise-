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
plot(spam[,34], spam[,32])

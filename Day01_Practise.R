install.packages("caret")
library(caret)
install.packages("kernlab")
library(kernlab)
data("spam")
View(spam)

#Partitioning the spam data set or other words it is called data splitting :
###Data Splitting : 
intrain <- createDataPartition(y= spam$type, p = 0.75, list = FALSE)

head(intrain)
training <- spam[intrain,]
testing <- spam[-intrain,]
dim(training)


###Fitting a model :
set.seed(32343)
modelfit <- train(type ~., data = training, method = "glm")
modelfit

###Final Model : 
modelfit <- train(type ~., data = training, method = "glm")
modelfit$finalModel

###Prediction 
prediction <- predict(modelfit, newdata = testing)
prediction

confusionMatrix(prediction, testing$type)

###################Data Slicing######################
###Data Splitting : 
intrain <- createDataPartition(y= spam$type, p = 0.75, list = FALSE)

head(intrain)
training <- spam[intrain,]
testing <- spam[-intrain,]
dim(training)

###Cross validation: --- Breaking the training set into multiple chunks 
set.seed(32323)
folds <- createFolds(y = spam$type, k = 10, 
                     list = TRUE, returnTrain = TRUE)
sapply(folds,length)

folds[[1]] [1:10]


####Time slices 
set.seed(32323)
tme <- 1:1000
folds <- createTimeSlices(y = tme, initialWindow = 20, horizon = 10)

names(folds)
folds$train[1]
folds$test[1]
folds$train[2]
folds$test[2]
folds$train[3]
folds$test[3]


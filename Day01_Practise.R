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

data("iris")
library(ggplot2)
names(iris)
table(iris$Species)

library(kernlab)
library(caret)

intrain <- createDataPartition(y = iris$Species, 
                               p = 0.7 , list = FALSE)
training <- iris[intrain,]
testing <- iris[-intrain,]

dim(training)
dim(testing)

qplot(training$Petal.Width, training$Sepal.Width, colour = training$Species, data = training,
      xlab = "Petal Width", ylab = "Sepal Width")

library(caret)
library(rpart)
modfit <- train(Species~ ., method = "rpart", 
                data = training)
print(modfit$finalModel)

plot(modfit$finalModel, uniform = TRUE, 
     main = "Classification Tree")
text(modfit$finalModel, use.n = TRUE, all = TRUE, cex = 0.8)


install.packages("rattle")
library(rattle)
fancyRpartPlot(modfit$finalModel)

predict(modfit, newdata = testing)

# install.packages("ElemStatLearn")
# library(ElemStatLearn)


###Random Forests ###
data(iris)
library(ggplot2)
intrain <- createDataPartition(y = iris$Species, 
                               p = 0.7, list = FALSE)
rm(training)
training <- iris[intrain,]
testing <- iris[-intrain,]

library(caret)
install.packages("randomForest")
library(randomForest)
modfit <- train(Species ~ ., data = training, method = "rf", prox = TRUE)
modfit

getTree(modfit$finalModel, k = 2)

irisP <- classCenter(training[, c(3,4)], training$Species, modfit$finalModel$proximity)
irisP <- as.data.frame(irisP)
irisP$Species <- rownames(irisP)

View(irisP)
p <- qplot(training$Petal.Width, training$Petal.Length, colour = training$Species,
           data = training)
p + geom_point(aes(x = Petal.Width, y = Petal.Length, col = Species
                   ), size = 5, shape = 4, data = irisP)

pred <- predict(modfit, testing)
testing$predRight <- pred == testing$Species
table(pred,testing$Species)

qplot(Petal.Width, Petal.Length, data = testing, colour = predRight,main = "New Data Predictions ")

###Boosting###
library(ISLR)
data("Wage")
library(caret)
library(ggplot2)
Wage <- subset(Wage, select= -c(logwage))
intraing <- createDataPartition(y = Wage$wage,
                                p = 0.7, list = FALSE)
training <- Wage[intraing,]
testing <- Wage[-intraing,]

modfit <- train(wage ~ ., method = "gbm", data = training, verbose = FALSE)
print(modfit)
qplot(predict(modfit, testing), wage, data = testing)

###Combine Predictors###
library(ISLR)
data("Wage")
library(ggplot2)
library(caret)
Wage <- subset(Wage, select = -c(logwage))

#Creating data partition 
inbuild <- createDataPartition(y = Wage$wage, 
                               p = 0.7, list = FALSE)

validation <- Wage[-inbuild,]
buildata <- Wage[inbuild,]
intrain <- createDataPartition(y = buildata$wage, 
                               p = 0.7, list = FALSE)
training <- buildata[intrain,]
testing <- buildata[-intrain,]

dim(training)
dim(testing)
dim(validation)

mod1 <- train(wage ~. , method = "glm", data = training)
mod2 <- train (wage ~ ., method = "rf",
               data = training, 
               trControl = trainControl(method = "cv"), number = 3)
pred1 <- predict(mod1, testing)
pred2 <- predict(mod2, testing)
qplot(pred1,pred2, colour = wage, data = testing)


###Forecast###
install.packages("quantmod")
library(quantmod)
from.dat <- as.Date("01/01/08", format = "%m/%d/%y")
to.dat <- as.Date("01/01/13", formt = "%m/%d/%y")
getSymbols("MSFT",src = "yahoo", from = from.dat, to = to.dat)
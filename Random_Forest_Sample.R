library(dplyr)
library(randomForest)
library(caret)
install.packages("e1071")
library(e1071)
main_dataset <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/train.csv")
# data_train <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/train.csv")

glimpse(data_train)
####Iris Data Set ML Model - Random Forest : 
data("iris")
dataset <- iris

colnames(dataset)
validation_index <- createDataPartition(dataset$Species,p = 0.8, list = FALSE)
validation <- dataset[-validation_index]
dataset <- dataset[validation_index,]

dim(dataset)
sapply(dataset,class)

head(dataset)

levels(dataset$Species)
percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq = table(dataset$Species), percentage = percentage)
summary(dataset)
View(dataset)
x <- dataset[,1:4]
y <- dataset[,5]

par(mfrow = c(1,4))
for(i in 1:4) {
  boxplot(x[i], main = names(iris)[i])
}

plot(y)
featurePlot(x=x, y=y, plot= "ellipse")
featurePlot(x=x, y= y, plot = "box")

scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x = x, y = y, plot = "density", scales = scales)

control <- trainControl(method = "cv", number = 10)
metric <- "Accuracy"

set.seed(7)
#Linear Model Algorithms
fit.lda <- train(Species~., data = dataset, method = "lda", metric = metric, trControl = control )
#Non Linear Model Algorithm: 

set.seed(7)
fit.cart <- train(Species~., data = dataset, method = "rpart",metric = metric, trControl = control)
#KNN

set.seed(7)
fit.knn <- train(Species~., data = dataset, method = "knn", metric = metric, trControl = control)
#SVM

set.seed(7)
fit.svm <- train(Species~., data = dataset, method = "svm", metric = metric, trControl = control)
#RFM

set.seed(7)
fit.rf <- train(Species~., data = dataset, method = "rf", metric = metric, trControl= control)
#Summarize accuracy of models 
results <- resamples(list(lda = fit.lda, cart = fit.cart, knn = fit.knn, rf = fit.rf))
summary(results)

dotplot(results)

print(fit.lda)

predictions <- predict(fit.lda, validation)




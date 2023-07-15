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
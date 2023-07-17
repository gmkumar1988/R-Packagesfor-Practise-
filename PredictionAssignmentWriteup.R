install.packages("knitr")
install.packages(c("rattle","lattice","ggplot2","caret","rpart.plot","corrplot","RColorBrewer"))

library(rattle)
library(ggplot2)
library(caret)
library(rpart)
library(rpart.plot)
library(corrplot)
library(corrplot)
library(RColorBrewer)
library(lattice)
library(randomForest)
library(plotly)
library(gbm)

training_data <- read.csv("/Users/maheshg/Downloads/pml-training.csv", header = TRUE)
testing_data <- read.csv("/Users/maheshg/Downloads/pml-testing.csv", header = TRUE)

dim(training_data)
dim(testing_data)

intrain <- createDataPartition(y = training_data$classe, 
                               p = 0.7, list = FALSE)
training_set <- training_data[intrain, ]
testing_set <- training_data[-intrain,]

dim(training_set)
dim(testing_set)

###Data Preparation - Cleansing - Near Zero Values from the variables are moved to ID variables 
nzv_var <- nearZeroVar(training_set)
training_set <- training_set[, - nzv_var]
testing_set <- testing_set[ , - nzv_var]

dim(training_set)
dim(testing_set)

###Removing variables that are mostly has NA values ###
variable_na <- sapply(training_set, function (x) mean(is.na(x))) > 0.95
training_set <- training_set [ , variable_na == FALSE]
testing_set <- testing_set[ , variable_na == FALSE]
dim(training_set)
dim(testing_set)

training_set <- training_set[, -(1:5)]
testing_set <- testing_set[, -(1:5)]

dim(training_set)
dim(testing_set)


###Performing Correlation among the variables ###
matrix_corr <- cor(training_set[,-54])
corrplot(matrix_corr, order = "FPC", method = "circle", type = "lower",
         t1.cex = 0.6, t1.col = rgb(0,0,0))

###Decision Tree Model - Methods used - Decision Tree, Generalized Boosted Model and Random Forests 

set.seed(1967)
fit_DT <- rpart(training_set$classe ~ ., data = training_set, method = "class")
fancyRpartPlot(fit_DT)

predict_DT <- predict(fit_DT, newdata = testing_set, type = "class")
conf_matrix_DT <- confusionMatrix(table(predict_DT, testing_set$classe))
conf_matrix_DT
plot(conf_matrix_DT$table, col = conf_matrix_DT$byClass, 
     main = paste("Decision Tree Model: Predictive Accuracy =",
                  round(conf_matrix_DT$overall['Accuracy'], 4)))
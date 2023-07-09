install.packages("caret")
library(caret)
install.packages("kernlab")
library(kernlab)
data("spam")
# View(spam)

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

###Train options 
args(train.default)

############Plotting Predictors ########
install.packages("ISLR")
library(ISLR)
library(ggplot2)
library(caret)
data("Wage")
summary(Wage)

intrain <- createDataPartition(y = Wage$age, 
                               p = 0.7, list = FALSE)
training <- Wage[intrain,]
testing <- Wage[-intrain,]
dim(training)
dim(testing)
featurePlot(x = training[,c("age","education","jobclass")],
            y = training$wage,
            plot = "pairs")

qplot(age,wage, data = training)
qplot(age, wage, colour = jobclass, data = training)
qq <- qplot(age,wage, colour = education, data = training)
qq + geom_smooth(method = 'lm',formula = y ~x)
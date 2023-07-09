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

###Estimate Eruption Duration###
ed = coef(lml)[1] + coef(lml)[2] *80

newdata <- data.frame(waiting = 90)

predict(lml,newdata)

par(mfrow = c(1,2))
plot(trainfaith$waiting, trainfaith$eruptions, pch = 19, col = "blue",
     xlab = "waiting", ylab = "duration")
lines(trainfaith$waiting, predict(lml), lwd = 3)
plot(testfaith$waiting, testfaith$eruptions, pch = "blue",
     xlab = "waiting", ylab = "duration")
lines(testfaith$waiting, predict(lml, newdata = testfaith), lwd = 3)


###Regression with Multiple covariates###
library(ISLR)
library(ggplot2)
library(caret)
data("Wage")
View(Wage)
Wage1 <- subset(Wage, select = -c(logwage))
View(Wage1)
summary(Wage1)
intrain <- createDataPartition( y= Wage1$age, 
                                p = 0.7, list = FALSE)
training <- Wage1[intrain,]
testing <- Wage1[-intrain,]
dim(training); dim(testing)

###Feature Plot###
featurePlot(x = training[,c("age","education","jobclass")],
            y = training$wage,
            plot = "pairs")
qplot(age, wage, color = jobclass, data = training)

qplot(age, wage, color = education, data = training)

modfit <- train(wage ~ age + jobclass + education, 
                method = "lm", data = training)
finmod <- modfit$finalModel
print(finmod)
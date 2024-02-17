install.packages("dplyr")
install.packages("tidyverse")
library(dplyr)
library(tidyverse)
x <- (1:5)
y = (1:5)
y
z = data.frame(x,y)
z
a = sum(z)
length(a)
rates <- c(0.06, 0.07, 0.05, 0.09, 0.09, 
           0.08, 0.08, 0.08)
t <- seq(1,8)
print(t)
pv.1 <- sum(1/(1+ rates)^t)
print(pv.1)

#####
###Required Packages 
library(tidyverse)
install.packages("caret")
library(caret)
install.packages("mlbench")
library(mlbench)
data("PimaIndiansDiabetes2")
View(PimaIndiansDiabetes2)
??set.seed()
library(dplyr)

###Remove the na values from the dataset before moving to EDA : 
PimaIndiansDiabetes2 <-  na.omit(PimaIndiansDiabetes2)
###Creating Partitions and defining the samples from the dataset : 
training_samples <- PimaIndiansDiabetes2$diabetes %>%
  createDataPartition(p = 0.8, list = FALSE)

###Segregating training and testing data separately : 
trainingdata_samples <- PimaIndiansDiabetes2[training_samples,]
testigdata_sample <- PimaIndiansDiabetes2[-training_samples,]
###Building up the model : 
model <- glm(diabetes ~., data = trainingdata_samples, family = binomial())
summary(model)

###Making Predictions :
probability <- model %>%
  predict(testigdata_sample, type = "response")
predicted.classes <- ifelse(probability > 0.5, "pos","neg")
###Model Accuracy : 
mean(predicted.classes == testigdata_sample$diabetes)

model <- glm(diabetes ~ glucose, data = trainingdata_samples, family = binomial)
summary(model) $coef

newdata <- data.frame(glucose = c(20,150))

probability_1 <- model %>% predict(newdata, type = "response")
predicted.classes_1 <- ifelse(probability_1 > 0.5, "pos","neg")
predicted.classes_1

trainingdata_samples %>%
  mutate(prob = ifelse(diabetes == "pos", 1,0)) %>%
  ggplot(aes(glucose,prob)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  labs(
    title = "Logistic Regression Model (Taking Glucose as single predictor variable)",
    x = "Plasma Glucose Concentration",
    y = "Probability of being Diabetes"
  )

###Multiple Logistic Regression: 
model <- glm(diabetes ~ glucose + mass + pregnant, 
             data = trainingdata_samples, family = binomial)

summary(model) $coef
coef(model)

model <- glm(diabetes ~ glucose + mass + pregnant + mass + pedigree, 
             data = trainingdata_samples, family = binomial)

probability_2 <- model %>% predict(testigdata_sample, type = "response")
contrasts(testigdata_sample$diabetes)

predicted.classes <- ifelse(probability_2 > 0.5, "pos","neg")
head(predicted.classes)
mean(predicted.classes == testigdata_sample$diabetes)

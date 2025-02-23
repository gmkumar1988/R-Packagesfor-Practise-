library(dplyr)
library(tidyverse)
library(e1071)
library(ROCR)
library(rsample)
library(randomForest)
library(caret)
library(partykit)

customer_behavior <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Customer_Behaviour.csv", 
                              header = TRUE)
head(customer_behavior)
glimpse(customer_behavior)
is.na(customer_behavior)
customer_behavior |> 
  dplyr::mutate(customer_behavior = replace_na(customer_behavior$Purchased,0))

###Data Wrangling: 
#Classification of Ages from the dataset: 
customer_behavior$Age[customer_behavior$Age <= 25] = "Young"
customer_behavior$Age[customer_behavior$Age > 25 & customer_behavior$Age <= 45] = "Adult"
customer_behavior$Age[(customer_behavior$Age != "Young") & (customer_behavior$Age != "Adult")] = "Middle Age"

#Classification of Age based on the salaries : 
customer_behavior$EstimatedSalary[customer_behavior$EstimatedSalary <= 5000 ] = "Low"
customer_behavior$EstimatedSalary[customer_behavior$EstimatedSalary > 5000 & customer_behavior$EstimatedSalary <= 9000] = "Moderate"
customer_behavior$EstimatedSalary[(customer_behavior$EstimatedSalary != "Low") & (customer_behavior$EstimatedSalary != "Moderate")] = "High"

###Data Cleansing:
customer_behavior_clean <- customer_behavior |> 
  mutate(Gender = as.factor(Gender),
         Age = as.factor(Age),
         EstimatedSalary = as.factor(EstimatedSalary),
         Purchased = as.factor(Purchased)) |> 
  select(-User.ID)

###Checking Missing Values in the customer behaviour dataset:
colSums(is.na(customer_behavior_clean))

###Splitting the value into two - train and test data [Cross Validation]:
RNGkind(sample.kind = "Rounding")
set.seed(1234)
index <- sample(nrow(customer_behavior_clean), nrow(customer_behavior_clean) * 0.8)
customer_behavior_train <- customer_behavior_clean[index,]
customer_behviour_test <- customer_behavior_clean[-index,]

###Checking target proportion: 
prop.table(table(customer_behavior_train$Purchased))

###Balancing between train and test dataset: 
set.seed(1234)
customer_behavior_train_down <- downSample(x = customer_behavior_train |> 
                                             select(-Purchased),
                                           y = customer_behavior_train$Purchased,
                                           yname = "Purchased")
prop.table(table(customer_behavior_train_down$Purchased))

###Naive Bayes Model 
#model fitting using Naive Bayes Model : 
customer_behaviour_model_nb <- naiveBayes(formula = customer_behavior_train_down$Purchased~., data = customer_behavior_train_down)

customer_behaviour_model_nb
###Model Evaluation/ Prediction 
customer_prediction_naive <- predict(customer_behaviour_model_nb, newdata = customer_behviour_test, type = "class")
###Evaluation of model using confusion matrix : 
confusionMatrix(data = customer_prediction_naive, reference = customer_behviour_test$Purchased, # nolint
                positive = "1")

###Decision Tree Model 
###Model fitting
customer_behavior_model_decisiontree <- ctree(formula = customer_behavior_train_down$Purchased~.,
                                              data = customer_behavior_train_down)
###Plotting the decision tree: 
plot(customer_behavior_model_decisiontree,type = "simple")

###Model Evaluation: 
customer_behavior_prediction_decisiontree <- predict(customer_behavior_model_decisiontree,
                                                     newdata = customer_behviour_test,type= "response")
###Evaluation of model using confusion matrix : 
confusionMatrix(data = customer_behavior_prediction_decisiontree,reference = customer_behviour_test$Purchased,
                positive = '1')
###Random Forest 
###Model fitting using random forest : 
#Creation of RDS file : 
set.seed(1234)
ctrl <- trainControl(method = "repeatedcv",
                    number = 3,
                    repeats = 3)

customer_behavior_model_randomforest <- train(Purchased ~.,
data = customer_behavior_train,
method = "rf",
trControl = ctrl)
saveRDS(customer_behavior_model_randomforest,"model_rf.RDS")
customer_behavior_model_randomforest <- read_rds("model_rf.RDS")

###Inspecting the model: 
customer_behavior_model_randomforest

###Predicting the model to the dataset
customer_behavior_prediction_randomforest <- predict(customer_behavior_model_randomforest,
newdata = customer_behviour_test, type = "raw")

###Model Evaluation: 
confusionMatrix(data= customer_behavior_model_randomforest, reference = customer_behviour_test$Purchased,
positive = "1")
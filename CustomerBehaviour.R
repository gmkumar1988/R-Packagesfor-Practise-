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

###Checking Missing Values 
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
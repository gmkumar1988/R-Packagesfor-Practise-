# install.packages("dplyr")
# install.packages("tidyverse")
# install.packages("e1071")
# install.packages("rsample")
# install.packages("caret")
# install.packages("ROCR")
# install.packages("partykit")
# install.packages("randomForecast")
library(dplyr)
library(tidyverse)
library(e1071)
library(ROCR)
library(rsample)
library(randomForest)
library(caret)
library(partykit)
customer_personality <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/customerpersonality.csv", header = TRUE, 
                                 sep = "\t")
head(customer_personality)
View(customer_personality)
arrange(customer_personality,customer_personality$Income)
is.na(customer_personality$Income)
customer_personality |>
  dplyr::mutate(customer_personality = replace_na(customer_personality$Income, 0000))

customer_personality[is.na(customer_personality$Income), ]<- 0000
is.na(customer_personality$Income)

# ?mutate
str(customer_personality)
glimpse(customer_personality)
class(customer_personality)


customer_personality[customer_personality$Income <= 20000] <- "Simple Income"
customer_personality[customer_personality$Income > 2100 & customer_personality$Income <= 5000] <- "Medium Income"
customer_personality[customer_personality$Income > 5000] <- "High Income"

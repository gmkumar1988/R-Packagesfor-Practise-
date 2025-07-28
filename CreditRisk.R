library(dplyr)
library(tidyverse)
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
loan <- read.csv('/Users/maheshg/Dropbox/Sample Datasets Kaggle/dataset.csv', header =  TRUE)

View(loan)
str(loan)
install.packages("gtools")
library(gtools)
install.packages("gmodels")
library(gmodels)
head(loan)
CrossTable(loan$Status.of.existing.checking.account)
CrossTable(loan$Credit.history)
CrossTable(loan$Credit.history, loan$Status.of.existing.checking.account,
           prop.r = FALSE,prop.c = FALSE, prop.chisq = FALSE)

### Loan status in months : 
hist_loan_status <- hist(loan$Duration.in.months, 
                        main = "Histogram of Status of Existing Checking Account",
                        xlab = "Status of Existing Checking Account",
                        ylab = "Frequency",
                        col = "lightblue",
                        border = "black")
hist_loan_status$breaks

hist_loan_2 <- hist(loan$Credit.amount, 
                        main = "Histogram of Credit Amount",
                        xlab = "Credit Amount",
                        ylab = "Frequency",
                        col = "lightgreen",
                        border = "black")

hist(loan$Age.in.years)

plot(loan$Age.in.years, loan$Credit.amount,
     main = "Scatter Plot of Age vs Credit Amount",
     xlab = "Age in Years",
     ylab = "Credit Amount",
     col = "blue",
     pch = 19)
# Identify the index of rows where Age is greater than 60
index_high_age <- which(loan$Age.in.years > 60)
# Print the rows with Age greater than 60
index_high_age

newdata <- loan[-index_high_age, ]
print(newdata)

plot(loan$Age.in.years, loan$Credit.amount,
     main = "Scatter Plot of Age vs Credit Amount (Filtered)",
     xlab = "Age in Years",
     ylab = "Credit Amount",
     col = "blue",
     pch = 19)

### Replace and identify the missing data 
str(loan$Credit.amount)
summary(loan$Credit.amount)

### Getting index of missing values from the credit amount 
index_missing <- which(is.na(loan$Credit.amount))
print(index_missing)

### Remove the observations with missing values from the credit amount attribute : 
loan_data_index <- loan[-index_missing, ]
print(loan_data_index)

is.na(loan_data_index$Credit.amount)

# Check if the 'Credit.amount' column has any missing values
if (length(loan$Credit.amount) > 0 && any(!is.na(loan$Credit.amount))) {
  min_val <- min(loan$Credit.amount, na.rm = TRUE)
  max_val <- max(loan$Credit.amount, na.rm = TRUE)
} else {
  min_val <- NA
  max_val <- NA
}

#Suppress the warnings 
suppressWarnings({
  loan_data_index$Credit.amount <- ifelse(is.na(loan_data_index$Credit.amount), 
                                          min_val, 
                                          loan_data_index$Credit.amount)
})

safe_min <- function(loan_creditamount) {
  if (length(loan$Credit.amount) > 0 && any(!is.na(loan$Credit.amount))) {
    return(min(loan$Credit.amount, na.rm = TRUE))
  } else {
    return(NA)
  }
}

safe_max <- function(loan_creditamount) {
  if (length(loan$Credit.amount) > 0 && any(!is.na(loan$Credit.amount))) {
    return(max(loan$Credit.amount, na.rm = TRUE))
  } else {
    return(NA)
  }
}

plot(loan$Credit.amount, 
     main = "Credit Amount Distribution",
     xlab = "Credit Amount",
     ylab = "Frequency",
     col = "lightblue",
     border = "black")

# Plot the scatter plot of Age vs Credit Amount after removing missing values
plot(loan_data_index$Age.in.years, loan_data_index$Credit.amount,
     main = "Scatter Plot of Age vs Credit Amount (Filtered)",
     xlab = "Age in Years",
     ylab = "Credit Amount",
     col = "blue",
     pch = 19)


plot(loan_data_index$Age.in.years, loan_data_index$Credit.amount,
     main = "Scatter Plot of Age vs Credit Amount (No Missing Values)",
     xlab = "Age in Years",
     ylab = "Credit Amount",
     col = "blue",
     pch = 19)


### Splitting the training and testing data from the loan 
set.seed(567)
library(caret)
###Storing row numbers for the training dataset
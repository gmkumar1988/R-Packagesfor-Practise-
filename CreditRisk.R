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
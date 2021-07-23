install.packages("Metrics")
library(Metrics)


actual = c(1.5, 1.0, 2.0, 7.4, 5.8, 6.6)         
predicted = c(1.0, 1.1, 2.5, 7.3, 6.0, 6.2)  


result <- rmse(actual,predicted)

result


#In this example let's take the trees data in the datasets library which represents the data from a study conducted on black cherry trees.

library(datasets)
library(tidyr)
library(dplyr)

data("trees")

str(trees)

# Building a linear model 
# Relating tree volume to girth
fit1 <- lm(Volume ~ Girth, data = trees)

trees.Girth = trees %>% select(Girth)

data.predicted = c(predict(fit1, data.frame(trees.Girth)))

print(data.predicted)

rmse(trees$Volume, predict(fit1, data.frame(Girth = trees.Girth)))


a <- c(2,"NA",3)
sum(is.na(a))
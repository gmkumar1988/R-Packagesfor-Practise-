library(caret)
library(dplyr)
n = 100; 
x = rnorm(n)
x2 = rnorm(n)
x3 = rnorm(n)
y = 1 + x + x2 + x3 + rnorm(n, sd = 0.1)
ey = resid(lm(y ~ x2 + x3))
ex = resid(lm(x ~ x2 + x3))
coef(lm(ey ~ ex -1 ))
sum(ey * ex) / sum(ex ^2)
coef(lm(y ~ x + x2 + x3))


###Multivariable regression 
require(datasets)
data("swiss")
?swiss
require(GGally)
require(ggplot2)
install.packages("GGally")
library(GGally)
# g = ggpairs(swiss, lower = list(continous = "smooth"),
#             params = c(method = "loess"))

summary(lm(Fertility ~ Agriculture, data = swiss))$coefficients

help("wrap", package = "GGally")

###Petrol Dataset: 
petrol <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/petrol_consumption.csv")
head(petrol)
cor(petrol)
summary(petrol)

###Model Selection : 
#Variance Inflaction : 
n <- 100
nosim <- 1000
x1 <- rnorm(n)
x2 <- rnorm(n)
x3 <- rnorm(n)

betas <- sapply(1 : nosim, function(i){
  y <- x1 + rnorm(n, sd = 0.3)
  c(coef(lm (y ~ x1))[2],
    coef(lm (y ~ x1 + x2))[2],
    coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd),5)
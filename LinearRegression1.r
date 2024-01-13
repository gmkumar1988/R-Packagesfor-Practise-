install.packages("dplyr")
install.packages("tidyverse")
library(dplyr)
library(tidyverse)
install.packages("ggplot2")
library(ggplot2, help, pos = 2, lib.loc = NULL)
x <- runif(10, 10, 20)
# print(x)
b0 <- 0
b1 <- 1
y <- b0 + b1 * x
print(y)
y <- 2 * x + 3 + rnorm(100, 0, 1)
df <- data.frame(x, y)
print(df)

ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE)

model <- lm(y ~ x, data = df)
print(model)
model <- lm(y ~ x, data = df)
print(model)


x = c(seq(1:10))
x
error_comp = rnorm(10,0,1)
error_comp
y=3+2*x+error_comp
y
qplot(x,y, main = "3 + 2*x + random error with SD = 1", ylim=c(-1, 30))
x = c(seq(1:10))
x
error_comp = rnorm(10,0,2)
error_comp
y=3+2*x+error_comp
y
qplot(x,y, main = "3 + 2*x + random error with SD = 2", ylim=c(-1, 30))
x = c(seq(1:10))
x
error_comp = rnorm(10,0,5)
error_comp
y=3+2*x+error_comp
y
qplot(x,y, main = "3 + 2*x + random error with SD = 5", ylim=c(-1, 30))


x = c(seq(1:10))
y = 3 + 2*x
error_comp = rnorm(10,0,1)
error_comp
y1=3+2*x+error_comp 
error_comp = rnorm(10,0,2)
error_comp
y2=3+2*x+error_comp
error_comp = rnorm(10,0,5)
error_comp
y5=3+2*x+error_comp
DATAFRAME <- data.frame(
x = x,
y0= y,
y1 = y1,
y2 = y2,
y3 = y5
)
#transpose to long format except year variable
df2 <- pivot_longer(DATAFRAME, cols = paste0("y",0:3))
df2
ggplot(
data = df2,
mapping = aes(x = x, y = value, color = name)
) +
geom_point(aes(size = name)) +
geom_smooth(method = lm) +
labs(
title = "Abline & Dot Plot with biggest for sd of 5 thru smallest sd = 0",
y = "y values",
x= "x values",
lintype = "Legend"
) +
theme_bw()
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

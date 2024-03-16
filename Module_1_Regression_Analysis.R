install.packages("tidyverse")
library(tidyverse)
turtle_data = read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/turtle.csv")
head(turtle_data)
par(mfrow = c(1,2))
hist(turtle_data$age,col = "#CFB87C")
hist(turtle_data$income, col="#CFB87C")
install.packages("ggplot2")
library(ggplot2)
g = ggplot(turtle_data, aes(x = turtle_data$age, y = turtle_data$income)) +
  geom_point() +
  labs(title = "Scattter Plot of Turtle Data = Income Vs Age")
plot(g)

summary(turtle_data)
turtle_data_age_centered <- 43.00
turtle_data_income_centered <- 60750
df_turtle_data_centered = data.frame(age = turtle_data_age_centered,
                                        income = turtle_data_income_centered)
head(df_turtle_data_centered)
g1 = ggplot(df_turtle_data_centered, aes(x = df_turtle_data_centered$age,
                                         y = df_turtle_data_centered$income)) +
  geom_point() +
  labs(title = "Latest Scatter Plot of Turtle Data with Income and Age ")
g1

class(df_turtle_data_centered)
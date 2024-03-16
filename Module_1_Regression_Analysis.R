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
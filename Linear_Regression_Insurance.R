# ###Load the required packages: 
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("broom")
# install.packages("ggpubr")

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)


insurance_data <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/insurance.csv")
head(insurance_data)
summary(insurance_data)
library(gapminder)
head(gapminder)
library(dplyr)

insurance <- insurance_data %>%
  ggplot() +
  geom_point(aes(x = bmi, y = charges, col = sex,size = charges), alpha = 0.8) + 
  theme_minimal() +
  theme(legend.position = "bottom") + guides(size = "none") + 
  labs(x = "BMI", y = "charges", col = "")


hist(insurance_data$bmi)
plot(bmi ~ age, data = insurance_data)
cor(insurance_data$bmi, insurance_data$age)

insurance_age_bmi <- lm(bmi ~ age, data = insurance_data)
summary(insurance_age_bmi)

par(mfrow = c(2,2))
plot(insurance_age_bmi)

insurance_graph <- ggplot(insurance_data, aes (x = bmi, y = age)) + 
  geom_point()
print(insurance_graph)
# 
# install.packages("rgl")
# library(rgl)
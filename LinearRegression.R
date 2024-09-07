install.packages("ggplot2")
install.packages("dplyr")
install.packages("broom")
install.packages("ggpubr")

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)

carprice_data = read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/car_price_prediction.csv")

summary(carprice_data)
hist(carprice_data$Price)

carprice_data$Price <- format(carprice_data$Price, scientific = FALSE)
print(carprice_data$Price)

 
# carprice_data$Price<- as.numeric(carprice_data$)

View(carprice_data)
summary(carprice_data)
str(carprice_data)

plot(carprice_data$Price ~ carprice_data$Prod..year, data = carprice_data)
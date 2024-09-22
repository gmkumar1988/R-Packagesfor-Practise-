# ###Load the required packages: 
install.packages("ggplot2")
install.packages("dplyr")
install.packages("broom")
install.packages("ggpubr")

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)

petrol <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/petrol_consumption.csv")
head(petrol)
cor(petrol)
summary(petrol)

hist(petrol$Petrol_Consumption)
hist(petrol$Paved_Highways)

plot(Petrol_Consumption ~ Paved_Highways, data = petrol)
cor(petrol$Petrol_Consumption, petrol$Paved_Highways)

###Perform linear regression line 
petrol_consumption_highway <- lm(Petrol_Consumption ~ Paved_Highways, data = petrol)
summary(petrol_consumption_highway)

par(mfrow = c(2,4))

plot(petrol_consumption_highway)

petrol_highway_final <- ggplot(petrol_consumption_highway, aes(x = Petrol_Consumption,
                                                               y = Paved_Highways )) + 
  geom_point()
print(petrol_highway_final)
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

?sapply

petrol_highway_final <- ggplot(petrol_consumption_highway, aes(x = Petrol_Consumption,
                                                               y = Paved_Highways )) + 
  geom_point()
print(petrol_highway_final)


###gganimate package preview
library(gganimate)
library(ggplot2)
theme_set(theme_bw())
petrol <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/petrol_consumption.csv")
head(petrol)
View(petrol)

#static plot 

###reference:

# insurance <- insurance_data %>%
#   ggplot() +
#   geom_point(aes(x = bmi, y = charges, col = sex,size = charges), alpha = 0.8) + 
#   theme_minimal() +
#   theme(legend.position = "bottom") + guides(size = "none") + 
#   labs(x = "BMI", y = "charges", col = "")

petrol_static <- petrol %>%
  ggplot() + 
  geom_point(aes(x = Paved_Highways, y = Petrol_Consumption, col = Average_income, size = Average_income ), alpha = 0.8) +
  theme_minimal() +
  theme(legend.position = "bottom") + guides(size = "none") +
  labs(x = "Paved_Highways", y = "Petrol_Consumption", col = "" )

petrol_consumption <- petrol_static + 
  transition_layers()

animate(petrol_consumption, renderer = gifski_renderer(),
        width = 800, height = 600, res = 100)

anim_save("/Users/maheshg/Dropbox/git repos/R-Packagesfor-Practise-",animate(petrol_consumption, renderer = gifski_renderer(),
                                                                             width = 800, height = 600, res = 100))

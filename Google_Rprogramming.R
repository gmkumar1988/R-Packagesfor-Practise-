# install.packages("palmerpenguins")
library(palmerpenguins)
library(ggplot2)
ggplot(data=penguins,
       aes(x = penguins$flipper_length_mm, y = penguins$body_mass_g)) + 
  geom_point(aes(color = species)) + facet_wrap(~species) + labs(title = "Palmer Penguines: Body Mass Index vs Flipper Lenght")

summary(penguins)

### 
x <- -0.8 
if (x > 0 ) {
  
  print("x is the positive number")
  
} else {
  print("x is either positive or negative number")
}
# install.packages("tidyverse")
library(tidyverse)
#####tooth growth analysis: 
data("ToothGrowth")
View(ToothGrowth)
library(dplyr)
filtered_tg <- filter(ToothGrowth,dose == 0.5)
View(filtered_tg)
arrange(filtered_tg,len)
arrange(filter(ToothGrowth,dose == 0.5),len)
filtered_toothgrowth <- ToothGrowth %>%
  filter(dose == 0.5) %>%
  group_by(supp) %>%
  arrange(len) %>%
  summarise(mean_length = mean(len, na.rm = T),.groups = "drop" )


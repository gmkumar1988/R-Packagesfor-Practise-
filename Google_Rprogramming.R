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


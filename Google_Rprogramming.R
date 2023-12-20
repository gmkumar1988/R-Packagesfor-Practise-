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
#### tidyverse

install.packages("tidyverse")
library(tidyverse)
data("diamonds")
View(diamonds)
head(diamonds)

str(diamonds)
mutate(diamonds, carot_2 = diamonds$carat * 100)

###cleaning
install.packages("here")
library(here)
install.packages("skimr")
library(skimr)
install.packages("janitor")
library(janitor)
library(dplyr)
library(palmerpenguins)
skim_without_charts(penguins)
glimpse(penguins)
head(penguins)

library(dplyr)

penguins |> select(-species)
penguins |> select(-species) |> 
  rename(island_new = island)
rename_with(penguins,toupper)
clean_names(penguins)
penguins |> arrange(-bill_length_mm)
penguins2 <- penguins |> arrange(-bill_length_mm)
view(penguins2)
penguins |> group_by(island) |> drop_na() |> 
  summarise(mean_bill_length_mm = mean(bill_length_mm))
penguins |> group_by(island) |> drop_na() |> 
  summarise(max_bill_length = max(bill_length_mm))
penguins |> group_by(species,island) |> drop_na() |> 
  summarise(max_bl = max(bill_length_mm), mean_bl = mean(bill_depth_mm)) |> 
  arrange(-mean_bl)

penguins |> 
  arrange(bill_length_mm)


penguins |> 
  filter(island != "Torgersen")

ggplot(penguins) +
  geom_point(mapping = aes(x = flipper_length_mm,
                           y = body_mass_g))

library(palmerpenguins)
library(ggplot2)
ggplot(data = penguins) +
  geom_point(mapping = aes(x = penguins$flipper_length_mm,
                           y= penguins$body_mass_g,
                           shape= species,
                           color=species,
                           size = species),
             color = "purple") 
  
ggplot(data = penguins) +
  geom_point(mapping = aes(x = penguins$flipper_length_mm,
                           y = penguins$body_mass_g)) +
  geom_smooth(mapping = aes(x = penguins$flipper_length_mm,
                            y = penguins$body_mass_g))
ggplot(data= penguins) +
  geom_point(mapping = aes(x = penguins$flipper_length_mm,
                            y = penguins$body_mass_g,
                           color = species)) +
  facet_grid(sex~species)



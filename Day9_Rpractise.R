file.choose()
bs <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/bestsellers_with_categories_2022_03_27.csv", sep = ",",
               header = TRUE)
summary(bs)
head(bs)
View(bs)
library(tidyverse)
library(dplyr)

install.packages("ggblanket")
library(ggblanket)


bs_new = bs %>%
  distinct(bs$Author, .keep_all = TRUE) %>%
  tidyr::drop_na()
  ##group_by(bs$User.Rating)

bs_new %>%
  ggplot() +
  geom_histogram(aes(x= bs$Genre))
  
length(bs_new)
summary(bs_new)
View(bs_new)


penguins2 <- palmerpenguins::penguins %>% 
  tidyr::drop_na() %>% 
  mutate(body_mass_kg = body_mass_g / 1000)

?palmerpenguins

View(penguins)

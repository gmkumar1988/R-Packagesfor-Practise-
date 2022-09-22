install.packages("ggplot2")
library(ggplot2)
install.packages("palmerpenguins")
library(palmerpenguins)

penguins |>
  ggplot( aes(x = bill_length_mm,
              y = bill_depth_mm,
              color = species)) +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE) +
  scale_color_brewer(palette =  "Dark2") +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       color = "Species") +
  theme_minimal()


install.packages("tidyverse")
library(tidyverse)

View(starwars)

starwars |>
  select (mass) |>
  na.omit() |>
  mutate(size = cut(mass, breaks = c(0,50,100, Inf))) |>
                ##  labels = c("Small", "Large","Medium"))) |>
  count(size)

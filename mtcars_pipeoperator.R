
library(dplyr)
mtcars %>%
  filter(carb > 1 ) %>%
  group_by(cyl) %>%
  summarize(Avg_mpg = mean(mpg))

dframe <- mtcars
dframe <- dframe %>% select(1:5) %>% filter(disp > 100, cyl == 6)
View(dframe)

install.packages("TidyDensity")
library(TidyDensity)

x <- mtcars$mpg
output <- tidy_distribution_comparison(x)

output


install.packages("janitor")
library(janitor)

mtcars %>%
  tabyl(am,cyl) %>%
  adorn_percentages("col") %>%
  adorn_pct_formatting() %>%
  adorn_ns(position = "front")

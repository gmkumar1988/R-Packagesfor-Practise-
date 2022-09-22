library(tidyverse)
install.packages("ISLR2")
library(ISLR2)

?College
glimpse(College)

ggplot(College, aes (x = Grad.Rate)) +
  geom_histogram() # weird outlier 

suspicious <- filter (College, Grad.Rate >= 100 )
View(suspicious)

ggplot (College, aes(x = log10 (F.Undergrad),
                     y = Grad.Rate)) + 
  geom_point()

college_sm <- College |>
  mutate (log_full = log10(F.Undergrad)) |>
  select (Grad.Rate, 
          log_full,
          Private,
          Top25perc)


View(college_sm)


#Modelling 


ggplot (College, aes(x = log10 (F.Undergrad),
                     y = Grad.Rate)) + 
  geom_point() +
  geom_smooth(method = "lm")


model_undergrad <- lm(Grad.Rate ~ log_full,
                      data = college_sm)

summary(model_undergrad)
plot(model_undergrad)


# Private colleges 


ggplot (College, aes(x = log10 (F.Undergrad),
                     y = Grad.Rate,
                     color = Private,
                     )) +
  ggtitle("Graduation Rate - Undergraduate vs Graduate colleges in US") +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE) + 
  scale_color_brewer( palette =  "Dark2")

model_private <- lm (Grad.Rate ~ Private + log_full,
                     data = college_sm)

summary(model_private)


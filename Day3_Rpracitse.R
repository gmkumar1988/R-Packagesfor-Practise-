install.packages("gapminder")
library(gapminder)

data("gapminder")

summary(gapminder)

x <- mean (gapminder$gdpPercap)
attach(gapminder)

median(pop)

hist(lifeExp)
hist(log(pop))

boxplot(lifeExp ~ continent)
plot( log(lifeExp) ~ gdpPercap)

library(dplyr)

df1 <- gapminder %>%
  select (country, lifeExp) %>%
  filter (country == "South Africa" |
            country == "Ireland") 

t.test(data = df1, lifeExp ~ country )



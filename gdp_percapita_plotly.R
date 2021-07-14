
install.packages("gapminder")

library(plotly)
library(gapminder)

p <- gapminder %>%
  plot_ly(
    x = ~gdpPercap, 
    y = ~lifeExp, 
    size = ~pop, 
    color = ~continent, 
    frame = ~year, 
    text = ~country, 
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
  ) %>%
  layout(
    xaxis = list(
      type = "log"
    )
  )

###GDP Data FY2020 using Plotly:

t <- gdp %>%
  plot_ly(
    x = ~GDP,
    y = ~Country.Name,
    color = ~Country.Name,
    frame = ~Year,
    text = ~Country.Name,
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
      ) %>%
  layout(title = "World Wide GDP FY 2019 till 2020 (Before Covid)",
    xaxis = list(type = "log")
  )
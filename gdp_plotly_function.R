library(plotly)

m <- mtcars[which.max(mtcars$mpg), ]

g <- gdp_latest[which.max(gdp_latest$`2020`),]

a <- list(
  x = gdp_latest$Country.Code,
  y = gdp_latest$`2020`,
  text = rownames(g),
  xref = "x",
  yref = "y",
  showarrow = TRUE,
  arrowhead = 7,
  ax = 20,
  ay = -40
  )

fig <- plot_ly(gdp_latest, x = ~gdp_latest$`2020`, y = ~gdp_latest$Country.Code)
fig <- fig %>% add_markers()
fig <- fig %>% layout(annotations = a)

fig
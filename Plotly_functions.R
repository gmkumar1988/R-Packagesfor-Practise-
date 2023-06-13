date()
library(plotly)
data("volcano")
fig <- plot_ly(z = ~volcano,colorscale = 'hot')
fig <- fig %>%
  add_surface()
fig
install.packages("plotly")
library(plotly, help, pos = 2, lib.loc = NULL)
fig = list(
  data = list(
    list(
      x = c(1, 2, 3),
      y = c(1, 3, 2),
      type = 'bar'
    )
  ),
  layout = list(
    title = 'A Figure Specified By R List',
    plot_bgcolor='#e5ecf6', 
         xaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'), 
         yaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff')
  )
)
plotly_build(fig)

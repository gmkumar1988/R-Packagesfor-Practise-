install.packages("plotly")
library(plotly, help, pos = 2, lib.loc = NULL)
fig = list(
    x = c(1,2,3,4,5),
    y = c(1,2,3,4,5),
    type = 'bar'
)
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
plotly_build(fig)

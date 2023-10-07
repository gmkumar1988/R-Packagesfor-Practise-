#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$ideo5_barplot <- renderPlot({
    
    ggplot(
      filter(data,ideo5==input$my_ideo5),
      aes(x=pid7))+ geom_bar() + xlab("7 Point Party ID (1 = Strong Democrat, 7 = Strong Republican)") +
      ylab("count") + scale_x_continuous(breaks = seq(1,7,1))
    
    
    # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2]
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white',
    #      main = 'Histogram of waiting times')
    
  })
  
}

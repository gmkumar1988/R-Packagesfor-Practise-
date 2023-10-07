#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(shiny)
library(tidyverse)
library(dplyr)

###Importing Data 
data <- read.csv("/Users/maheshg/Dropbox/RShiny/CourseraShiny_Application/conservatives.csv")

head(data)
data <- data %>% select(c("pid7","ideo5"))
# data <- drop_na(data)
# 
# is.na(data)
# 
# # print("Position of missing values - ")
# which(is.na(data))
# 
# sum(is.na(data))


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Plot of Political Party ID by Ideology"),
  
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("my_ideo5",
                  "Ideology(1= very liberal, 5 = very conservative):",
                  min = 1,
                  max = 5,
                  value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("ideo5_barplot")
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
    
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
      #      xlab = 'Waiting time to next eruption (in mins)',
      #      main = 'Histogram of waiting times')
      
    })
    
  }
# Run the application 
shinyApp(ui = ui, server = server)

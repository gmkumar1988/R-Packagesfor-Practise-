library(shiny)
library(tidyverse)
library(dplyr)

###Importing Data 
data <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/3nwNdQZyT-S8DXUGcp_ktQ_f03ef50b3f2b4f30a44215b5acd7d4f8_cces_sample_coursera.csv",
                 header = TRUE)

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
# View(data)
# 
# 
# 
# colnames(data)



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
    #      xlab = 'Waiting time to next eruption (in mins)',
    #      main = 'Histogram of waiting times')
    
  })
  
}

getwd()


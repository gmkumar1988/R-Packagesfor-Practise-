#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(dplyr)
library(ggplot2)

###Importing Data 
data <- read.csv("conservatives.csv")

# head(data)
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


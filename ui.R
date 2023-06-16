library(shiny)
shinyUI(fluidPage(
  titlePanel("Predicting the price of a diamond"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarat", "What is price of a diamond?", 0, 6, value = 0.1),
      checkboxInput("showModel", "Show/Hide regression line", value = TRUE),
      submitButton("Submit") 
    ),
    mainPanel(
      plotOutput("plot"),
      h3("Predicted price of a diamond:"),
      textOutput("pred"),
      
    )
  )
))
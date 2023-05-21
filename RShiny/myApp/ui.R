#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(shiny)

# # Define UI - Sample 1 : 
# shinyUI(fluidPage(
#   titlePanel("Data Science FTW"),
#   sidebarLayout(
#     sidebarPanel(
#       h3("Sidebar Text")
#     ),
#     mainPanel(
#       h3("Main Panel Text")
#     )
#   )
# ))



# # Define UI - Sample 2 : 
# shinyUI(fluidPage(
#   titlePanel("HTML Tags"),
#   sidebarLayout(
#     sidebarPanel(
#       h1("H1 Text"),
#       h2("H2 Text"),
#       h3("H3 Text"),
#       em("Emphasized Text")
#     ),
#     mainPanel(
#       h3("Main Panel Text"),
#       code("Some Code")
#     )
#   )
# ))


# Define UI - Sample 3 : 
shinyUI(fluidPage(
  titlePanel("Slider App"),
  sidebarLayout(
    sidebarPanel(
      h1("Move the Slider!"),
      sliderInput("slider2","SlideMe",0,100,0),
          ),
    mainPanel(
      h3("Slider Value:"),
      textOutput("text1")
    )
  )
))



library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Horsepower from MPG"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
      mainPanel(
      plotOutput("plot1"),
      h3("Predicted Horsepower from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Horsepower from Model 2:"),
      textOutput("pred2")
    )
  )
))

# Define UI for application that draws a histogram
# fluidPage(
#   
#   
# )

# 
#     # Application title
#     titlePanel("Old Faithful Geyser Data"),
# 
#     # Sidebar with a slider input for number of bins
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#             plotOutput("distPlot")
#         )
#     )
# )

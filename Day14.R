library(shiny)

#Define user interface 

ui <- fluidPage(
  titlePanel("My Simple App"),
  textInput(inputId = "my_text", label = "Enter some text"),
  textOutput(outputId = "print_text")
)

server <- function(input,output){
  output$print_text <- renderText(input$my_text)
}

shinyApp(ui = ui, server = server)
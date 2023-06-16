library(shiny)
library(UsingR)
data(diamond)

shinyServer(function(input, output) {
  
  model <- lm(price ~ carat, data = diamond)
  
  
  modelpred <- reactive({
    CaratInput <- input$sliderCarat
    predict(model, newdata = data.frame(carat = CaratInput))
  })
  
  
  output$plot <- renderPlot({
    CaratInput <- input$sliderCarat
    
    plot(diamond$carat, diamond$price, xlab = "Mass (carats)", 
         ylab = "Price (SIN $)", bty = "n", pch = 16,
         xlim = c(0, 6), ylim = c(0, 20000))
    if(input$showModel){
      abline(model, col = "red", lwd = 2)
    }
    points(CaratInput, modelpred(), col = "red", pch = 16, cex = 2)
    
    
  })
  
  output$pred <- renderText({
    modelpred()
  })
  
  
})

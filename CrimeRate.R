install.packages("leaflet")
install.packages("ukpolice")
install.packages("opencage")
install.packages("highcharter")
install.packages("dplyr")
install.packages("forcats")
install.packages("shiny")


library(shiny)
library(dplyr)
library(forcats)
library(leaflet)
library(ukpolice)
library(opencage)
library(highcharter)

Sys.setenv(OPENCAGE_KEY = readRDS("opencage_api.rds"))

ui <- bootstrapPage(
  
  tags$head(
    tags$link(href = "https://fonts.googleapis.com/css?family=Oswald", rel = "stylesheet"),
    tags$style(type = "text/css", "html, body {width:100%;height:100%; font-family: Oswald, sans-serif;}"),
    includeHTML("meta.html"),
    tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.16/iframeResizer.contentWindow.min.js",
                type="text/javascript"),
    tags$script('
                $(document).ready(function () {
                  navigator.geolocation.getCurrentPosition(onSuccess, onError);
                
                  function onError (err) {
                    Shiny.onInputChange("geolocation", false);
                  }
                
                  function onSuccess (position) {
                    setTimeout(function () {
                      var coords = position.coords;
                      console.log(coords.latitude + ", " + coords.longitude);
                      Shiny.onInputChange("geolocation", true);
                      Shiny.onInputChange("lat", coords.latitude);
                      Shiny.onInputChange("long", coords.longitude);
                    }, 1100)
                  }
                });
                ')
  ),
  
  leafletOutput("map", width = "100%", height = "100%"),
  
  absolutePanel(
    top = 10, right = 10, style = "z-index:500; text-align: right;",
    tags$h2("Culture of Insight's Crime Watch"),
    tags$a("About this tool", href="https://cultureofinsight.com/portfolio/crimewatch/")
  ),
  
  absolutePanel(
    top = 100, left = 10, draggable = TRUE, width = "20%", style = "z-index:500; min-width: 300px;",
    textInput("geocode", "Type an address or location", placeholder = "in England, Wales or NI"),
    checkboxInput("use_location", "Or use your current location?"),
    actionButton("go", "Find Crime!", class = "btn-primary"),
    highchartOutput("selectstat")
  )
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(-3, 54.3, zoom = 6)
  })
  
  observeEvent(input$go, {
    
    withProgress(
      message = 'Fetching data from data.police.uk...',
      value = 1/5, {
        
        if (input$use_location) {
          
          validate(
            need(input$geolocation, message = FALSE)
          )
          
          lat <- input$lat
          long <- input$long
          
          place <- opencage_reverse(lat, long, countrycode = "GB")
          place <- as.character(place$results$components.postcode[1])
          
        } else {
          
          validate(
            need(nchar(input$geocode > 2), message = FALSE)
          )
          
          geoc <- opencage_forward(placename = input$geocode, countrycode = "GB")
          
          lat <- geoc$results$geometry.lat[1]
          long <- geoc$results$geometry.lng[1]
          
          place = input$geocode
          
        }
        
        incProgress(1/5)
        
        tryCatch({
          crime <- ukp_crime(lat, long) %>% 
            mutate(date = as.Date(paste0(date, "-01"))) %>% 
            mutate(date = format(date, format = "%B %Y")) %>% 
            mutate(top5 = fct_lump(factor(category), n = 5, other_level = "hover-for-detail"))
          
          crime_rank <- crime %>%
            count(category) %>%
            arrange(desc(n))
          
        },
        error = function(e) {
          crime <- NULL
        }
        )
        
        incProgress(1/5)
        
        tryCatch({
          pal <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02")
          leafPal <- colorFactor(pal, crime$top5)
          
          leafletProxy("map", data = crime) %>%
            setView(long, lat, zoom = 14) %>% 
            clearShapes() %>% 
            clearControls() %>% 
            addCircles(~long, ~lat, stroke = FALSE, fill = TRUE, fillOpacity = .7, 
                       color = ~leafPal(top5), label = ~category, radius = 30) %>% 
            addLegend("bottomright", pal = leafPal, values = ~top5, title = "Category")
          
          incProgress(1/5)
          
          output$selectstat <- renderHighchart({
            
            hchart(crime_rank, "bar", hcaes(category, n)) %>% 
              hc_colors("SteelBlue") %>% 
              hc_title(text = paste("Crimes within 1 mile of", isolate(place))) %>% 
              hc_subtitle(text = unique(crime$date)) %>% 
              hc_xAxis(title = list(text = ""), gridLineWidth = 0, minorGridLineWidth = 0) %>% 
              hc_yAxis(title = list(text = "Incidents"), gridLineWidth = 0, minorGridLineWidth = 0) %>%
              hc_legend(enabled = FALSE) %>% 
              hc_tooltip(pointFormat = "Incidents: <b>{point.y}</b>") %>% 
              hc_plotOptions(series = list(cursor = "default")) %>% 
              hc_add_theme(hc_theme_smpl()) %>% 
              hc_chart(backgroundColor = "transparent")
            
          })
          
        },
        error = function(e) {
          showModal(modalDialog(title = "Sorry!", 
                                tags$p("We couldn't find any data for that location."),
                                tags$p("Give another one a try!")))
        }
        )
        
        incProgress(1/5)
        
      })
  })
  
  
}
shinyApp(ui, server)
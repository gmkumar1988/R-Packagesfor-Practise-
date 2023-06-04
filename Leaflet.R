install.packages("leaflet")
library(leaflet)
mymap <- leaflet() %>%
  addTiles()

mymap = leaflet()
mymap = addTiles(mymap)

###
mymap <- mymap %>%
  addMarkers(lng = 76.5, lat=39.5,
             popup = "Jeff's Office")
mymap = addMarkers(mymap, lng = 76.5, lat=39.5,
                   popup = "Jeff's Office")

set.seed(2016-04-25)
df <- data.frame(lat = runif(20, min = 39.2, max = 39.3),
                 lng = runif(20, min = -76.6, max = -76.5))

df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers()

df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions())

df %>% leaflet() %>% addTiles()

df %>% leaflet() %>% addTiles()

leaflet(df) %>% addTiles()

df(leaflet(addTiles()))


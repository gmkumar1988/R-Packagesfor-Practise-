
date()
library(leaflet)

# devtools::install_version("MASS", "7.3-51.1")

install.packages("MASS")
update.packages("MASS")

upicon <- makeIcon(
  iconUrl =  "https://upload.wikimedia.org/wikipedia/en/thumb/3/3d/University_of_The_Philippines_seal.svg/640px-University_of_The_Philippines_seal.svg.png",
  iconWidth = 50, iconHeight = 50,
  iconAnchorX = 50*215/230/2, iconAnchorY = 25
)
ADMU_icon <- makeIcon(
  iconUrl = "https://upload.wikimedia.org/wikipedia/en/thumb/6/6c/Ateneo_de_Manila_University_seal.svg/1200px-Ateneo_de_Manila_University_seal.svg.png",
  iconWidth = 50, iconHeight = 50,
  iconAnchorX = 50*215/230/2, iconAnchorY = 25
)

DLSU_icon <- makeIcon(
  iconUrl = "https://upload.wikimedia.org/wikipedia/en/thumb/c/c2/De_La_Salle_University_Seal.svg/1200px-De_La_Salle_University_Seal.svg.png",
  iconWidth = 50, iconHeight = 50,
  iconAnchorX = 50*215/230/2, iconAnchorY = 25
)

UST_icon <- makeIcon(
  iconUrl = "https://preview.redd.it/ss0xjc3h60f41.png?auto=webp&s=8afbd67ecf61c818f4db572bb99a9ca48ec3f9d4",
  iconWidth = 50, iconHeight = 55,
  iconAnchorX = 50*215/230/2, iconAnchorY = 25
)


top_univ_ph <- leaflet() %>%
  addTiles() %>%
  addMarkers(lat=14.6539, lng=121.0685, popup="University of the Philippines", icon = upicon) %>%
  addMarkers(lat = 14.6395, lng = 121.0781, popup = "Ateneo de Manila University", icon = ADMU_icon) %>%
  addMarkers(lat = 14.5647, lng = 120.9932, popup = "De La Salle University", icon = DLSU_icon) %>% 
  addMarkers(lat = 14.6095, lng = 120.9898, popup = "University of Santo Tomas", icon = UST_icon)
top_univ_ph
install.packages("ggplot2")
install.packages("dplyr")
install.packages("broom")
install.packages("ggpubr")

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)
library(gganimate)

carprice_data = read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/car_price_prediction.csv")

# head(carprice_data, n= 10)
# ggplot(carprice_data, 
#        aes(Prod..year, Price, size = pop, colour = country)) + 
#   geom_point(alpha = 0.7, show.legend = FALSE) +
#   # scale_colour_manual(values = country_colors) +
#   scale_size(range = c(2, 12)) +
#   scale_x_log10() +
#   facet_wrap(~Manufacturer) +
#   labs(title = 'Year: {frame_time}', x = 'Production Year', y = 'Price') +
#   transition_time(year) +
#   ease_aes('linear')
# 


###Prediction CarPrice 
library(ggplot2)


###Example gganimate: 
library(gapminder)
head(gapminder)
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  # scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
summary(carprice_data)
hist(carprice_data$Price)

carprice_data$Price <- format(carprice_data$Price, scientific = FALSE)
print(carprice_data$Price)

 
# carprice_data$Price<- as.numeric(carprice_data$)

View(carprice_data)
summary(carprice_data)
str(carprice_data)


filtered_data <- carprice_data %>%
  filter(carprice_data$Prod..year > 2000) %>% 
  select(carprice_data$Price, carprice_data$Prod..year)

View (filtered_data)
head(filtered_data)

plot(filtered_data$Price ~ filtered_data$Prod..year, data = filtered_data)
options(scipen = 9999)
hist(filtered_data$Prod..year)

cor(filtered_data$Engine.volume, filtered_data$Mileage)
as.numeric(filtered_data$Engine.volume)
is.na(filtered_data$Engine.volume)
plot(filtered_data$Engine.volume ~ filtered_data$Mileage, data = filtered_data)

filtered_data$Engine.volume <- as.numeric(filtered_data$Engine.volume)
suppressWarnings(as.numeric(filtered_data$Engine.volume))
filtered_data$Engine.volume <- na.omit(filtered_data$Engine.volume)
print(filtered_data$Engine.volume)

###Replace NA with 0 in all columns: 
filtered_data$Engine.volume[is.na(filtered_data$Engine.volume)] <- 0
print(filtered_data$Engine.volume)
filtered_data$Mileage[is.na(filtered_data$Mileage)] <- 0
print(filtered_data$Mileage)

##Visualize the Engine Value and Mileage of cars: 
ggplot(data = filtered_data, mapping =aes(x = Mileage,
                                          y = Engine.volume)) + 
  geom_point() + 
  geom_point(
    mapping = aes(x =Price, y = Prod..year, data = filtered_data,
                  colour = 'red',size = 3)
  )

par(mfrow =c(2,2))

engine_mileage.lm <- lm(filtered_data$Engine.volume ~ filtered_data$Mileage,
                        data = filtered_data)
summary(engine_mileage.lm)
par(mfrow = c(2,2))
plot(engine_mileage.lm)
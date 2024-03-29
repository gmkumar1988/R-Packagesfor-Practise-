library(here)
library(skimr)
library(janitor)
library(tidyverse)
library(ggplot2)
bookings_df <- read_csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/GL0bk8O2Sja9G5PDtko2uQ_31e445d7ca64417eb45aeaa08ec90bf1_hotel_bookings.csv")
ggplot(data = bookings_df) +
  geom_point(mapping = aes(x = bookings_df$lead_time,
                           y = bookings_df$children))
ggplot(data = bookings_df) +
  geom_point(mapping = aes(x = bookings_df$hotel,y = bookings_df$children,
                           fill = bookings_df$market_segment))

library(tidyverse)
online_city_hotels <- filter(bookings_df,
                             (bookings_df$hotel == "City Hotel" &
                                bookings_df$market_segment == "Online TA"))

View(online_city_hotels)
online_city_hotels2 <- bookings_df |> 
  filter(bookings_df$hotel == "City Hotel" & 
           bookings_df$market_segment == "Online TA")
View(online_city_hotels2)

head(bookings_df)
str(bookings_df)
glimpse(bookings_df)
colnames(bookings_df)
trimmed_df <- bookings_df |> 
  select(hotel,is_canceled,lead_time)
hotel_type <- trimmed_df$hotel
View(trimmed_df)
rm(hotel_type)
trimmed_df |> 
  select(hotel,is_canceled,lead_time) |> 
  rename(hotel_type = hotel)

example_df <- bookings_df %>%
  mutate(guests = adults + children + babies)

example_df <- bookings_df %>%
  summarize(number_canceled = sum(is_canceled),
            average_lead_time = mean(lead_time))

install.packages("Tmisc")
library(Tmisc)
data("quartet")
quartet |> 
  group_by(set) |> 
  summarize(mean(x),sd(x),mean(y),sd(y),cor(x,y))

ggplot(quartet,aes(x,y)) +
  geom_point() +
  geom_smooth(method = lm,se=FALSE) +
  facet_wrap(~set)

install.packages("datasauRus")
library(datasauRus)
ggplot(datasaurus_dozen,
       aes(x=x,y=y,colour = dataset)) +
  geom_point() +
  theme_void() +
  theme(legend.position = "none") +
  facet_wrap(~dataset,ncol=3) 

install.packages("SimDesign")
library(SimDesign)
actual_temp <- c (68.3,70,72.4,71,67,70)
predicted_temp <- c(67.9,69,71.5,70,67,69)
bias(actual_temp,predicted_temp)

x <- data("diamonds")

diamonds$cut
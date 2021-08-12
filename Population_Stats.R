install.packages("wcde")
library(devtools)
install_github("guyabel/wcde", ref = "main")
library(wcde)

#To get the specific education details from the country:
get_wcde(indicator = "etfr", country_name = "India")

#To get education specific survivor rate in the country : 
get_wcde(indicator = "eassr", country_code = c(356))

find_indicator(x = "tfr")

library(tidyverse)

get_wcde(indicator = "e0", 
         country_name = c("China", "India")) %>%
  filter(period == "2015-2020")

get_wcde(indicator = "sexratio",
         country_name = c("China","India")) %>%
  filter(year == 2020)


wic_indicators %>%
  filter(past) %>%
  select(1:2)


get_wcde(indicator = "sexratio", 
         country_name = c("China", "India")) %>%
  filter(year == 2020, 
         age == "All")


#Country Code for India :
india_ccode <- get_wcde(indicator = "epop", country_code = 356)
india_ccode


india_ccode %>%
  edu_group_sum(n=4) %>%
  filter(year == 2020)

india_ccode %>%
  edu_group_sum(n=4) %>%
  filter(year == 2020,
         age == "30--34")


india_pyramid <- india_ccode %>% 
  edu_group_sum(n = 4) %>%
  mutate(pop = ifelse(test = sex == "Male", yes = -epop, no = epop),
         pop = pop/1e3) 


install.packages("lemon")
library(lemon)



india_pyramid %>%
  filter(year == 2020) %>%
  ggplot(mapping = aes(x = pop, y = age, fill = fct_rev(education))) +
  geom_col() +
  geom_vline(xintercept = 0, colour = "black") + 
  scale_x_symmetric(labels = abs) +
  scale_fill_manual(values = wic_col4, name = "Education") +
  labs(x = "Number of Population in Millions", y = "Age Details") +
  theme_bw() 


india_pyramid <- india_pyramid %>%
  mutate(pop_max = ifelse(sex == "Male", -max(pop), max(pop)))

india_pyramid %>%
  filter(year == 2020) %>%
  ggplot(mapping = aes(x = pop, y = age, fill = fct_rev(education))) +
  geom_col() +
  geom_vline(xintercept = 0, colour = "black") +
  scale_x_continuous(labels = abs, expand = c(0, 0)) +
  scale_fill_manual(values = wic_col4, name = "Education") +
  labs(x = "India Population in Millions", y = "Age Details") +
  facet_wrap(facets = "sex", scales = "free_x", strip.position = "bottom") +
  geom_blank(mapping = aes(x = pop_max * 1.1)) +
  theme(panel.spacing.x = unit(0, "pt"),
        strip.placement = "outside",
        strip.background = element_rect(fill = "transparent"),
        strip.text.x = element_text(margin = margin( b = 0, t = 0)))



###GGAnimate

install.packages("gganimate")
install.packages("gifski")
install.packages("png")

library(png)
library(gifski)
library(gganimate)

g <- ggplot(data = india_pyramid, 
       mapping = aes(x = pop, y = age, fill = fct_rev(education))) +
  geom_col() +
  geom_vline(xintercept = 0, colour = "black") +
  scale_x_continuous(labels = abs, expand = c(0, 0)) +
  scale_fill_manual(values = wic_col4, name = "Education") +
  facet_wrap(facets = "sex", scales = "free_x", strip.position = "bottom") +
  geom_blank(mapping = aes(x = pop_max * 1.1)) +
  theme(panel.spacing.x = unit(0, "pt"),
        strip.placement = "outside",
        strip.background = element_rect(fill = "transparent"),
        strip.text.x = element_text(margin = margin(b = 0, t = 0))) +
  transition_time(time = year) +
  labs(x = "Number of Population in Millions", y = "Age Details", 
       title = 'India Population {round(frame_time)}')
#Render gganimate using gifski:
animate(g, renderer = gifski_renderer())


  
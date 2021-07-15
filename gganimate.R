install.packages("datasauRus")
library(datasauRus)
library(ggplot2)
library(gganimate)

ggplot(datasaurus_dozen, aes(x=x, y=y))+
  geom_point()+
  theme_minimal() +
  transition_states(dataset, 3, 1) + 
  ease_aes('cubic-in-out')


###GDP Animation using gganimate()

file.choose()


gdp_latest <- read.csv("D://Mahesh Files//R Working Files//GDP_Latest.csv")

View(gdp_latest)


names(gdp_latest)<-sapply(str_remove_all(colnames(gdp_latest),"X"),"[")

str(gdp_latest)

g1 <- gdp_latest %>%
  group_by(Country.Code) %>%
  arrange(Country.Code, desc(2020)) %>%
  mutate(Rank = row_number()) %>%
  filter(Rank <=10)

View(g1)



animacion <- g1 %>%
  ggplot() +
  geom_col(aes(Rank, 2020, fill = Country.Code)) +
  geom_text(aes(Rank, 2020, label = 2020), hjust=-0.1) +
  geom_text(aes(Rank, y=0 , label = Country.Code), hjust=1.1) + 
  geom_text(aes(x=15, y=max(2020) , label = as.factor(year)), vjust = 0.2, alpha = 0.5,  col = "gray", size = 20) +
  coord_flip(clip = "off", expand = FALSE) + scale_x_reverse() +
  theme_minimal() + theme(
    panel.grid = element_blank(), 
    legend.position = "none",
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    plot.margin = margin(1, 4, 1, 3, "cm")
  ) +
  transition_states(year, state_length = 0, transition_length = 2) +
  enter_fade() +
  exit_fade() + 
  ease_aes('quadratic-in-out') 






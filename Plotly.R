install.packages("plotly")
library(plotly)
library(ggplot2)
install.packages("tidyverse")
install.packages("dplyr")

library(tidyverse)
library(dplyr)
data("EuStockMarkets")

# n<- data("EuStockMarkets")

# colnames(n)

stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets),4))

plot_ly(stocks, x = time, y = price, color = index)

plot_ly(stocks, x = time, y = price)

remove.packages("rlang")
install.packages("rlang")
update.packages("rlang")

### Sample2 : 
data("airmiles")
library(plotly)
plot_ly(x = time(airmiles), y = airmiles)


# plotly(stocks)
install.packages("plotly")
library(plotly)
library(ggplot2)
install.packages("tidyverse")
install.packages("dplyr")

install.packages("tidyr")

library(tidyr)
library(tidyverse)
library(dplyr)
data("EuStockMarkets")

# n<- data("EuStockMarkets")

# colnames(n)

stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets),4))

plot_ly(stocks, x = stocks$time, y = stocks$price, color = stocks$index)

install.packages("quantmod_0.4-14.tar.gz", repos = NULL, type = "source")

startDate <- as.Date(2019-04-01)
endDate <- as.Date(2020-04-24)

getSymbols("SPY",  from = startDate , to = endDate)
getSymbols("SPY",  from = startDate , to = endDate, src = "google")

###########
install.packages("quantmod")
library(quantmod)
update.packages("quantmod")
install.packages("TTR")
library(TTR)
getSymbols('INTC')
df <- getSymbols('INTC', src = 'yahoo', auto.assign = FALSE)


# plot_ly(stocks, x = stocks$time, y = stocks$price, color = index)

head(stocks)

plot_ly(stocks, x = time, y = price)

remove.packages("rlang")
install.packages("rlang")
update.packages("rlang")
remove.packages("ggplot2")
install.packages("ggplot2")
update.packages("ggplot2")

### Sample2 : 
data("airmiles")
library(plotly)
plot_ly(x = time(airmiles), y = airmiles)


# plotly(stocks)
library(forecast)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(fpp2)
inflation <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/CPIAUCSL.csv",
                      header = TRUE)
# View(inflation)
head(inflation)
summary(inflation)
str(inflation)
colnames(inflation)
inflation$DATE <- as.Date(inflation$DATE)
inflation <- inflation %>%
  filter(DATE >= '2020-02-03')
summary(inflation)

inflation$DATE <- na.omit(inflation$DATE)
inflation$CPIAUCSL <- na.omit(inflation$CPIAUCSL)
view(inflation)

# inflation <- ts(inflation, start = '2021-01-01', frequency = 12)

plot(inflation$DATE,inflation$CPIAUCSL,
     main = "US Inflation Trend Analysis from 2021 till 2023",
     xlab = "Year", ylab = "CPI (Consumer Price Index)")

scatter.smooth(x = inflation$DATE, y = inflation$CPIAUCSL, xlab = "Year",
               ylab = "CPI (Consumer Price Index)")


?scatter.smooth

tsmod <- stlm(inflation,modelfunction = ar)

library(xts)
y <- xts(NULL, order.by = seq.Date(from = as.Date("2021-01-01"), by = "months", length.out = 43))

head(inflation)
as.data.frame(inflation,y)
# plot(stlm(inflation,method = "ets"))
# plot.ts(inflation)
# plot(inflation)
# plot.ts(inflation)
# plot(stl(inflation, s.window = 7))
# plot.ts(stl(inflation,s.window = 7))


plot(stlf(inflation,method = "ets"))
auto.arima(inflation,stepwise = F,
           approximation = F,
           trace = T)

###Yahoo Finance 
install.packages("quantmod")
library(quantmod)
microsoft_dif <- getSymbols('MSFT',
                        src = 'yahoo',
                        auto.assign = FALSE)
head(apple_dif)
chartSeries(microsoft_dif,name = 'MSFT',subset = 'last 6 months',
            theme = chartTheme("white"))

chartSeries(apple_dif,name = 'AAPL',subset = 'last 6 months',
            theme = chartTheme("white"))

library(forecast)
library(dplyr)
library(tidyverse)
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

inflation <- ts(inflation, start = '2021-01-01', frequency = 12)

plot(inflation$DATE,inflation$CPIAUCSL,
     main = "US Inflation Trend Analysis from 2021 till 2023",
     xlab = "Year", ylab = "CPI (Consumer Price Index)")

plot(stlm(inflation,method = "ets"))
plot.ts(inflation)
str(inflation)
plot(inflation)
plot.ts(inflation)
plot(stl(inflation, s.window = 7))
plot.ts(stl(inflation,s.window = 7))

#stl forecasting 

plot(stlf(inflation,method = "ets"))
auto.arima(inflation,stepwise = F,
           approximation = F,
           trace = T)

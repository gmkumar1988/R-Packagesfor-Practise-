file.choose()
rcdf <- read.csv("/Users/maheshg/Dropbox/Clustering in R Great Learning/Cust_Spend_Data.csv", sep = ",", header = TRUE)

View(rcdf)

market <- read.csv("/Users/maheshg/Dropbox/Clustering in R Great Learning/MARKET_BASKET_ANALYSIS.csv", header = TRUE)

#Market Basket Analysis 

View(market)
head(market)
nrow(market)

market$Invoice_No <- as.factor(market$Invoice_No)

str(market)

agg.market <- split(market$Item_Desc, market$Invoice_No)
class(agg.market)
agg.market

agg.market[3]

install.packages("arules")
library(arules)
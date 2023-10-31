# install.packages("forecast")
library(forecast)
# install.packages("dygraphs")
library(dygraphs)
laborforce = na.omit(laborforce)
# is.na(laborforce)
View(laborforce)
rownames(laborforce)
laborforce <- laborforce[,-c(1,2)]
laborforce <- t(laborforce)
# dim(laborforce)
colnames(laborforce) <- c('Year','Emp Rate')
dim(laborforce)
# str(laborforce)
# plot(df, xlab = "Year", ylab = "Employment Rate", 
#      main = "Spain Labor Force Employment Rate Till 2020")
# plot.ts(laborforce)
# # holttrend =holt(laborforce, h = 5)
plot(laborforce, xlab = "Year", ylab = "Employment Rate",
     main = "Spain Labor Force Employment Rate till 2020")


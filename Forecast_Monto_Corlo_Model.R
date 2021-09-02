install.packages("RCurl")
library(RCurl)

file.choose()

mydata_natural_gas <- read.csv("/Users/maheshgurumoorthi/Dropbox/daily_csv.csv", header = TRUE)


View(mydata_natural_gas)

#Create Time Series : 
timeseries_naturalgas <- ts(mydata_natural_gas$Price,frequency = 12, start = c(2015,1))

#Check Time Series : 
start(timeseries_naturalgas)
end(timeseries_naturalgas)
frequency(timeseries_naturalgas)

#Remove Q4: 
timeseries_sub_naturalgas <- window(timeseries_naturalgas,start = c(2015,1), end = c(2030,9))

#Define Targer of natural gas : 
mytarget_naturalgas = 2.0 

#Calculate the actuals : 
actualYTD <- sum(window(timeseries_naturalgas,start = c(2015,1),end = c(2030,9)))

#Checking distribution scale : 
hist(timeseries_sub_naturalgas)
boxplot(timeseries_sub_naturalgas)
ts.series <- as.data.frame(timeseries_sub_naturalgas)

#Fit traditional distribution:
install.packages("fitdistrplus")
library(fitdistrplus)
fit.norm <- fitdist(as.numeric(ts.series$x),"norm")
fit.exp <- fitdist(as.numeric(ts.series$x),"exp")
fit.weibull <- fitdist(as.numeric(ts.series$x),"weibull")
fit.lnorm <- fitdist(as.numeric(ts.series$x),"lnorm")
fit.gamma <- fitdist(as.numeric(ts.series$x),"gamma")
fit.logistic <- fitdist(as.numeric(ts.series$x),"logis")
fit.cauchy <- fitdist(as.numeric(ts.series$x),"cauchy")

#Comparing goodness of fit statistics : 
gofstat(list(fit.norm,fit.exp,fit.weibull,fit.lnorm,fit.gamma,fit.logistic,fit.cauchy),fitnames = c("fit.norm","fit.exp","fit.weibull","fit.lnorm","fit.gamma","fit.logistic","fit.cauchy"))

#Best goodness of fit is normal distribution 
option1 <- fit.norm
summary(option1)

#Fitting supplementary distribution of the observed events: 
install.packages("SuppDists")
library(SuppDists)
params <- JohnsonFit(as.numeric(ts.series$x), moment = "quant")

#plot the distribution : 
hist(as.numeric(ts.series$x), freq = FALSE)
plot(function(x)dJohnson(x,params),0,20, add = TRUE, col = "red")

#option for next 3 months 
option2 <- function(x)qJohnson(x,params)

#Forecasting natural gas price details for next 3 months :
install.packages("truncnorm")
library(truncnorm)
fit.coef <- coef(fit.norm)
final_df1 <- as.data.frame(rtruncnorm(n = 2.5^4, a = min(ts.series$x),
                                      b= max(ts.series$x), mean = fit.coef["mean"], sd = fit.coef["sd"]))
colnames(final_df1) <- "2022"
final_df1 <- as.data.frame(rtruncnorm(n = 1.5^4, a = min(ts.series$x),
                                      b= max(ts.series$x), mean = fit.coef["mean"], sd = fit.coef["sd"]))

final_df1_forecast <- actualYTD + final_df1$`2022`

hist(final_df1_forecast)

#option2 : 
option2 <- function(x)qJohnson(x,params)
option2sample <- option2(runif(24))
hist(option2sample)
boxplot(option2sample,as.numeric(ts.series$x))
final_df2 <- as.data.frame(option2(runif(24)))
colnames(final_df2) <- 2022
final_df2_forecast <- actualYTD + final_df2$`2022`
hist(final_df2_forecast)

boxplot(final_df1_forecast,final_df2_forecast)
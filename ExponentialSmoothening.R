library(tidyverse)
library(fpp2)
goog.train <- window(goog,
                     end = 900)
goog.test <- window(goog,
                    start = 901)
#SES Technique - Simple Exponential Smoothening:
ses.goog <- ses(goog.train,
                alpha = 0.2,
                h = 100)
autoplot(ses.goog)
#Reminving the trend from the test set 
goog.diff.test <- diff(goog.test)
autoplot(goog.diff.test)
accuracy(ses.goog.diff,goog.diff.test)

##Remove trend from the google dataset 
goog.diff <- diff(goog.train)
autoplot(goog.diff)
ses.goog.diff <- ses(goog.diff,
                     alpha = 0.2,
                     h=100)
autoplot(ses.goog.diff)
alpha <- seq(0.1,0.99, by=0.01)
RMSE <- NA
for(i in seq_along(alpha)) {
  fit <- ses(goog.diff,alpha = alpha[i],
             h=100)
  RMSE[i] <- accuracy(fit,
                      goog.diff.test)[2,2]
  
}
##Converting to dataframe :
alpha.fit <- tibble(alpha,RMSE)
alpha.min <- filter(alpha.fit,
                    RMSE == min(RMSE))
ggplot(alpha.fit, aes(alpha,RMSE)) +
  geom_line() +
  geom_point(data = alpha.min,
             aes(alpha,RMSE),
             size = 2, color = "red")
file.choose()

install.packages("tidyverse")
library(tidyverse)

getwd()

#Reading Data Set : 
abtest <- read.csv("/Users/maheshgurumoorthi/Desktop/Mahesh Files /Study/Datasets/ABTesting_Restaurant.csv")

#Viewing abtest dataframe :
View(abtest)

#Saving file in my working directory:
save(abtest, file = "~rda\\abtest.rda")

#Filter and Segregate A and B :
##Filtering Variant A alone : 
conversion_subsetA <- abtest %>%
  filter(variant == "A" & converted == "TRUE")

View(conversion_subsetA)

#Total number of Conversion A: 
conversions_A <- nrow(conversion_subsetA)

visitorA <- nrow(abtest %>% filter(variant == "A"))

conversion_rateA <- (conversions_A / visitorA)

print(conversion_rateA)

##Filtering Variant B alone : 
conversion_subsetB <- abtest %>%
  filter(variant == "B" & converted == "TRUE")

View(conversion_subsetB)

#Total number of Conversion B: 
conversion_B <- nrow(conversion_subsetB)

visitorB <- nrow(abtest %>% filter(variant == "B"))

conversion_rateB <- (conversion_B / visitorB)

print(conversion_rateB)

#Percentage Increase Between Restaurant A and Restaurant B : 
percentdiff <- (conversion_rateB - conversion_rateA) / conversion_rateA * 100
percentdiff #82.72% Hence Restaurant B is better than A 


#Pooled Sample Proportiaon of Variant A and B : 
p_pool <- (conversions_A + conversion_B) / (visitorA + visitorB)

#Standard Error for variants A and B : 
se_pool <- sqrt(p_pool * (1 - p_pool) * ((1/ visitorA) + (1 / visitorB)))

#Margin of error  of the pool : 
moe <- se_pool * qnorm(0.975)

#Point Estimate or Difference in proportion : 
d_hat <- conversion_rateB - conversion_rateA

#Compute Z score 
zscore <- d_hat / se_pool

#Compute P Value 
pvalue <- pnorm(q = -zscore, mean = 0, sd = 1) * 2

#Compute Confidence Interval : 
ci <- c(d_hat - moe, d_hat + moe)
ci_lower <- d_hat - qnorm(0.975) * se_pool
ci_upper <- d_hat - qnorm(0.975) * se_pool
#Intervals for Variant  A: 
x_hat_a <- conversions_A / visitorA
se_hat_a <- sqrt(x_hat_a * (1-x_hat_a) / visitorA)
ci_a <- c(x_hat_a - qnorm(0.975) * se_hat_a, x_hat_a + qnorm(0.975) * se_hat_a)

#Intervals for Variant B : 
x_hat_b <- conversion_B / visitorB
se_hat_b <- sqrt(x_hat_b * (1- x_hat_b) / visitorB)
ci_b <- c(x_hat_b - qnorm(0.975) * se_hat_b, x_hat_b + qnorm(0.975) * se_hat_b)

#Visualization the result : 
vis_result <- data.frame(
  metric = c(
    'Estimated Difference',
    'Relative Percentage(%)',
    'Pooled Sample Proportion',
    'Standard Error Of Difference',
    'z-score',
    'p-value',
    'Margin Of Error',
    'CI- lower',
    'CI- upper'),
  value = c(
    conversion_rateB - conversion_rateA,
  percentdiff,
  p_pool,
  se_pool,
  zscore,
  pvalue,
  moe,
  ci_lower,
  ci_upper
))






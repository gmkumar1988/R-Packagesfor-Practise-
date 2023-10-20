library(tidyverse)
abtest <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/Website Results.csv",
                   header = TRUE)
# save(abtest, file = "/Users/maheshg/Dropbox/git repos/R-Packagesfor-Practise/abtest.rda")

view(abtest)
#Step 1 : Filter the conversions for Variant A
conversion_subset_A <- abtest %>%
  filter(variant == "A" & converted == "TRUE")
#Step 2 : Total number of conversions 
conversion_A <- nrow(conversion_subset_A)

#Step 3 : Number of visitors for variant A 
visitor_A <- nrow(abtest %>%
                    filter (variant == "A"))
#Step 4 : Conversion Rate A
conversion_rate_A <- conversion_A / visitor_A
print(conversion_rate_A)

#Step 5 : Filter the conversion for Variant B 
conversion_subset_B <- abtest %>%
  filter (variant == "B" & converted == "TRUE")

#Step 6 : Total number of conversions 
conversion_B <- nrow(conversion_subset_B)

#Step 7 : Number of visitors for variant B 
visitor_B <- nrow(abtest %>%
                    filter (variant == "B"))
#Step 8 : Conversion Rate B 
conversion_rate_B <- conversion_B / visitor_B
print(conversion_rate_B)

##Uplifing the conversion rates A & B 
uplift <- (conversion_rate_B - conversion_rate_A) / conversion_rate_A * 100
print(uplift)

## Pooled Probability, Standard Error, Margin of error and difference in proportion 
p_pool <- (conversion_A + conversion_B) / (visitor_A + visitor_B)
print(p_pool)
se_pool <- sqrt(p_pool * (1-p_pool) * ((1/visitor_A) + (1/visitor_B)))
print(se_pool)
moe <- se_pool * qnorm(0.975)
print(moe)
d_hat <- conversion_rate_B - conversion_rate_A
print(d_hat)
z_score <- d_hat / se_pool
print(z_score)

p_value <- pnorm(q = -z_score, mean = 0, sd = 1)*2
print(p_value)
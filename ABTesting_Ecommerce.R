### Reading the datset from the source: 

ecommerce <- read.csv("/Users/maheshg/Downloads/ecommerce_ab_testing_2022_dataset1/ab_data.csv",
                      header = TRUE)
###VIewing the ecommerce dataset : 
View(ecommerce)
#View the column names of ecommerce : 
colnames(ecommerce)

#View the row names of ecommerce: 
rownames(ecommerce)

# Summary of ecommerce 
summary(ecommerce)

summary(ecommerce[,c('user_id')])

nrow(ecommerce)

ecommerce_cleaned <- na.omit(ecommerce)

### Load the required packages : 
install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)

head(ecommerce_cleaned)

###Let's filter out the landing page as old_page : 
landing_page_old <- ecommerce_cleaned %>%
  filter(landing_page == 'old_page' & converted == 'True' )

head(landing_page_old)

### Total Number of Conversion for old page : 
conversion_old_page <- nrow(landing_page_old)

### Number of users landing in the old page : 
users_old_page <- nrow(ecommerce_cleaned %>%
                         filter(landing_page == 'old_page'))

### Calculating the conversion rate for old page users: 
conversion_rate_oldpage <- (conversion_old_page / users_old_page)
print(conversion_rate_oldpage)
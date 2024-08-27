#Getting the required packages: 

library(tidyverse)
# install.packages("ggpubr")
# install.packages("rstatix")
library(ggpubr)
library(rstatix)

#Loading and exploring the dataset: 
education_districtwise <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Global_Education.csv", header =  TRUE,
)
head(education_districtwise, n = 10)
view(education_districtwise)
summary(education_districtwise)
str(education_districtwise)
class(education_districtwise)

#Summary Statistics: 
education_districtwise %>% get_summary_stats(education_districtwise$OOSR_Primary_Age_Male,
                                             type = "mean_sd")


#Data format and preparation : 
df <- education_districtwise[, c("Youth_15_24_Literacy_Rate_Male",
                                 "Youth_15_24_Literacy_Rate_Female" )]
str(df)
head(df)

##Point Plot / Basic Scatter Plot : 

qplot(data = df, x = Youth_15_24_Literacy_Rate_Male, y = Youth_15_24_Literacy_Rate_Female,
      geom = "point")

par(mfrow = c(2,1))

##Scatter Plot with smooth line : 
qplot (data = df, x = Youth_15_24_Literacy_Rate_Male, 
       y= Youth_15_24_Literacy_Rate_Female, geom = c("point", "smooth"),
       xlab = "Youth Literacy Rate of Male",
       ylab = "Youth Literacy Rate of Female",
       main = "Literacy Rate Ratio of Youth Age 15 to 24 across the Globe")

library(ggplot2)
##Qplot with cylinder: 
qplot (data = df, x = Youth_15_24_Literacy_Rate_Male, 
       y= Youth_15_24_Literacy_Rate_Female, colour = cyl, 
       shape = cyl)

##Violin Plot : 
qplot (data = df, x = Youth_15_24_Literacy_Rate_Male, 
       y= Youth_15_24_Literacy_Rate_Female, geom = "violin",
       xlab = "Youth Literacy Rate of Male",
       ylab = "Youth Literacy Rate of Female",
       main = "Literacy Rate Ratio of Youth Age 15 to 24 across the Globe")


#GGplot using geom_point : 
ggplot (data = df, aes (x = df$Youth_15_24_Literacy_Rate_Male, 
       y= df$Youth_15_24_Literacy_Rate_Female)) +
         geom_point()

##In the following example we will see ggplot using density function ()
ggplot(data = df, df$Youth_15_24_Literacy_Rate_Female,
       aes(x = weights()) + geom_density())

my_data <- data.frame(education_districtwise$OOSR_Pre0Primary_Age_Male,education_districtwise$Completion_Rate_Primary_Male
                         )

head(my_data,10)
View(my_data)
summary(my_data$education_districtwise.Completion_Rate_Primary_Male)

###Visualize using box plots : 
library(ggpubr)
ggboxplot(my_data$education_districtwise.Completion_Rate_Primary_Male,
          ylab = "Completion Rate of Male",xlab = FALSE,
          ggtheme = theme_minimal())

  shapiro.test(my_data$education_districtwise.Completion_Rate_Primary_Male)

ggqqplot(my_data$education_districtwise.Completion_Rate_Primary_Male,
         ylab = "Completion Rate for Male",
         ggtheme = theme_minimal())

###One Sample T-Test: 
res <- t.test(my_data$education_districtwise.Completion_Rate_Primary_Male, mu = 41.72)
print(res)
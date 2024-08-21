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


#Dot Plot : 
qplot (data = df, x = Youth_15_24_Literacy_Rate_Male, 
       y= Youth_15_24_Literacy_Rate_Female, geom = "density",
       xlab = "Youth Literacy Rate of Male",
       ylab = "Youth Literacy Rate of Female",
       main = "Literacy Rate Ratio of Youth Age 15 to 24 across the Globe")

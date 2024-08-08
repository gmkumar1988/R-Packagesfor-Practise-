install.packages("dplyr")
install.packages("tidyverse")
library(tidyverse)
library(dplyr)

education_districtwise <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Global_Education.csv", header =  TRUE,
                                    )
##head(education_districtwise, n = 10)
view(education_districtwise)
summary(education_districtwise)
str(education_districtwise)
sampled_data <- sample(education_districtwise, size = 10, replace = FALSE, prob = NULL)
sampled_data2 <- sample(education_districtwise, size = 50, replace = TRUE, prob = NULL)

View(sampled_data2)

colnames(sampled_data)
?mean
###Computing the sample mean for Gross Tertiary Education Enrollment : 
education_enrollment_country <- mean(sampled_data$Gross_Tertiary_Education_Enrollment,trim = 0.10, na.rm = FALSE)
print(education_enrollment)

###Computing the another sample mean for Gross Tertiary Education Enrollment with another sample value which is 50 and replacement value as TRUE 
education_enrollment_country2 <- mean(sampled_data2$Gross_Tertiary_Education_Enrollment, trim = 0.10, na.rm = FALSE)
print(education_enrollment_country2)

# View(education_enrollment_country)

##Scatter Plot : 
qplot(data = education_districtwise, x = education_districtwise$Completion_Rate_Primary_Male, 
      y = education_districtwise$Completion_Rate_Primary_Female,xlab = "Completion Rate Primary Male" ,
      ylab = "Completion Rate Primary Female",main = "Education Country Latest World Data",geom = "point")

#Scatter Plot with smooth line : 
qplot(data = education_districtwise, x = education_districtwise$Completion_Rate_Primary_Male, 
      y = education_districtwise$Completion_Rate_Primary_Female,xlab = "Completion Rate Primary Male" ,
      ylab = "Completion Rate Primary Female",main = "Education Country Latest World Data",geom = c("point","smooth"))

###Computing the mean of sampling distribution with more samples : 
# education_districtwise_list <- list()
education_districtwise_list <- for (i in 1:10) {
  append(education_districtwise_list, education_enrollment_country2)
}
education_districtwise_df <- data.frame(education_districtwise_list)

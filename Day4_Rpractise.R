install.packages("ggpubr")
install.packages("rstatix")

library(ggpubr)
library(rstatix)
library(tidyverse)

set.seed(1234)

ToothGrowth |>
  sample_n_by(supp,dose, size = 1)

library(tidyverse)
View(chickwts)
class(chickwts)
summarise(chickwts)
summary(chickwts)

qplot(data = chickwts,x = feed,y = weight,fill = feed, geom = "boxplot", col = I('darkblue'))
#### Datascience salary details 

file.choose()

data1 <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/ds_salaries.csv")

View(data1)

data2 <- data1 %>%
  select (salary, job_title, employee_residence) %>%
  filter (job_title == "Data Analyst" | job_title == "Data Scientist" | 
            job_title == "Data Engineer") %>%
  filter (salary <= 20000) %>%
  group_by(employee_residence)

View(data2)

head(data2)
options (scipen = 999)

qplot(data = data2, x = job_title, y = salary, fill = salary, geom = "boxplot", 
      col = I('darkblue'), fill = I('lightblue'), xlab ="Job Title", 
      ylab = "Salary", main = "Data Science Growth Descriptive Analaysis")





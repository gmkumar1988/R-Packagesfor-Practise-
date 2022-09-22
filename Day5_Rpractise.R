
x <- c(580, 7813, 28266, 59287, 75700,  
       87820, 95314, 126214, 218843, 471497, 
       936851, 1508725, 2072113) 

##install.packages("lubridate")
library(lubridate)
mts <- ts(x, start = decimal_date(ymd("2020-01-22")),
          frequency = 362.25/7)

plot(mts, xlab= "Weekly Data of Sales",
     ylab = "Total Revenue",
     main = "Sales vs Revenue",
     col.main = "darkgreen")

data1 <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/ds_salaries.csv")
colnames(data1)

library("dplyr")
test1 = data1 |>
  select(work_year, job_title) |>
  filter(work_year == "2020" | work_year == "2021") |>
  group_by(employee_residence)
summary(data1)


View(data1)

library(ggplot2)
install.packages(c("gifski","av"))
library(gifski)
library(av)

install.packages("gganimate")
library(gganimate)
theme_set(theme_bw())

attach(data1)

View(data1)
head(data1)
options(scipen = 999)


p <- ggplot(data1, 
            aes(x = salary_in_usd,
                y = salary,
                size = company_size,
                colour = job_title)) +
              geom_point(show.legend = FALSE, alpha = 0.7) +
              scale_color_viridis_d() +
              scale_size(range = c(2, 12)) +
              scale_x_log10() +
              labs(x = "Work Year", y = "Salary Details")
            
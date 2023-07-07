library(caret)
library(kernlab)
install.packages("rpart.plot")
library(rpart.plot)
install.packages("corrplot")
library(corrplot)
install.packages("ggcorrplot")
library(ggcorrplot)
# file.choose()
smoke = read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/smoke_detection_iot.csv", 
         header = TRUE)
install.packages("psych")
library(psych)
View(smoke)
library(dplyr)
library(tidyverse)
colnames(smoke)
glimpse(smoke)
smoke %>%
  select(
    temp_c = `Temperature.C.`,
    humidity = `Humidity...`,
    tvoc = `TVOC.ppb.`,
    co2 = `eCO2.ppm.`,
    h2 = `Raw.H2`,
    ethanol = `Raw.Ethanol`,
    pressure = `Pressure.hPa.`,
    pm1 = PM1.0,
    pm2_5 = PM2.5,
    fire_alarm = `Fire.Alarm`
    
  ) %>%
  mutate(
    fire_alarm = factor(fire_alarm, levels = c(1,0), labels = c("yes","no"))
  ) %>%
  glimpse() -> df_data

# pairs(df_data)
corPlot(df_data$temp_c, cex = 1.2)
cor(df_data)
ggplot(df_data, aes(x = df_data$temp_c, y = df_data$pressure)) + geom_point() 
install.packages("corrplot")
library(corrplot)
corrplot(corr = cor(df_data[,1:7]))


summary(df_data)

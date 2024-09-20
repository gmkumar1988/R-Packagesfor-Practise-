# ###Load the required packages: 
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("broom")
# install.packages("ggpubr")

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)

petrol <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/petrol_consumption.csv")
head(petrol)
cor(petrol)
summary(petrol)

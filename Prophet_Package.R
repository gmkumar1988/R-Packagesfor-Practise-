install.packages("prophet")
library(prophet)

file.choose()

ap <- read.csv("C://Users//mgurumoorthi//Downloads//dataset-58057.csv")

View(ap)

ap = as.data.frame(ap)

prophet(ap)


summary(ap)
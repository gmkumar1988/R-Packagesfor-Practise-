install.packages("rayshader")
install.packages("rayrender")

library(rayshader)
library(rayrender)

install.packages("tidystats")
library(tidystats)

results <- list()

sleeptest <- t.test(extra ~ group, data = sleep, paired = TRUE)
sleeptest

ctrl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2,10,20,labels = c("ctrl","trt"))
weigt <- c(ctrl, trt)
lm_d9 <- lm(weigt ~ group)

npk_aov <- aov(yield ~ block + N*P*K, npk)

results <- results %>%
  add_stats(sleeptest, type = "primary") %>%
  add_stats(lm_d9, preregistered = FALSE) %>%
  add_stats(npk_aov, notes = "An ANOVA example")

write_stats(results, "results.json")

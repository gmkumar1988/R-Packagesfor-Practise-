library(ggplot2)
install.packages("cowplot")
library(cowplot) #Additional Feature of ggplot package improvement
# install.packages("randomForest")
# library(randomForest)
install.packages("forecast")

file.choose()

rainprediction <- read.csv("/Users/maheshgurumoorthi/Dropbox/AusDataForRainPred.csv", header = TRUE)
View(rainprediction)

str(rainprediction)

install.packages("GGally")
library(GGally)
install.packages("scatterplot3d")
library(scatterplot3d)

ggpairs(data = rainprediction, columns = 3:5,title = "Australia History of Rain Prediction ")

fit_1 <- lm(rainprediction$Rainfall ~ rainprediction$MinTemp, data = rainprediction)

summary(fit_1)

plot(fit_1)


ggplot(data = rainprediction, aes(x = rainprediction$MinTemp, y = rainprediction$Rainfall)) +
  geom_point() +
  stat_smooth(method = "lm", col = "dodgerblue3") +
  theme(panel.background = element_rect(fill = "white"),
        axis.line.x=element_line(),
        axis.line.y=element_line()) +
  ggtitle("Linear Model Fitted to RainFall Australia")


fit_2 <- lm(rainprediction$Rainfall ~ rainprediction$MinTemp + rainprediction$MaxTemp, data = rainprediction)

summary(fit_2)

fit_2_sp <- scatterplot3d(rainprediction$Rainfall, rainprediction$MinTemp, rainprediction$MaxTemp, angle = 60, color = "dodgerblue", pch = 1, ylab = "Rainfall Prediction", xlab = "Minimum Temp", zlab = "Maximum Temp" )


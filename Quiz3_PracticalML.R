install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)
library(caret)
set.seed(125)
data("segmentationOriginal")
trainSet <- segmentationOriginal[segmentationOriginal$Case =="Train",]
testSet <- segmentationOriginal[segmentationOriginal$Case =="Test",]

fit <- train(Class ~ ., data = trainSet,method = "rpart")
plot(fit$finalModel, uniform = TRUE, 
     main = "Classification of Tree")
text (fit$finalModel, use.n = TRUE, all = TRUE, cex = 0.8)

install.packages("ElemStatLearn")

library(caret)
library(gbm)
install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)
set.seed(3433)

data(AlzheimerDisease)
adData <- data.frame(diagnosis,predictors)
intrain <- createDataPartition(y = adData$diagnosis, p = 0.70, list = FALSE)
training <- adData[intrain,]
testing <- adData[-intrain,]

if(FALSE) {
  set.seet(62433)
  fitRf <- train(diagnosis~ ., method = "rf")
  fitGBM <- train(diagnosis ~ ., method = "gbm", verbose = FALSE)
  fitLDA <- train(diagnosis ~ ., method = "lda")

  prRF <- predict(fitRf, testing)
  prGBM <- predict (fitGBM, testing)
  prLDA <- predict(fitLDA, testing)
  
  combo <- data.frame(prRf, prGBM, prLDA, diagnosis = testing$diagnosis)
  fitST <- train(diagnosis ~., data = combo, method = "rf")
  prST <- predict(fitST, testing)
  print(paste0("RF accuracy = ", confusionMatrix(prRf, testing$diagnosis)$overall['Accuracy']))
  print(paste0("GBM accuracy = ", confusionMatrix(prGbm, testing$diagnosis)$overall['Accuracy']))
  print(paste0("LDA accuracy = ", confusionMatrix(prLda, testing$diagnosis)$overall['Accuracy']))
  print(paste0("Stacked accuracy = ", confusionMatrix(prSt, testing$diagnosis)$overall['Accuracy']))
  }
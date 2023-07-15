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
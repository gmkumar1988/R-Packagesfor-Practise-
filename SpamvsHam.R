install.packages("kernlab")
library(kernlab)
data("spam")
head(spam)

plot(density(spam$your[spam$type == "nonspam"]),
     col = "blue", main = "Spam Inbox Identification", 
     xlab = "Frequency of 'your")
lines(density(spam$your[spam$type=="spam"]), col = "red")

prediction <- ifelse(spam$your > 0.5, "spam", "nonspam")
table(prediction, spam$type) / length(spam$type)


#### Sample versus out of sample errors 
library(kernlab)
data('spam')
set.seed(333)
smallSpam <- spam[sample(dim(spam)[1], size = 10),]
spamlable <- (smallSpam$type=="spam") * 1 + 1
plot(smallSpam$capitalAve, col = spamlable)


###Rule 2 to small spam
rule2 <- function(x) {
  prediction <- rep(NA, length(x))
  prediction [x >2.4] <- "Spam"
  prediction [x <= 2.4] <- "Non Spam"
  return(prediction)
  
}
table(rule2(smallSpam$capitalAve), smallSpam$type)
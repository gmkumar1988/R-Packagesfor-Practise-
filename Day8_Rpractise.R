library(arules)
library(arulesViz)
data("Groceries")

itemFrequencyPlot(Groceries,topN= 20, type = "absolute")

?itemFrequencyPlot
View(Groceries)
str(Groceries)

read.transactions(file.choose())

file.choose()
##insta_orders <- read.transactions("/Users/maheshg/Dropbox/Sample Datasets Kaggle/Instacartkaggle/orders.csv")
mydata <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/netflix_titles.csv", sep = "\t", 
                   header = TRUE)
str(mydata)
View(mydata)
rules <- apriori(mydata)
?discretizeDF

rules <- apriori(mydata,parameter = list(minlen=2, maxlen=10,supp=.7, conf=.8))

inspect(rules)

rules <- apriori(mydata,parameter = list(minlen=2, maxlen=3,supp=.01, conf=.7),appearance=list(rhs=c("Foundation=Yes"),lhs=c("Bag=Yes", "Blush=Yes"),default="lhs"))

inspect(rules)
file.choose()
install.packages(
  "rjson"
)

library(rjson)
cluster_raw <- fromJSON(file = "/Users/maheshgurumoorthi/Dropbox/marketing_sample_for_careerbuilder_usa-careerbuilder_job_listing__20200401_20200630__30k_data.ldjson")
cluster_raw_dataframe <- as.data.frame(cluster_raw)
print(cluster_raw_dataframe)


###Sample :
install.packages("useful")
library(useful)

wineUrl <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data'
wine <- read.table(wineUrl, header=F, sep=',')
head(wine)
wine_kmeans <- wine[, which(names(wine) != "Cultivar")]
wine_cluster <- kmeans(x=wine_kmeans , centers=3)
plot(wine_cluster, data=wine_kmeans)


###Alternate Dataset - Customer Clustering 

customer_raw <- read.csv("/Users/maheshgurumoorthi/Dropbox/customer_clustering/segmentation data.csv")
head(customer_raw)
is.na(customer_raw)
plot_missing(customer_raw)
library(ClusterR)
library(cluster)
print(customer_raw)
str(customer_raw)
# customer_raw$Sex <- replace(customer_raw$Sex,0, 'Male')
library(plyr)
# customer_raw$Sex <- revalue(customer_raw$Sex, c(0 == "Male"))

#Replacing Sex Values 0 to Male and 1 to Female : 
customer_raw$Sex[customer_raw$Sex == "0"] <- "Male"
customer_raw$Sex[customer_raw$Sex == "1"] <- "Female"
head(customer_raw)

#Replacing Marital Status 0 to Married and 1 to Not Married : 
customer_raw$Marital.status[customer_raw$Marital.status == "0"] <- "Married"
customer_raw$Marital.status[customer_raw$Marital.status == "1"] <- "Not Married"

head(customer_raw)

plot_missing(customer_raw)

#Cleaned Data By Removing ID column from the dataset : 
customer_cluster <- customer_raw[,-1]
head(customer_cluster)

set.seed(1000)
customer_cluster_k <- kmeans(customer_cluster, 3, 20)
str(customer_cluster_k)
View(customer_cluster_k)
customer_cluster_k

###Cluster Identification for each observation : 
customer_cluster_k$cluster


###Confusion Matrix : 
confusion_matrix <- table(customer_cluster$Income, customer_cluster_k$cluster)
confusion_matrix

aggregate(customer_cluster, by = list(cluster = customer_cluster_k$cluster), mean)

plot(customer_cluster_k$centers[,c("Age","Income")])
# install.packages("factoextra")
# library(factoextra)

str(customer_cluster)

library(dplyr)
customer_new <- customer_cluster %>% 
  select("Sex", "Income")

str(customer_new)

customer_new_cluster <- kmeans(x = customer_new$Income, centers = 5)
options(scipen = 99999)
plot(customer_new_cluster)

customer_cluster %>% 
  as_tibble() %>%
  mutate (cluster = customer_cluster_)


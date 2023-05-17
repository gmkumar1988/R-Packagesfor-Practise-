youtube_india <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/Youtube_data/Countries_data/INvideos.csv", 
                         sep = ",", header = TRUE)

head(youtube_india)
View(youtube_india)

str(youtube_india)

install.packages("tm")

library(tm)

youtube_india_corpus <- iconv(youtube_india$title)
youtube_india_corpus <- Corpus(VectorSource(youtube_india_corpus))

inspect(youtube_india_corpus[1:5])

youtube_india_corpus <- tm_map(youtube_india_corpus, tolower)

inspect(youtube_india_corpus[1:5])

youtube_india_corpus <- tm_map(youtube_india_corpus, removePunctuation)
inspect(youtube_india_corpus[1:5])

youtube_india_corpus <- tm_map(youtube_india_corpus, removeNumbers)
inspect(youtube_india_corpus[1:5])

cleanset <- tm_map(youtube_india_corpus, removeWords, stopwords('english'))
inspect(cleanset[1:5])

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

cleanset <- tm_map(cleanset, stemDocument)
cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])

tdm <- TermDocumentMatrix(cleanset)
tdm <- as.matrix(tdm)

tdm[1:10, 1:20]

w<- rowSums(tdm, na.rm = na.rm)

w<- subset(w,w>=25)
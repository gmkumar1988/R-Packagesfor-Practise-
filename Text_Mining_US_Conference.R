install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
install.packages("syuzhet") # for sentiment analysis
install.packages("ggplot2") # for plotting values 

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(syuzhet)
library(ggplot2)

#Loading the dataset:
file_text <- readLines(file.choose())
#Load the data Corpus :
file_doc <- Corpus(VectorSource(file_text))


# for(i in seq(file_doc))   { 
#   docs[[i]] <- gsub("/", " ", docs[[i]])   
#   docs[[i]] <- gsub("@", " ", docs[[i]])   
#   docs[[i]] <- gsub("\|", " ", docs[[i]])
# }



inspect(file_doc)
# inspect(TextDoc)


toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))

#Replacing "/", "@" and "|" with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
file_doc <- tm_map(file_doc, toSpace, "/")
file_doc <- tm_map(file_doc, toSpace, "@")
file_doc <- tm_map(file_doc, toSpace, "\\|")
# Convert the text to lower case
file_doc <- tm_map(file_doc, content_transformer(tolower))
# Remove numbers
file_doc <- tm_map(file_doc, removeNumbers)
# Remove english common stopwords
file_doc <- tm_map(file_doc, removeWords, stopwords("english"))
# Remove your own stop word
# specify your custom stopwords as a character vector
file_doc <- tm_map(file_doc, removeWords, c("s", "company", "team")) 
# Remove punctuations
file_doc <- tm_map(file_doc, removePunctuation)
# Eliminate extra white spaces
file_doc <- tm_map(file_doc, stripWhitespace)
# Text stemming - which reduces words to their root form
file_doc <- tm_map(file_doc, stemDocument)

# Build a term-document matrix
dtm <- TermDocumentMatrix(file_doc)
dtm_m <- as.matrix(dtm)

#Sort By Descending Value of Frequency
dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)

head(dtm_d,10)

set.seed(15092)

wordcloud(words = dtm_d$word,freq = dtm_d$freq,title = "Most Frequent Words used in Amazon India Portal",
          min.freq = 1, max.words = 1000,
          random.order = FALSE,rot.per = 0.5,
          colors = brewer.pal(8,"Dark2"))

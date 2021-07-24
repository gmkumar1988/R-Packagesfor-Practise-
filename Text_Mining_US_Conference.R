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

file_text <- readLines(file.choose())
#Load the data Corpus :
file_doc <- Corpus(VectorSource(file_text))

inspect(file_doc)
inspect(TextDoc)


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

dtm <- TermDocumentMatrix(file_doc)
dtm_m <- as.matrix(file_doc)

# Build a term-document matrix
TextDoc_dtm <- TermDocumentMatrix(file_doc)
dtm_m <- as.matrix(TextDoc_dtm)

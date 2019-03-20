#https://rdrr.io/rforge/tm/man/content_transformer.html
#Scale Functions for Visualization
#Graphical scales map data to aesthetics, and provide methods for automatically 
#determining breaks and labels for axes and legends.
install.packages('Scale', dependencies=TRUE, repos='http://cran.rstudio.com/')

#Text Mining Package
#A framework for text mining applications within R.
install.packages('tm', dependencies=TRUE, repos='http://cran.rstudio.com/')


options(repos='http://cran.rstudio.com/')

# Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
#An R interface to the C 'libstemmer' library that implements Porter's word stemming algorithm
#for collapsing words to a common root to aid comparison of vocabulary. 
#Currently supported languages are Danish, Dutch, English, Finnish, French, German, 
#Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian, Spanish, Swedish and Turkish.
install.packages("SnowballC")

#Functionality to create pretty word clouds, visualize differences and similarity between documents, 
#and avoid over-plotting in scatter plots with text.
install.packages("wordcloud")


#Provides color schemes for maps (and other graphics) designed by Cynthia Brewer
#http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know
install.packages("RColorBrewer")


#The stringr package provide a cohesive set of functions
#designed to make working with strings as easy as possible
install.packages("stringr")

#Provides an interface to the Twitter web API.
install.packages("twitteR")


library(Scale)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(twitteR)


url <- "http://www.rdatamining.com/data/rdmTweets-201306.RData"
download.file(url, destfile = "d://two//rdmTweets-201306.RData")

load("C://Users//lenovo//Downloads//rdmTweets-201306.RData")

## load tweets into R
load(file = "d://two//rdmTweets-201306.RData")

#get the data from whatsapp chat 
text <- readLines("d://two//rdmTweets-201306.RData")

#let us create the corpus
#A vector source interprets each element of the vector x as a document.-VectorSource(x)
#Representing and computing on corpora.
#Corpora are collections of documents containing (natural language) text. 
docs <- Corpus(VectorSource(text))

#clean our chat data
#content_transformer-Create content transformers, i.e., functions which modify the content of an R object.
#tm_map-Interface to apply transformation functions (also denoted as mappings) to corpora.
trans <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, trans, "/")
docs <- tm_map(docs, trans, "@")
docs <- tm_map(docs, trans, "\\|")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("sudharsan","friendName"))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)

#create the document term matrix
dtm <- TermDocumentMatrix(docs)
mat <- as.matrix(dtm)
v <- sort(rowSums(mat),decreasing=TRUE)

#Data frame
data <- data.frame(word = names(v),freq=v)
head(data, 10)


#generate the wordcloud
#words : the words to be plotted
#freq : their frequencies
#min.freq : words with frequency below min.freq will not be plotted
#max.words : maximum number of words to be plotted
#random.order : plot words in random order. If false, they will be plotted in decreasing frequency
#rot.per : proportion words with 90 degree rotation (vertical text)
#colors : color words from least to most frequent. Use, for example, colors ="black" for single color.
set.seed(1056)
wordcloud(words = data$word, freq = data$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))



install.packages("SnowballC")
install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")

# Load Requried Packages
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")

# Authonitical keys
consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- userTimeline("realDonaldTrump", n=200)
n.tweet <- length(tweets)
tweets.df <- twListToDF(tweets) 
head(tweets.df)

#Load the file from hard disk
tweets.df=read.csv("C:\\Users\\Admin\\Downloads\\Sentiment.csv")
head(tweets.df$text)
dim(tweets.df)

head(tweets.df$text)
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)

#tweets.df2 <- gsub("#.*","",tweets.df$text)
tweets.df2 <- gsub("@.*","",tweets.df2)

#to match occurrence of a single back slash in source
tweets.df2 <- gsub("////","",tweets.df2)
head(tweets.df2)

#Getting sentiment score for each tweet
word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
#Cbind  in R appends or combines vector, matrix or data frame by columns.
emotion.df2 <- cbind(tweets.df2, emotion.df) 
head(emotion.df2,100)

#get_sentiment function to extract sentiment score for each of the tweets
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.positive
most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative

sent.value

#segregate positive and negative tweets based on the score assigned to each of the tweets.
positive.tweets <- word.df[sent.value > 0]
head(positive.tweets)

#Negative Tweets
negative.tweets <- word.df[sent.value < 0] 
head(negative.tweets)

#Neutral tweets
neutral.tweets <- word.df[sent.value == 0]
head(neutral.tweets)

category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)

table(category_senti)






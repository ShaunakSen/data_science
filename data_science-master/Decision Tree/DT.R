# Suppose we are building a face recognition sw
# There can be 2 approaches to it

# First, we can encode features like shape of face, 2 ears, 1 nose etc and tell our sw to check for these
# But there's no learning in this
# Secondly, we can provide sw data - of human faces and other images like mountains, food etc. Also for every img
# we provide a label which says whether it is a human face or not. Sw learns the distinguising features bw these
# 2 classes of imgs

# Classification is also called Predictive Analysis as ur are predicting whether a given email is pam or non spam


# For a given dataset, and algo may perform better than another; which algo is better depends on ur dataset

# U can do this only by Trial and Error
# For a given data, u apply DT, the RF then NB, then u choose the one which gives u better acuracy

# What is DT?

# img src = img/Capture1

# How DT works?

# let us take an eg:
# img src = img/Capture2

# here our features are Outlook, Humidity and Wind\

# img src = img/Capture3

# From our data we choose Outlook and see how it affects our target var
# Here we have color coded the data acc to target var Play: Yes/No

# img src = img/Capture4

# Sunny: 1st partition: 2Y, 3N
# Overcast : All Y
# Rain: 3Y, 2N 

# based on historical data, if Overcast, Play, dont need to look at anything else
# But if Sunny, not sure, we need to split further, we need more vars
# Similar for Rainy

# img src = img/Capture5


# If Sunny check Humidity
# If Humidity is High, no play
# If Normal, Play

# Rain -> Humidity : Does not give any proper decision, so let's consider another var : Wind

# img src = img/Capture6
# If wind weak: Play
# If wind normal or high: not play

# Now if we have, for any day Outlook, Humidity and Wind Condition, we can predict if play should happen or not

# Why did we look at Outlook to begin with, why not Humidity or Wind?

# Again when Outlook was Sunny , why did we check Humidity? Why not Wind?

# How to know which attribute to take at any step while building the DT?


# Example: Client Subscription

# img src = img/Capture7

# A bank wants to market its prod to diff customers and see whether customer subscribes to the product or not
# we have certain attr, subscribed is our target var

# We need to build a DT, but which attr to begin with and which to choose at each step
# For this we have some math

# img src = img/Capture8

# Common way to identify most informative attr is to use Entropy
# Entropy measures the amt of uncertainity or randomness in the data

# Consider election data. if election(US election) is very tight , 49% said A 51% said B: Highly uncertain, High Entropy
# Consider last yr Ind election 90:10 to BJP. So uncertainity is less; its biased towards one outcome; Entropy is less

# if we have these 2 datasets, its easier to predict winner for Ind election data
# When Entropy is low, pred becomes easier

# img src = img/Capture7
# In this data 12 N 2 Y, Entropy is very Low
# Easy to predict, we can just say N, error chance is 2/14 only

# img src = img/Capture3

# We had Play: no play = 9:5 - High entropy

# img src = img/Capture6

# We divide data in such a way that every thing is clean subset
# At each leaf node, entropy is 0; there is no uncertainity at all
# So basically we are breaking up a difficult to predict prob into many easy to predict problems

# img src = img/Capture8

# if Y = 9, N = 5, p1 = prob of Y = 9/14, p2 = prob of N = 5/14.. Just plug values in and get the entropy


# img src = img/Capture9

# If u divide based on certain column, say contact column in the pic. What are the entropies of resulting partitions
# It computes entropy of resulting partitions when split on contact

# img src = img/Capture10

# Now we take subtraction: whats the entropy b4 and whats the entropy after partitioning by a particular attr
# Goal: take a difficult to classify prob and turn it into an easy to classify problem

# So we want the diff ie InfoGain to be as high as possible. if diff is high => we are dividing the prob into
# very small entropy partitions

# so we compute InfoGain for all the attr in our data

# the table shows InfoGain for all attrs
# Pick one with max InfoGain ie poutcome
# So given dataset, first thing I should check is poutcome and then repeat similarly

# img src = img/Capture11

# first thing I check is poutcome
# then again same calculation, compute InfoGain for the subset of data and choose best one - Education
# u keep on doing this until u get pure subset

# In addition to Entropy there is also something like Minimum Description Length to choose an attr

# DEMO

#----------------------------------------------------------------------------


# load dataset

diabetes_data <- read.csv("D:/data_science-master/Decision Tree/data/diabetes.csv")

View(diabetes_data)

# This dataset is about women patients who participated in Diabetes study
# Outcome: whether this patient has risk of diabetes or not

set.seed(3)

# training and testing data

id <- sample(2, nrow(diabetes_data), prob = c(0.7, 0.3), replace = TRUE)

diabetes_training_data <- diabetes_data[id==1, ]
diabetes_testing_data <- diabetes_data[id==2, ]
nrow(diabetes_training_data)
nrow(diabetes_testing_data)

# Building DT

library(rpart)

# rpart: Recursive Partitioning

# rpart(): can learn a DT from a given dataset


diabetes_model <- rpart(diabetes_training_data$Outcome~., data = diabetes_training_data)
# here we are using all cols

diabetes_model

plot(diabetes_model, margin = 0.1)

text(diabetes_model, use.n = TRUE, pretty = TRUE, cex = 0.8)


# evaluate the model

predict_data <- predict(diabetes_model, newdata = diabetes_testing_data, type = "class")

# predicted values
predict_data
# actual values
diabetes_testing_data$Outcome

library(caret)

confusionMatrix(table(predict_data, diabetes_testing_data$Outcome))






















































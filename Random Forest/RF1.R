# RF is used for classification problem
# It is a supervised learning model
# spam classifier: what params does it look for?
# subject line, text, html tags, ip addr of source etc.

# Types of Classifiers: Decision Tree, Random Forests and Naive Bayes

# RF is an ensemble classifier made from many DT models
# ensemble methods use multiple ML algos to get better predictive perf

# Entire dataset is split into 3 subsets
# each subset leads to a DT
# we have 3 DT and each DT leads to a certain outcome
# RF compiles results from all the DTS and then leads to a final outcome


# Bayes: describes prob of event based on certain prior knowledge of conditions that might be related to that event

# eg: cancer related to age.. age can be used to accurately assess prob of having cancer

# RF compiles diff results from diff DTs and finally compiles a final outcome
# img src = img/capture1

# RF can perform both Regression and Classification


# img src = img/capture2

# In the figure, a particular instance results in 3 diff DTs. Tree 1 outcome: Class A
# Tree 2 Outcome: Class B and Tree 3 Outcome: Class B
# RF compiles result, goes by majority voting -> Class B

# Example:

# Decide on a movie: 2 options -> ask ur best frnd or ask a bunch of frnds

# 1st scenario: img src = img/capture3

# this is one DT

# but we wanna consider options of other friends as well

# so u ask frnd1, frnd2, frnd3 as well.. majority of votes decide final outcome. Thus u build random forest of group of frnds

# Other DT examples: img src = img/capture4


# Random Forest Algorithm

# img src = img/capture5
# Why do we select only a few features at a time for constructing DTs?
# - if we select all, all ur Dts will be same only. So model is not learning something new


# how RF works?

# img src = img/capture6

# first step: split data set into subsets
# these may or may not overlap

# img src = img/capture7


# Our 3 diff subsets are: (D1, D2, D3), (D3,D4,D5,D6) and (D7,D8,D9)

# img src = img/capture8

# The outcome of first DT is play as ratio of play:no play is 2:1
# 2nd DT has diff vars so is entirely diff
# Play:no play = 3:2 so final is play
# 3rd DT ratio is 2:1 hence play
# final outcome by compiling results from each DT is Play

# Features of RF

# RF averages entire variance accross all DTs
# if variance for DT is x and there are n DTs, then total variance is x/n
# RF requires almost no ip preparations. Has implicit methods that take care of outliers and missing data
# Can be grown easily in parallal: as all DTs execute parallely
# Methods for balancing error in unbiased datasets
# Say we create RF model and get 90% accuracy. But then we find that 90% of that data actually belongs to a particular class
# RF takes care of this, its not biased towards any partricular DT

# _________________________________________________________________________________________

# DEMO

# We load Prima Indians Diabetes Dataset from Kaggle

library(randomForest)

diabetes_data <- read.csv("D:/data_science-master/Random Forest/data/diabetes.csv")
View(diabetes_data)

# split data into 2 parts - training and testing

set.seed(2)

# replace = TRUE makes sure no elements occur twice
# 2 : elements will be 1 or 2 only
# nrow : size of dataset to be generated
# prob : caiuses 70% 1s and 30% 2s
# sample doc: http://www.rexamples.com/14/Sample()


id <- sample(2, nrow(diabetes_data), prob = c(0.7,0.3), replace = TRUE)
id
diabetes_training_data <- diabetes_data[id == 1, ]
diabetes_testing_data <- diabetes_data[id == 2, ]

# we now have our training and testing datasets


# now we find optimal value of m ie the no of predictor vars to be selected
# we will use tuneRF function for this

best_m_try <- tuneRF(diabetes_training_data, diabetes_training_data$Outcome, stepFactor = 1.2, improve = 0.01, trace = TRUE, plot = TRUE)
# if there is improvement of at leaset 0.01 from prev iteration then it will continue else break
# most optimized value of no of random vars is 3
# OOB is pred error

# turn target vars into factors so that ur model treats it as classification problem

diabetes_training_data$Outcome <- as.factor(diabetes_training_data$Outcome)
diabetes_testing_data$Outcome <- as.factor(diabetes_testing_data$Outcome)


diabetes_model <- randomForest(Outcome~., data = diabetes_training_data)
diabetes_model


# dont confuse why we are taking all vars. RF has built in methods which will take care of selecting certain random vars of all predictor vars
# it will pick up randomly from the predictor vars

# DTs split at most significant var. So our root node will actually be most significant var

# Number of trees: 500
# OOB estimate of  error rate: 24.81%
# it gives confusion matrix also


diabetes_model$importance

# Glucose has max value, so is most significan var, 2nd most sig is BMI

varImpPlot(diabetes_model)

# splits gradually take place on significance of vars only, 1st split: most sig var, 2nd split: 2nd most sig var and so on...
# to get overview of significance of all the vars we have used importance param

# validating our model


diabetes_prediction <- predict(diabetes_model, newdata = diabetes_testing_data, type = "class")

diabetes_prediction


library(caret)

confusionMatrix(table(diabetes_prediction, diabetes_testing_data$Outcome))


# Accuracy : 0.7888






























































library(caTools) # for split
library(ROCR) # for finding proper threshold


# predict whether a patient is diabetic or not

# read the data

data <- read.csv(file = "D:/data_science-master/Logistic Regression/data.csv", head = TRUE, sep = ",")
head(data)

# split the data

split_data <- sample.split(data, SplitRatio = 0.8)

print(split_data)

training_data <- subset(data, split_data == "TRUE")
testing_data <- subset(data, split_data == "FALSE")

print(training_data)

# create model

#glm is Logistic Regression model function

model <- glm(training_data$type~., training_data, family = "binomial")

# binomial : only 2 outputs: 0 or 1

# get summary of the model

summary(model)


# *** - ur moidel is 99.9% confident that the ind var is significant to model
# ** - 99%
# * - 95%
# . - 90%

# NULL Deviance - 311 units. When u r not using any ind var. u r using only intercept ie B1 = B2 = ... = 0
# NULL Deviance is How much ur model is deviating from actual value when u do this - 311 units 

# Residual Deviance - when u include ind vars in ur model

# AIC : should be minm 

# optimize model

# while adding and removing ind vars residual dev should not inc and AIC should dec



model2 <- glm(training_data$type~.-age, training_data, family = "binomial")

summary(model2)


# AIC dec, but  residual dev is same, so let's remove age


# model3 <- glm(training_data$type~.-bp, training_data, family = "binomial")

# summary(model3)

compare_models <- function(model1, model2){
  
  aic1 = model1$aic
  aic2 = model2$aic
  residual1 = model1$deviance
  residual2 = model2$deviance
  # cat(aic1, aic2, residual1, residual2)
  
  
  diff_bw_aic = abs(aic1 - aic2)
  if (aic2 > aic1){
    return(FALSE)
  } else {
    if (residual2 <= residual1){
      return(TRUE)
    } else {
      # calculate % of variation
      percentage_var_aic = (diff_bw_aic/aic1)*100
      percentage_var_residuals = (abs(residual2 - residual1)/residual1)*100
      
      if(percentage_var_residuals < 5 && percentage_var_aic > 0.5){
        return(TRUE)
      } else {
        return(FALSE)
      }
      
    }
  }
}

print(compare_models(model, model2))


# model3 <- glm(training_data$type~.-skin, training_data, family = "binomial")

# summary(model3)


# model 2 is the final model

res <- predict(model2, testing_data, type = "response")
res

# gives prob values for each patients
# cross check with actual data to see if the prob values are right

testing_data

# check accuracy

# create confusion matrix


table(Actualvalue = testing_data$type, PredicetedValue = res > 0.5)
res



true_positives = 0
true_negatives = 0
false_positives = 0
false_negatives = 0
accuracy = -1



for(i in 1:nrow(testing_data)){
  actual_value = testing_data$type[i]
  predicted_value_actual = (res[i] < 0.5)
  
  if(predicted_value_actual == TRUE){
    predicted_value = 0
  } else {
    predicted_value = 1
  }
  cat(res[i], predicted_value)
  print("\n")
  
  if(actual_value == 1 && predicted_value == 1){
    true_positives = true_positives + 1
  } else if (actual_value == 0 && predicted_value == 0) {
    true_negatives = true_negatives + 1
  } else if (actual_value == 0 && predicted_value == 1){
    false_positives = false_positives + 1
  } else {
    false_negatives = false_negatives + 1
  }
  
  accuracy = (true_positives + true_negatives)/(true_positives + true_negatives + false_positives + false_negatives)
}


# in our case a false negative is far more dangerous than a false positive

# how to decide threshold

# one way is hit and trial

# Another method is the ROC curve

# first put in the predicted values: predicted values should be from training data set

res2 <- predict(model2, training_data, type = "response")

# we have stored the predicted values for training data in res2

# Define ROCRPred and ROCRPerf

# ROCRPred: 2 params: predicted result set, actual result set
ROCRPred <- prediction(res2,  training_data$type)

# In ROCRPerf we pass in ROCRPred to see how good our perf is
# we plot it against tpr and fpr
# tpr: True Positive Rate
# fpr : False Positive Rate

ROCRPerf <- performance(ROCRPred, "tpr", "fpr")

plot(ROCRPerf, colorize=TRUE, print.cutoffs.at = seq(0.1, by = 0.1))

# acc to graph chose 0.3 as FP is less and TP is more


res3 <- predict(model2, testing_data, type = "response")
table(Actualvalue = testing_data$type, PredicetedValue = res3 > 0.32)

# trail and error bw .3 and .4 and 

# false positive dec!!
# accuracy : 81.7%  









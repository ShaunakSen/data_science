library(caTools) # for split

# predict whether a patient is diabetic or not

# read the data

data <- read.csv(file = "F:/my_projects/data_science/Logistic Regression/data.csv", head = TRUE, sep = ",")
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


# *** - ur moidel is 99.9% confident that the ind var is significant ti model
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
  cat(aic1, aic2, residual1, residual2)
  
  
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













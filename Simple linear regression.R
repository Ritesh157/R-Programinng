# Reading customer churn datasets:
customer_churn = read.csv("...\\Customer_Churn.csv")
View(customer_churn)

library("caTools")
set.seed(1)

#splitting the dataset into train and test dataset:
sample<-sample.split(customer_churn$tenure, SplitRatio = 0.7)
train = subset(customer_churn, sample==TRUE)
test = subset(customer_churn, sample==FALSE)

nrow(train)
nrow(test)

# Creating linear model:
model1 = lm(tenure ~ Contract, data = train)
summary(model1)

# Predicting the value:
predicted_values = predict(model1, newdata = test)
View(predicted_values)
head(predicted_values)

# Binding the Actual and predicted values:
final_data<-cbind(Actual = test$tenure, predicted = predicted_values)
View(final_data)
final_data<-as.data.frame(final_data)


# Error:
error = final_data$Actual-final_data$predicted
head(error)

final_data<-cbind(final_data, error)
View(final_data)

# RMSE:
rmse1<-sqrt(mean((final_data$error)^2))
rmse1


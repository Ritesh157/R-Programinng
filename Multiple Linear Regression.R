# Reading customer churn datasets:
customer_churn = read.csv("....\\Customer_Churn.csv")
View(customer_churn)

library("caTools")
set.seed(1)

#splitting the dataset into train and test dataset:
sample<-sample.split(customer_churn$tenure, SplitRatio = 0.75)
train = subset(customer_churn, sample==TRUE)
test = subset(customer_churn, sample==FALSE)

nrow(train)
nrow(test)

# Creating linear model:
mod_multi_linear = lm(MonthlyCharges ~ Dependents+MultipleLines+OnlineSecurity+OnlineBackup+DeviceProtection, data = train)
summary(mod_multi_linear)

# Predicting the value:
predicted_multi_linear = predict(mod_multi_linear, newdata = test)
View(predicted_multi_linear)
head(predicted_multi_linear)

# Binding the actual values & the predicted values:
final_data<-cbind(Actual=test$MonthlyCharges,Predicted=predicted_multi_linear)
View(final_data)
final_data<-as.data.frame(final_data)

# Error:
error<-final_data$Actual-final_data$Predicted
head(error)

final_data<-cbind(final_data, error)
View(final_data)


# RMSE:
rmse1<-sqrt(mean((final_data$error)^2))
rmse1



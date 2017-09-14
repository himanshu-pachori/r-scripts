install.packages('rpart.plot')
install.packages('data.table')
library(rpart)
library(rpart.plot)
library(data.table)

train <- read.csv('C:/Users/hipa0417/Downloads/dataset/predictsign/train.csv')
test <- read.csv('C:/Users/hipa0417/Downloads/dataset/predictsign/test.csv')
submission <- read.csv('C:/Users/hipa0417/Downloads/dataset/predictsign/sample_submission.csv')



str(train)
train$SignFacing..Target. <- sapply(train$SignFacing..Target., function(x) as.numeric(as.factor(x)))
train$DetectedCamera <- sapply(train$DetectedCamera, function(x) as.numeric(as.factor(x)))

test$DetectedCamera <- sapply(test$DetectedCamera, function(x) as.numeric(as.factor(x)))
train_Id <- train$Id 
test_Id <- test$Id

train <- train[-1]
test <- test[-1]

model1 <- rpart(SignFacing..Target. ~ .,data = train, method = 'class')

prediction1 <- predict(model1,test)

prediction1 <- as.data.table(prediction1)

prediction1 <- cbind(test_Id,prediction1)

names(prediction1) <- c('Id','Front','Left','Rear','Right')

write.csv(prediction1,'C:/Users/hipa0417/Downloads/dataset/predictsign/submission1.csv',row.names = F)

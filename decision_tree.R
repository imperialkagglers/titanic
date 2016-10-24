# Training a simple decision tree model
library(rpart)
library(rpart.plot)

raw_train_data <- read.csv('titanic_data/train.csv', header=TRUE)
raw_test_data <- read.csv('titanic_data/test.csv', header=TRUE)

train_data <- raw_train_data
test_data <- raw_test_data
train_data$Pclass <- as.factor(train_data$Pclass)
test_data$Pclass <- as.factor(test_data$Pclass)

dtm <- rpart(Survived~Pclass+Sex+Age+Fare, train_data, method="class")
# rpart.plot(dtm, type=4, extra=101)

p <- predict(dtm, test_data, type="class")


output <- data.frame(test_data$PassengerId, sapply(as.numeric(p), function(x) x-1))
colnames(output) <- c("PassengerId", "Survived")
output$Survived <- as.numeric(output$Survived)

write.csv(output, file="simpledtreeresults.csv", row.names=FALSE)
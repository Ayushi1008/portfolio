# CHECKING CURRENT WORKING DIRECTORY
getwd()

# ---------- ABOUT DATASET -------------
# The data chosen is named abalone, it has been taken from kaggle website.
# Classification algorithms will be performed on this dataset along with 
# regression to find out the nature of relationship between dependent and independent variable.


# OBJECTIVE : Make predictions about the age of the abalone through the rings column in the dataset
# rings column represent the age.
# example : if number of rings are 3 , the age is 3

# LOADING DATA
# stringsAsFactors is set as FALSE because by default the data is read in the form of data frame 
# which in turn reads columns as factors, to prevent conversion of all columns into factor this is done

dataset <- read.csv("/Users/ayushikhullar/Desktop/abalone.csv", stringsAsFactors = FALSE)
#View(dataset)


# DATA PRE-PROCESSING

str(dataset)
# there are 9 variables and 4177 observations in the dataset

# removing 'Sex' column as we do not need it while doing classification
dataset <- dataset[ , -1]
# View(dataset)


# Renaming rings column to age (as it represents age of abalone which we have to predict)
colnames(dataset)[8] = "Age"
colnames(dataset)

# -------------- USING MULTIPLE REGRESSION -----------------------
# TO CHECK RELATIONSHIP OF DEPENDENT AND INDEPENDENT VARIABLE
# AGE(DEPENDENT) HAS LINEAR RELATIONSHIPS WITH ALL INDEPENDENT VARIABLE
regressor <- lm(formula = Age~. , data = dataset)
library(car)
avPlots(regressor)

# checking null values in dataset
sum(is.na(dataset))

# to check if feature scaling is needed

hist(dataset$Length)
# length column is left skewed

hist(dataset$Whole.weight)
# weight column is right skewed

# AS SOME COLUMNS ARE LEFT SKEWED AND SOME RIGHT SKEWED WE NEED FEATURE SCALING FOR THE DATASET
normalise <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

# applying normalisation on columns 1 to 7, excluding last column as it is categorical column
dataset_normalised <- as.data.frame(lapply(dataset[1:7], normalise))

# converting Age column(numeric) into categorical values
summary(dataset$Age)
# making three categories for age :
# 1-10 = young
# 11-20 = adult
# 21-29 = old
View(dataset)
dataset$Age <- cut(dataset$Age, breaks = c(0,10,20,30), labels = c("young", "adult", "old"))
View(dataset)

# cut function will make column into factors along with giving them labels - (0,10],(10,20],(20,30]


# --------------------- IMPLEMENTING KNN ALGORITHM : CLASSIFICATION ---------------------------
set.seed(123)

# DIVIDING THE DATA INTO TRAINING AND TESTING

dataset_train_feature <- dataset_normalised[1:3341, ]
dataset_testing_feature <- dataset_normalised[3342:4177, ]
dataset_train_label <- dataset[1:3341,8]
dataset_test_label <- dataset[3342:4177,8]

# applying the model
library(class)
knn_model <- knn(train = dataset_train_feature, test = dataset_testing_feature, cl= dataset_train_label,
                 k=59)
knn_model
# making confusion matrix
cm <- table(dataset_test_label, knn_model)
cm

# finding accuracy
acc <- sum(diag(cm)) / sum(cm)
print(paste("Accuracy for KNN model in the ratio of 80:20 with value of k as 59 is :", round(acc,2)*100,"%"))


#View(dataset)

# ---------------------- IMPLEMENTING DECISION TREE ALGOROTHM ------------------------
set.seed(1234)
# splitting the dataset 
s<-sample(1:nrow(dataset), 0.9*nrow(dataset))
train <- dataset[s, ]
test <- dataset[-s, ]

# for plot
library(rpart)
tree<-rpart(formula = Age~. , data = train)
library(rpart.plot)
rpart.plot(tree)

# for accuraccy as party package return predictions in type class
# which makes it easy to make confusion matrix
library(party)
dt <- ctree(Age~. , data = train)


p<- predict(dt,test)
p

cm <- table(test$Age, p)
cm
accu <- sum(diag(cm)) / sum(cm)

print(paste("Accuracy for decision tree model is:", round(accu,2)*100,"%"))

 # ---------------------- IMPLEMENTING NAIVE BAYES ALGORITHM-----------------


library(e1071)

# applying the model on testing data
nv_model <- naiveBayes(Age~., data = train)

# making predictions on testing data
pred <- predict(nv_model,test)

# making a confusion matrix
cm <- table(test$Age,pred)
cm

# calculating accuracy
nv_accu <- sum(diag(cm)) / sum(cm)

print(paste("Accuracy for naive bayes model:", round(nv_accu,2)*100,"%"))

# ------------------ IMPLEMENTING SUPPORT VECTOR MACHINE ALGORITHM ----------------------

# taking ther kernel as linear
svm_model <- svm(formula = Age~. ,data = train, type = 'C-classification', kernel = 'linear')
pred <- predict(svm_model, newdata = test)
pred

cm <- table(test$Age, pred)
cm
accur <- sum(diag(cm)) / sum(cm)

print(paste("Accuracy for SVM model with Linear kernel:", round(accur,2)*100,"%"))
# changing the kernel

svm_model <- svm(formula = Age~. ,data = train, type = 'C-classification', kernel = 'radial')
pred2<- predict(svm_model, newdata = test)
pred2

# creating confusion matrix
cm2 <- table(test$Age, pred)
cm2
# finding accuracy
accur2 <- sum(diag(cm)) / sum(cm)

 
print(paste("Accuracy for SVM model with Radial kernel:", round(accur2,2)*100,"%"))











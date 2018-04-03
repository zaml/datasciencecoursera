setwd("~/Desktop/Week 4")

# string manipulation library
library(stringr)

######### DATA LOADING AND CLEANING ######### 

# get features names
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
features <- features$V2 

## ------ Load Training Set ---------------------------------------------

# train y Label
train_Y <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

# read training set
train = readLines("UCI HAR Dataset/train/X_train.txt")

# clean empty spaces
train <- str_replace_all(train, "  ", "\t")
train <- str_replace_all(train, " ", "\t")

# coerce into a data frame
train = as.data.frame(do.call(rbind, strsplit(train, split="\t")), stringsAsFactors=FALSE)
# remove empty variable created when data frame created
train$V1 <- NULL
# assign column names
names(train) = features
# create new column y for the y labels
train$y <- train_Y$V1

## ------ Load Test Set ---------------------------------------------

# test y Label
test_Y <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

# read training set
test = readLines("UCI HAR Dataset/test/X_test.txt")

# clean empty spaces
test <- str_replace_all(test, "  ", "\t")
test <- str_replace_all(test, " ", "\t")

# coerce into a data frame
test = as.data.frame(do.call(rbind, strsplit(test, split="\t")), stringsAsFactors=FALSE)
# remove empty variable created when data frame created
test$V1 <- NULL
# assign column names
names(test) = features
# create new column y for the y labels
test$y <- test_Y$V1


######### DELIVERABLES ######### 

## 1 ------ Merge Data Set ---------------------------------------------

# rbind will join both sets into a single R dataframe
all_data <- rbind(test, train) 

## 2 ------ Mean and Standard Deviation  --------------------------------

# conver dataframe into matrix (to convert to numeric)
all_data_mat = apply(all_data, FUN =  as.numeric, MARGIN = c(1,2))
# recreate it as a dataframe from the Matrix
all_data <- data.frame(all_data_mat)
names(all_data) = features
names(all_data)[is.na(names(all_data))] <- "y"

# 2.1 obtain column means
means <- colMeans(all_data)

# 2.2 obtain standard deviation
std <- apply(all_data, 2, sd)

## 3 ------ descriptive activity names  --------------------------------

# load descriptive labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activity_labels) = c("id","name")
new_labels <- activity_labels[all_data$y, "name"]
all_data$y <- new_labels

## 4 ------ descriptive activity names  --------------------------------
# this was done at the beggining of the data cleaning.
names(all_data)

## 5 ------ independent tidy data set with the average of each variable  --------------------------------
# column 562 is the y categorical label and will be excluded.
all_data_means <- colMeans(all_data[,-562])

# Save Tidy Dataset as CSV (this is a 67Mb file) run this to generate
write.csv(all_data, file = "TidyDataSet.csv")
write.table(all_data, file = "TidyDataSet.txt", row.names = FALSE)



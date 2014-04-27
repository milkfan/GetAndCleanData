#setwd("D:\\Rworkspace\\Getting and Cleaning Data\\peer assignment")
#data source: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

library(plyr)
library(reshape2)

feature <- "./UCI HAR Dataset/features.txt"
feature_name <- read.table(feature, header = FALSE, sep = "\t")
name<-feature_name[,1]
mean<-agrep("mean()", name)
std<-agrep("std()", name)
filter<-sort(unique(c(mean, std)))
separate <- function(n){
    unlist(strsplit(n," "))[2]
}

col <- unlist(lapply(as.vector(name[filter]), FUN=separate))

train <- "./UCI HAR Dataset/train/X_train.txt"
train_data<-read.table(train, header = FALSE)
dim(train_data)
train_data_trim <- train_data[, filter]
dim(train_data_trim)
colnames(train_data_trim)<-col

test <- "./UCI HAR Dataset/test/X_test.txt"
test_data<-read.table(test, header = FALSE)
dim(test_data)
test_data_trim <- test_data[, filter]
dim(test_data_trim)
colnames(test_data_trim)<-col

## add the subject to the data
train_subject <- "./UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.table(train_subject, header = FALSE)
colnames(subject_train)<-c("Subject")
train_data_trim <- cbind(subject_train, train_data_trim)


test_subject <- "./UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.table(test_subject , header = FALSE)
colnames(subject_test)<-c("Subject")
test_data_trim <- cbind(subject_test, test_data_trim)

## label the activity
train_label <- "./UCI HAR Dataset/train/y_train.txt"
label_train <- read.table(train_label, header = FALSE)

f<-factor(label_train[,1])
levels(f) <- list(WALKING = "1", WALKING_UPSTAIRS = "2", WALKING_DOWNSTAIRS = "3", SITTING = "4", STANDING = "5", LAYING = "6")
activity_train <- list(f)
names(activity_train) <- c("Activity") 
train_data_trim <- cbind(train_data_trim, activity_train)

test_label <- "./UCI HAR Dataset/test/y_test.txt"
label_test <- read.table(test_label, header = FALSE)
f<-factor(label_test[,1])
levels(f) <- list(WALKING = "1", WALKING_UPSTAIRS = "2", WALKING_DOWNSTAIRS = "3", SITTING = "4", STANDING = "5", LAYING = "6")
activity_test <- list(f)
names(activity_test) <- c("Activity") 
test_data_trim <- cbind(test_data_trim, activity_test)

## Join train and test data set
data <- rbind(train_data_trim, test_data_trim)
dim(data)
write.table(data, file = "complete_data.txt")

## Melting data frames
dataMelt <- melt(data, id=c("Subject", "Activity"), meausre.vars=col)
head(dataMelt, 3)
tail(dataMelt, 3)
## Casting data frame
subject <- dcast(dataMelt, Subject ~ variable,base::mean)
subject
write.table(subject, file = "subject_data.txt")

Activity <- dcast(dataMelt, Activity ~ variable,base::mean)
Activity 
write.table(Activity , file = "Activity_data.txt")

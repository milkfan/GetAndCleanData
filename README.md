### **Getting and Cleaning Data Project**

*Author: Chen Long*

[Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### According to the instructions, there are five main steps to do:

>* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

After downloading and extract the data, there will be a folder containg all the data files: "UCI HAR Dataset." Put this R script alongside the folder. The first thing to do before running the script in R is to set the work directory to the folder that contains the script and the data folder. Such as:

`setwd("D:\\Rworkspace\\Getting and Cleaning Data\\peer assignment")`

Then it's ready to run the script. It will produce three data files in the form or .txt:
>"complete-data.txt": combining train and test data with proper name for the activity

>"subject-data.txt": average of each measurement for each subject

>"activity-data.txt": average of each measurement for each of the six kinds of activities:

* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING
 
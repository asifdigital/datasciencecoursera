#  title: "run_analysis.R"
#author: "Asif Hameed"
#date: "7/21/2019"
#Course: Getting and Cleaning data, Week4 Assignment

library(dplyr) 

# fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl,destfile = "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
# unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

#load features & load activity lables
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")

#make the column names valid
features[,2]<-gsub("[()-]",".",features[,2])

#load test data 
xTest<-read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE, col.names=features[,2])
yTest<-read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
testSubject<-read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

#load train data
xTrain<-read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE, col.names=features[,2])
yTrain<-read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
trainSubject<-read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)



# Step1 Merges the training and the test sets to create one data set.
X<-rbind(xTest, xTrain)
Y<-rbind(yTest,yTrain)
subjects<-rbind(testSubject,trainSubject)


# Step2 Extracts only the measurements on the mean and standard deviation for each measurement.
selectedFeatures<-grep("*mean*|std*",features[,2], value=TRUE)
X<-select(X,selectedFeatures)

#Step3 Uses descriptive activity names to name the activities in the data set 
colnames(Y)<-"ActivityID"
colnames(subjects)<-"Subjects"
colnames(activityLabels)<-c("ActivityID","Activity")

#Step4 Appropriately labels the data set with descriptive variable names.
X2<-cbind(X,Y,subjects)
X2<-merge(X2,activityLabels,by.x="ActivityID",by.y="ActivityID")

#Step5 From the data set in step 4, creates a second, independent tidy data set with the average
#  of each variable for each activity and each subject
library(reshape2)
X3<-melt(X2,id=c("Activity","Subjects"),measure.vars = selectedFeatures)

#I had to do bit of googling for this one. Essentially what it does is combines 
#the subject with the columns thus give you a clean mean of the function with
#subject(like 2_tBodyAccJer) against activity(row)
X4<-dcast(X3, Activity ~ Subjects + variable, mean)

write.table(X4, file = "./tidydata1.txt", row.names = FALSE, col.names = TRUE) 


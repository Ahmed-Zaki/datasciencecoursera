##0: Download and unzip the dataset
##Dataset file URL
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Download (if doesn't exist) and unzip the file (if not unzipped)
if (!file.exists("SamsungDataset.zip")){download.file(fileURL,"SamsungDataset.zip",mode="wb")}
if (!file.exists("UCI HAR Dataset")){unzip("SamsungDataset.zip")}

##Read data from files
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")

##1: Merge the train and test datasets
## "x" dataset
x_merged <- rbind(X_train, X_test)
## "y" dataset
y_merged <- rbind(y_train, y_test)
## "Subject" dataset
subject_merged <- rbind(subject_train, subject_test)

##2: Extract only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")
## get indices of only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[,2])
## subset the columns and Set the column names
x_mean_std <- x_merged[, mean_and_std_features]
names(x_mean_std) <- features[mean_and_std_features,2]

##3: Use descriptive activity names to name the activities in the dataset.
activities<-read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
## update y values with activity names
y_merged[,1] <- activities[y_merged[,1],2]
names(y_merged)<-"activity"

##4: Appropriately label the dataset with descriptive variable names.
## correct subject column name
names(subject_merged) <- "subject"
# bind all three datasets in a single dataset
complete_data <- cbind(x_mean_std, y_merged, subject_merged)

##5: Create a second, independent tidy dataset with the average of each variable for each activity and each subject.
library(dplyr)
## Group dataset by activity and subject
grouped_data<-group_by(complete_data,activity,subject)
## Get the average for each activity and subject and write the tidy dataset into txt file 
averaged_data<-summarize_each(grouped_data,funs(mean))
write.table(averaged_data, file= "tidy_data.txt", row.names = FALSE)


The run_analysis.R script extracts the average mean and standard deviation of the data set signals for each activity and each subject in an independent tidy data set through the following steps:

**Step 0:** Downloads the data set (if it doesn't exist) from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unzips it

**Step 1:** Reads and merges the train and test data sets

**Step 2:** Extracts only the measurements on the mean and standard deviation for each measurement

**Step 3:** Uses descriptive activity names to name the activities in the data set

**Step 4:** Binds all three data sets in a single data set and appropriately labels the data set with descriptive variable names 

**Step 5:** Creates a second, independent tidy data set with the average of each variable for each activity and each subject and writes it to a txt file

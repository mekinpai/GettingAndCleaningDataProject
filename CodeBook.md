# Original Data Source

Human Activity Recognition Using Smartphones Data Set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Transformation Steps

1. Unzip the downloaded file and load these following files into R global environment (the column names are also assigned):
  1.1 UCI HAR Dataset/features.txt - contains the list of all features.
  1.2 UCI HAR Dataset/activity_labels.txt - contains the activity name for each class label
  1.3 UCI HAR Dataset/test/X_test.txt - test set with the measurements for all features
  1.4 UCI HAR Dataset/test/Y_test.txt - activity labels for the test set
  1.5 UCI HAR Dataset/test/subject_test.txt - contains subjectID of the test set
  1.6 UCI HAR Dataset/train/X_train.txt - training set with the measurements for all features
  1.7 UCI HAR Dataset/train/y_train.txt - activity labels for the training set
  1.8 UCI HAR Dataset/train/subject_train.txt - contains subjectID of the training set

2. Merge the test set and training set together 
  2.1 merge data from 1.3, 1.4, and 1.5 by column together
  2.2 merge data from 1.6, 1.7, and 1.8 by column together
  2.3 merge data from 2.1 and 2.2 by row to get all the test and training set together in one dataset

3. Extract only the measurements on the mean and standard deviation for each measurement.
  3.1 Use data from step 2.3 and extract only the column name that has identification, activity labels, mean(), or std() in its name
  
4. Use descriptive activity names to name the activities in the data set
  4.1 Merge the data from step 3.1 with data from step 1.2 to get the activity names

5. Appropriately labels the data set with descriptive variable names.
  5.1 rearrange the order of the columns if neccessary

6. Creates an independent tidy data set with the average of each variable for each activity and each subject.
  6.1 use the data from step 5.1 to make the summary
  6.2 export the data from step 6.1 to a summaryTidyData.txt file

# summaryTidyData.txt

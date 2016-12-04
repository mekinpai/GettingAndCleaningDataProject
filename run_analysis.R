# Download the file, create the directory if neccessary
if(!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile ="./data/dataset.zip", method = "curl")

# unzip the downloaded file to the working directory
unzip("./data/dataset.zip")

# Read the feature data, assign the column names accordingly 
features <- read.table(file = "./UCI HAR Dataset/features.txt", col.names = c("featureID", "featureName"))

# Read the activity label data, assign the column names accordingly 
activity_labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt"
                              , col.names=c("activity_label", "activity_name"))


# Read the Test data
x_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "./UCI HAR Dataset/test/Y_test.txt", col.names = "activity_label")
subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", col.names = "subjectID")

# assign the column names for the x_test dataset based on the feature data
colnames(x_test) <- features[,2]

# Combine the Test data for each subject
test_data <- cbind(subject_test, y_test, x_test)


# Read the Training data
x_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", col.names = "activity_label")
subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", col.names = "subjectID")

# assign the column names for the x_train dataset based on the feature data
colnames(x_train) <- features[,2]

# combine the Train data for each subject
train_data <- cbind(subject_train, y_train, x_train)

# combine test and train data
all_data <- rbind(test_data, train_data)

# extract only columns that are mean and standard deviation for each measurement (also the subjectID and activity_label).
interested_columns <- grepl('mean\\(\\)', colnames(all_data)) | 
            grepl('std\\(\\)', colnames(all_data)) | 
            grepl('subjectID', colnames(all_data)) | 
            grepl('activity_label', colnames(all_data))
all_data <- all_data[,interested_columns]

# merge with the activity_labels dataset to get descriptive activity names of each activity
all_data <- merge(all_data, activity_labels, by= "activity_label")

# reorder the column to make it more easy to read
all_data <- all_data[, c(2,1,69,3:68)]

# create independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
summaryTidyData <- all_data %>% 
                    group_by (subjectID, activity_label,activity_name) %>%
                    summarise_each(funs(mean))

# sort the data based on subjectID and activity_label
summaryTidyData <- summaryTidyData[order(summaryTidyData$subjectID, summaryTidyData$activity_label),]

# export the data as .txt file without row names
write.table(file="summaryTidyData.txt", summaryTidyData, row.names = FALSE)

# export the data as .csv file without row names
write.csv(file="summaryTidyData.csv", summaryTidyData, row.names = FALSE)

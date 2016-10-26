##Need R script that:
# 1. Merges the training and the test sets to create one
# data set.
# 2. Extracts only the measurements on the mean and standard
# deviation for each measurement.
# 3. Uses descriptive activity names to name the activities
# in the data set
# 4. Appropriately labels the data set with descriptive variable
# names.
# 5. From the data set in step 4, creates a second, independent
# tidy data set with the average of each variable for
# each activity and each subject.

dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, "wearables.zip")
unzip("wearables.zip")

# Sets working directory to folder from unzip: UCI HAR Dataset

setwd("C:/Users/AnnaYuk/Desktop/Getting and cleaning data Coursera/UCI HAR Dataset")

# Reads in all key data, including measurements, activities and
# subjects.

trainData <- read.table("train/X_train.txt")
trainActivities <- read.table("train/y_train.txt")
trainSubjects <- read.table("train/subject_train.txt")

testData <- read.table("test/X_test.txt")
testActivities <- read.table("test/y_test.txt")
testSubjects <- read.table("test/subject_test.txt")

# 1. Binds all train data, then all test data, before merging
# them together.

trainData <- cbind(trainData, trainSubjects, trainActivities)

testData <- cbind(testData, testSubjects, testActivities)

allData <- rbind(trainData, testData)

# 2. Extract only the measurements on the mean and standard
# deviation for each measurement.

# First extracts measurement names from the features doc.

features <- read.table("features.txt",
                       stringsAsFactors = FALSE)

# Then extracts only the measurements on the mean and standard
# deviation for each measurement.
# Creates two separate searches. selectMeanStd has the column
# positions we want to subset.
# meanStdNames has their names, based on value = TRUE for grep.
# Only includes the mean and std followed by () so excludes
# other measures like meanFrequency.

selectMeanStd <- grep("(mean|std)\\(\\)", features$V2)
meanStdNames <- grep("(mean|std)\\(\\)", features$V2,
                     value = TRUE)

dataSub <- allData[, c(selectMeanStd, 562:563)]

# Afterwards renames the columns of dataSub based on chosen
# feature names.

names(dataSub) <- c(meanStdNames, "Subject", "Activity")

# 3. Use descriptive activity names to name the activities
# in the data set.

# Downloads conversion for levels from activity labels doc.
# Converts Activity column to a factor so it's easier to
# replace rows within it.
# Changes labels based on labels document.

ActivityNames <- read.table("activity_labels.txt")

dataSub$Activity <- factor(dataSub$Activity, labels =
                                 ActivityNames$V2)

# 4. Appropriately label the data set with descriptive
# variable names.

# Replaces instances of 't' at beginning with Time
# Replaces 'f' at beginning with Frequency
# Replaces 'Acc' with Acceleration
# Replaces 'Mag' with Magnitude
# Replaces 'BodyBody' with single 'Body'

names(dataSub) <- gsub("^t", "Time", names(dataSub))
names(dataSub) <- gsub("^f", "Frequency", names(dataSub))
names(dataSub) <- gsub("Acc", "Acceleration", names(dataSub))
names(dataSub) <- gsub("Mag", "Magnitude", names(dataSub))
names(dataSub) <- gsub("BodyBody", "Body", names(dataSub))

# 5.From the data set in step 4, create a second, independent
# tidy data set with the average of each variable for
# each activity and each subject.

# Downloads reshape2 library so can use dcast.
# First melts the dataSub to set Subject and Activity as ids.

library(reshape2)

mdata <- melt(dataSub, id=c("Subject","Activity"))

# Casts the melted data, mdata, with Subject + Activity
# as the first part of the formula, against rest of variables.
# For the rest of the variables, calculates their mean.

tidyData <- dcast(mdata, Subject + Activity ~ ..., mean)

# Creates the "tidydata.txt" table with the tidy data set.

write.table(tidyData, file = "tidydata.txt", row.names=FALSE)

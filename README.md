# CourseraTidyData
# Final assignment for Coursera Getting and Cleaning Data Course

## This README is meant to explain how all of the scripts work and how they are connected.

The purpose of this assignment was to demonstrate my ability to collect, work with, and clean a data set.

The final products of the assignment are as follows:

* This README.md document which gives an overview.

* A detailed CodeBook.md that explains where the raw data was taken from, and what was done to it to clean it up.
It also explains all the variables and summaries calculated, along with units, and other relevant information about the raw and clean data.

* An R script, 'run_analysis.R', that does the following:

	0. Takes data from the website 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
	1. Unzips it and merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement.
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names.
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* A final tidy data set, called 'tidydata.txt' was the output of the R script and is also submitted with the assignment in Coursera.

This generated data set should be considered tidy because:
	1. Each variable is in its own column: all the features, or measurement, variables, the subjects and the activities.
	2. Column names are easy to read.
	3. Each observation forms a row, because it is clear each of the 30 subjects performed each of the 6 activities, and the average observation was calculated for each of the 66 measurements with mean() and std().
	4. The table only stores data about one kind of observation, namely the measurements for subjects performing activities with the smartphone.
	5. It is easy to see data for each subject, performing each activity, as it is first grouped by subjects, then activities, then the other 66 measurements.

* Reviewers can easily read the tidydata.txt into R using the following code (taken from David Hood's 'Thoughtfulbloke' blog):


address <- "https://s3.amazonaws.com/coursera-uploads/peer-review/HkJsxW0yEeWEewoyD2Bc5Q/c13a660a9fdad75abb1fb90767d1d3b3/tidydata.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE)
View(data)

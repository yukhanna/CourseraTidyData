# Codebook for tidy data assignment

## This codebook is meant to accompany the tidy data final assignment for the Coursera "Getting and Cleaning Data" course

## This codebook takes data from the Human Activity Recognition Using Smartphones Dataset, Version 1.0.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are
racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent
data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project were obtained from the following website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

(The official citation is: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012)


## Here is a description of the raw data, including its units:
=========================================

It uses data from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial
linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to
label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was
selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width
sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational
and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was
used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## For each raw record it is provided:
======================================

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. (1 through 6)
* An identifier of the subject who carried out the experiment. (1 through 30)

## The raw dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Notes on raw data: 

* Each feature vector is a row on the original text file.


## The records were modified for the tidy data assignment in the following way:
=========================================

* The data was downloaded from this link using download.file: dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

* The data was unzipped using the unzip() function.

* The working directory was set to the folder created from the unzip, UCI Har Dataset, to make it easier to find relevant files

* The data was read in from the Training set ('train/X_train.txt'), which was labeled trainData. This includes the raw feature records 
with time and frequency domain variables for the 21 subjects (70%) in the training data.

* The data was read in from the Training labels ('train/y_train.txt'), which was labeled trainActivities. These are the labels for what each subject
was doing for each observation (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, labeled as 1:6).

* The data was read in from the Training subjects ('train/subject_train.txt'), which was labeled trainSubjects. This identifies the ID numbers of the subjects who performed the activity for each window sample.

* The equivalent data was read in for the test data, which included data on 9 subjects (30%). The equivalent labels were:
testData, testActivities and testSubjects.

* The Training data was then bound to its labels and subjects by columns, to form a full trainData set with 7352 observations and 563 variables, including 561 features (measurements) and the id variables, Subject and Activity.

* The Test data was also bound to its labels and subjects by columns, to form a full testData set with 2947 observations and 563 variables, including 561 features (measurements) and the id variables, Subject and Activity.

* The Test and Training data was merged together by rows to put all the data from all 30 subjects into one data frame, called allData. It included 10299 observations and 563 variables.

* The description of the features, or measurements, was then used to extract only the measurements on the mean and standard deviation for each measurement.

* This was done by reading in the features.txt document included with the raw data and using grep both to locate the needed columns (which ended in mean() or std()) and also used grep to assign them names.

* Using grep to search for mean() and std() prevented other features, or variable names, from getting included, such as meanFrequency.

* selectMeanStd was the name for the needed variable locations, and meanStdNames, the actual variable (column) names. Both were extracted using grep, searching for 'mean()' or 'std()'.

* The data was then subset to only include the Subject, Activity, and mean and standard deviation information. This subset was labeled dataSub.

* The Activity column was modified by using the activity_labels.txt document included with the raw data to change the labels from (1:6) to be more descriptive, showing the actual activities the subjects performed with the smartphone according to the labels guide (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

* The feature, or measurement, names taken from the features.txt document were modified to be more descriptive using gsub.
They were made more descriptive according to the guidelines from coursera, so abbreviations were spelled out and duplicate words (like BodyBody) were removed.
Specifically: 
	* All instances of 't' at the beginning of a variable were replaced with 'Time'
	* All instances of 'f' at the beginning were replaced with 'Frequency'
	* All instances of 'Acc' were replaced with 'Acceleration'
	* All instances of 'Mag' were replaced with 'Magnitude'
	* All instances of 'BodyBody' were replaced with a single 'Body'

* The data set, labeled dataSub was melted using the reshape2 library feature, melt. The id's for the melted data set were set as Subject and Activity.

* The melted data was then cast using dcast, with Subject + Activity as the first part of the formula, against the mean of the rest of the variables (or measurements).

* Finally, a table was written with the write.table setting (row.names = FALSE) to the file 'tidydata.txt'.

* The README files has a description of why the table produced should be considered tidy data.

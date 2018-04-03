# Week 4 - Code Book
this section contains details about how the tidy dataset was created for this course deliverable

## Run_Analysis.R
this file is a single script that loads the training set and test set, as well as other satellite sets to create the tidy dataset. The file itself is self explanatory and contains comments on each line. The generated Tidy dataset was uploaded as TidyDataSet.csv for your reference.

# Script Walkthrough
This script is composed of two main parts: the DATA LOADING AND CLEANING section, and the DELIVERABLES section.

# DATA LOADING AND CLEANING
in this section, the test set and training set are loaded into R and white spaces are removed. The feature names are loaded from the UCI HAR Dataset/features.txt and then they are assigned to both test and train data frames. Consequently, a new variable "y" is created in both test and train dataset from the files UCI HAR Dataset/train/y_train.txt and UCI HAR Dataset/test/y_test.txt. At this point there are two main variables for each set: test and train, which will be merged into a single Tidy set in the next section.

# DELIVERABLES
this section address the 5 requirements as requested by the course test: 

1 - Merges the training and the test sets to create one data set.
2 - Extracts only the measurements on the mean and standard deviation for each measurement.
3 - Uses descriptive activity names to name the activities in the data set
4 - Appropriately labels the data set with descriptive variable names.
5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

in the run_analysis.r each one of the deliverables have been identified with the same numbering.

# 1 - Merges the training and the test sets to create one data set.
this was performed with the rbind command: all_data <- rbind(test, train). the all_data variable will be used in the script and will be used at the end to save the dataframe as CSV

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
to perform such action, the all_data frame is converted into a matrix and later into a dataframe again to cast all columns as numeric. colMeans is applied to the all_data frame to get the desired result. The standard deviation is obtained with the follwing command apply(all_data, 2, sd)

# 3 - descriptive activity names
The labels are loaded from UCI HAR Dataset/activity_labels.txt and replaced in the y column based on the index. 

# 4 - descriptive activity names
When the dataframe was created all columns were assigned from the UCI HAR Dataset/features.txt accordingly. This was performed in the DATA LOADING AND CLEANING section.

# 5 - independent tidy data set with the average of each variable
the colmeans R command was used for this but in this case, the last categorical variable was removed from the dataset (subset) as categorical variables cannot perform any calculations. The column was removed by its index colMeans(all_data[,-562]) 


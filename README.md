# dataproject3

This file describes how the run_analysis.R script works.

## Working Directory

The script expects the working directory to be set to the directory conataining the unzipped data.
For example, if the unzipped "getdata_projectfiles_UCI HAR Dataset" folder is in c:\temp, then the working directory should be set to c:\temp 

## Dependencies & IDE version
The script uses the R library reshape2
RStudio Version 0.99.467 was used.

## Script Function

The script function generally follows the steps laid out in the assignment
The steps are:
# Read in the raw data
# note the filenames for 'y_test' and 'y_train' do not quite match the variable names 'Y_test' and 'Y_train'


# 1. Merges test and train subject, X and Y values
Create "one data set"

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
In the pattern match, the "..-" is to match the "()-" and hence NOT match "meanFreq()-"


# 3. Uses descriptive activity names to name the activities in the data set


# 4. Joins (binds) the tables togther to form a single table
(variable names were created in steps above)


# 5.  creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Finally, save result
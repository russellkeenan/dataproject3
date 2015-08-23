# Read in the raw data
# note the filenames for 'y_test' and 'y_train' do not quite match the variable names 'Y_test' and 'Y_train'

X_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
X_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
Y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
Y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
feature_list <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
activity_labels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")

# 1. Merges test and train subject, X and Y values
all_subject <- setNames(rbind(subject_test, subject_train), "subject")
all_X <- setNames(rbind(X_test, X_train), feature_list[,2])
all_y <- setNames(rbind(Y_test, Y_train), "activity_id")

# Create "one data set"
one_data_set <- cbind(all_subject, all_y, all_X)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#  Note the "..-" is to match the "()-" and hence NOT match "meanFreq()-"
mean_and_std_idxs <- grep("(mean..-)|(std..-)", feature_list[,2])
mean_and_std_measurements <- all_X[, mean_and_std_idxs]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- setNames(activity_labels, c("activity_id", "activity"))
all_y$order <- seq(len = nrow(all_y))
a <- merge(all_y, activity_labels)
activity <- a[order(a$order),"activity"]

# 4. Appropriately labels the data set with descriptive variable names. 
# (variable names created in steps above)
all_data <- cbind(all_subject, activity, mean_and_std_measurements)

# 5.  creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
all_date_melted <- melt(all_data, id=c("subject", "activity"))
mean_data <- dcast(all_date_melted, subject + activity ~ variable, mean)

# Finally, save result
write.table(mean_data, file="step5_tidy_data.txt", row.names = FALSE)

library(dplyr)

#Loads the training data, activities and subjects
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity.Number")

#Loads the test data, activities and subjects
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity.Number")

#Merges training and test data sets
full_data <- rbind(train_data, test_data)
full_subjects <- rbind(train_subjects, test_subjects)
full_activities <- rbind(train_activities, test_activities)

#Obtains the variable names
features_names <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
features_names <- features_names$V2

#Selects only the variables corresponding to mean and std for each measurement
full_data <- select(full_data, grep("mean|std", features_names))

#Give the date frame appropriate names
var_names <- features_names[grep("mean|std", features_names)]
names(full_data) <- var_names

#Create two new variables: Subject and Activity and arranges the data frame by Subject
HAR <- cbind(full_subjects, full_activities, full_data)
HAR <- arrange(HAR, Subject)

#Give Activity appropriate names
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Activity.Number", "Activity"))
HAR <- inner_join(activity_names, HAR, by = "Activity.Number")
HAR <- select(HAR, -Activity.Number)

#Creates a tidy data frame consisting of the average by Subject and Activity
average_HAR <- HAR %>% group_by(Subject, Activity) %>% summarize_all(mean)

#Writes the average_HAR data frame in a file
write.table(average_HAR, "average_HAR.txt", row.names = FALSE)
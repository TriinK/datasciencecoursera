##Programming assignmnt in getting and cleaning data

# Load information to data frames
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
subject_train <- read.table("./UCI HAR Dataset/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/y_test.txt")

#Add appropriate names
names(subject_train) <- "Subject_ID"
names(subject_test) <- "Subject_ID"
names(X_train) <- features$V2
names(X_test) <- features$V2
names(y_train) <- "Activity"
names(y_test) <- "Activity"

# combine files into one dataset
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
combined <- rbind(train, test)

# Extract only mean and standard deviation for each measurement.
ex_features <- grepl("mean|std", names(combined))
X_test = X_test[,ex_features]

#Convert valus to factor
combined$activity <- factor(combined$Activity, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

# Apply mean function to tidy dataset using dcast
library(reshape2)
melt_combined <- melt(combined, id=c("Subject_ID","activity"))
tidy_data   = dcast(melt_combined, Subject_ID + activity ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
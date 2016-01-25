if(!require("dplyr")) {
    install.packages("dplyr")
}
require(dplyr)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
feature_names <- read.table(file="./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(x_train) <- feature_names$V2
names(x_test) <- feature_names$V2
names(subject_train) <- c("subject_id")
names(subject_test) <- c("subject_id")

y_train_activities <- merge(y_train, activity_labels)
y_test_activities <- merge(y_test, activity_labels)

names(y_train_activities) <- c("activity_id", "activity_label")
names(y_test_activities) <- c("activity_id", "activity_label")

training_data <- cbind(subject_train, y_train_activities, x_train)
test_data <- cbind(subject_test, y_test_activities, x_test)
all_data <- rbind(training_data, test_data)
all_data_mean_std <- all_data[,c(1,2,3, grep("mean|std", names(all_data)))]

grouped <- group_by(all_data_mean_std, activity_label, activity_id, subject_id)
summarised <- summarise_each(grouped, funs(mean))
ordered <- arrange(summarised, activity_id, subject_id)

write.table(ordered, file="tidy.txt", row.names = FALSE)


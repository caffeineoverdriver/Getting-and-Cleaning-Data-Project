#run_analysis.R
#extracts mean and standard deviation data from larger data set, then averages these variables by subject and activity ID, and stored this tidy dataset in a new
#output file.

#load dplyr package
library(dplyr)

#load in raw data
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")

#load in "features" to capture the name of each variable
features <- read.table("./UCI HAR Dataset/features.txt")

#get activity and subject IDs for test and training
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#rename columns for simplicity
activity_test <- rename(activity_test, "activity" = V1)
activity_train <- rename(activity_train, "activity" = V1)
subject_test <- rename(subject_test, "subject" = V1)
subject_train <- rename(subject_train, "subject" = V1)

comb_act <- rbind(activity_test, activity_train)
comb_subj <- rbind(subject_test, subject_train)

#convert to character
features$V2 <- as.character(features$V2)

#contains column numbers and names to keep to eliminate duplicates!
to_keep <- features %>% filter(grepl("mean|std", V2)) %>% filter(!grepl("Freq", V2))

#filter out to only desired columns
test_data <- test_data[,to_keep$V1]
train_data <- train_data[,to_keep$V1]

#merge datasets
combined_data <- rbind(test_data, train_data)

#rename columns
combined_data <- combined_data %>% 'colnames<-'(to_keep$V2)

#add on subject and activity ID's
combined_data <- cbind(combined_data, c(comb_subj, comb_act))

#cast to character
combined_data$activity <- as.character(combined_data$activity)

#replace with descriptive name
combined_data$activity <- recode(combined_data$activity, "1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING")

#in a new dataframe, group by subject and then by activity, and take the average of the remaining columns
final_data <- combined_data %>% group_by(subject, activity) %>% summarize_at(names(combined_data[,1:66]), mean)

#write to file
write.table(final_data, "./Tidy Data/tidy_data.txt", sep= "\t", row.names = FALSE)

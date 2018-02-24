-------------------------
# clear objects from the environment.
rm(list=ls())

-------------------------

setwd("C:/Users/n0258303/Documents/1.0 Personal Stuff/R Directory")

-------------------------

# run_analysis

# get the file url
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# check if "tracker_data" file exists. If not, create a new directory and download files.
tracker_dir <- "./tracker_data"
if(!file.exists(tracker_dir)){
  dir.create("./tracker_data") 
  new_dir <- "./tracker_data"
  zip_name <- list.files("./tracker_data")[1]
  zipfile <- paste("./tracker_data/", zip_name, sep = "")
  # get the names of the file in the zip archive
  fname <- unzip(zipfile, list=TRUE)
  table_name <- c(fname[[1]][1:2], fname[[1]][16:18], fname[[1]][30:32])
  # create the placeholder file
  tracker_files = tempfile(tmpdir=new_dir, fileext=".zip")
  # unzip the file to the new directory
  unzip(tracker_files, files=table_name, exdir=new_dir, overwrite=TRUE)
  # download into the placeholder file
  download.file(data_url, tracker_files)
}

# create a vector containing the variable names for each txt file. This will become our column labels.
feat_list <- read.table("./tracker_data/UCI Har Dataset/features.txt")
feat_names <- feat_list[ , 2]

# turn "X_test" file into data tables with "features.txt" objects as column names.
x_test <- read.table("./tracker_data/UCI HAR Dataset/test/X_test.txt")
# "y_test" is the activity identifier list.
y_test <- read.table("./tracker_data/UCI HAR Dataset/test/y_test.txt")
# "sub_test" is the subject identifier list for test.
sub_test <- read.table("./tracker_data/UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./tracker_data/UCI HAR Dataset/train/x_train.txt")
# "y_train" is the activity identifier list.
y_train <- read.table("./tracker_data/UCI HAR Dataset/train/y_train.txt")
# "sub_train" is the subject identifier list for train.
sub_train <- read.table("./tracker_data/UCI HAR Dataset/train/subject_train.txt")

# merge x and y test/training data
full_data <- rbind(x_train, x_test)
colnames(full_data) <- feat_names
full_activity <- rbind(y_train, y_test)
colnames(full_activity) <- "activity"
full_sub <- rbind(sub_train, sub_test)
colnames(full_sub) <- "subject"
act_names <- full_activity
colnames(act_names) <- "act_names"
comp_data <- cbind(full_sub, full_activity, full_data)

# extract only columns with "subject", "activity", "mean" or "std" in the name.
subject <- comp_data[ , "subject"]
activity <- comp_data[ , "activity"]
mean_cols <- grepl("mean", names(comp_data))
std_cols <- grepl("std", names(comp_data))
comp_cols <- mean_cols | std_cols
mean_std_frame <- comp_data[ , comp_cols]
comp_frame <- cbind(subject, activity, act_names, mean_std_frame)

# turn off warnings
options(warn = -1)

# calculate the average of each variable for each activity and each subject.
sub_group <- aggregate(comp_frame, by=list(activity, subject), FUN = mean)
small_group <- sub_group[ , 3:length(names(sub_group))]
for(i in 1:length(sub_group$act_names)){
  if(small_group[i, "act_names"] == 1){
    small_group[i, "act_names"] <- "walking"
  }else if(small_group[i, "act_names"] == 2){
    small_group[i, "act_names"] <- "walking_upstairs"
  }else if(small_group[i, "act_names"] == 3){
    small_group[i, "act_names"] <- "walking_downstairs"
  }else if(small_group[i, "act_names"] == 4){
    small_group[i, "act_names"] <- "sitting"
  }else if(small_group[i, "act_names"] == 5){
    small_group[i, "act_names"] <- "standing"
  }else if(small_group[i, "act_names"] == 6){
    small_group[i, "act_names"] <- "laying"
  }
}

# turn warnings back on
options(warn = 0)

final_data <- small_group

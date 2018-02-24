# Coursera-Getting-and-Cleaning-Data-course-project
Course project for the "Getting and Cleaning Data" course on Coursera.

=========================================

The source data for this project is described in the following paragraph from the course website:

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


=========================================

This repository includes the following files:

- 'README.txt': This file, which provides an overview of the project and other files contained in the repository.

- 'code_book.txt': A list of variables output from the run_analysis.R script and contained in 'tidy_data.xlsx'.

- 'run_analysis.R': The R script that takes the input data and creates the data set.

- 'tidy_data.csv': A csv file of the data output from the run_analysis.R script.


=========================================

The R script called run_analysis.R does the following:

- Looks in the current directory for a file named "tracker_data". If it does not exist, one is created and the source data is added.

- Merges the training and the test sets to create one data set.

- Extracts only the measurements on the mean and standard deviation for each measurement.

- Uses descriptive activity names to name the activities in the data set.

- Appropriately labels the data set with descriptive variable names.

- From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and each subject.

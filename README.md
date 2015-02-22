==================================================================
Human Activity Recognition Using Smartphones Dataset Analysis
in Coursera Getting and Cleaning Data Assignment 
Version 1.0

Overview
==================================================================
The final dataset har_analysis is a clean data representation of the "Human Activity Recognition Using Smartphones Data Set"" which can be obtained from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Details of the original experiment can be found at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The clean data representation har_analysis was obtained by  

- Merging the training and the test sets to create one data set.

  input data set files
  
  'train/X_train.txt': Training set.
  
  'test/X_test.txt': Test set.
  
  'train/subject_train.txt': identifies the subject who performed the activity
  
  'test/subject_test.txt': identifies the subject who performed the activity
  
  'train/y_train.txt': activity Id for the observation
  
  'test/y_test.txt': activity Id for the obseration
   
- Extracting only the measurements on the mean and standard deviation for each measurement. 

  relevant reference files
  
  'features.txt': List of all features.
 
  Used the features.txt file to identify the column names with std or mean in them and used
  their column numbers to extract the fields of interest from the input data sets 

- Using descriptive activity names to name the activities in the data set

  relevant reference files
  
  'activity_labels.txt': Links the class labels with their activity name.
  
  'train/y_train.txt': activity Id for the observation
  
  'test/y_test.txt': activity Id for the obseration
  
  Used the activity id number from the y_*.txt files to get the descrpitive label of the activity from activity_labels.txt

- Appropriately labeling the data set with descriptive variable names. 

  relevant reference files
  
  'features.txt': List of all features.

  Not being a subject matter expert I used the names given from features.txt file removing punctutions such as - and () and upper casing Mean and Std to help them to stand out

To generate har_analysis
========================
- install R packages

  data.table
  reshape2

- extract the HAR data set
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

- save run_analysis.R into the same directory that the UCI HAR Dataset exists in

- To run 

  source('~/run_analysis.R')


The dataset includes the following files:
=========================================

- 'README.txt'

- 'har_analysis': cleaned data set

- 'har_analysis_cookbook.txt'

- 'har_analysistidy': the mean of all features in har_analysis grouped by subject and activity 

- 'run_analysis.R': to generate har_analysis and har_analysistidy

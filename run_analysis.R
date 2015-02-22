#
# generates har_analysis and har_analysistidy data sets for Coursera Assignment
# 
# Required datasets
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Further details in readme.txt and har_analysis_cookbook.txt 
#

# place and run the script from the directory level that the UCI HAR Dataset exists in  
setwd("./UCI HAR Dataset")

# run from the ./UCI HAR Dataset
# libraries needed
library(data.table)
library(reshape2)

# load up the features column numbers and the column names that we are interested in.
# For now that is any column name with mean or std in its name
loadFeatures <-function() {
    features <- read.table("features.txt")
    colnames(features) <- c("colNum","name")
    featOfIntTbl <- features[grepl("mean|std",features$name,ignore.case=TRUE),]
    # remove junk from the column names
    featOfIntTbl$name <- gsub("[[:punct:]]", "", featOfIntTbl$name)
    featOfIntTbl$name <- gsub("mean", "Mean", featOfIntTbl$name)
    featOfIntTbl$name <- gsub("std", "Std", featOfIntTbl$name)    
    featOfIntTbl 
}

# load up the activities id and their activity name
loadActivity <-function() {
    activityMapTbl <- read.table("activity_labels.txt")
    colnames(activityMapTbl) <- c("activityId","activity")
    activityMapTbl
}

# load up the test data from a directory, pulling out the columns we are interested in 
# and merge in the subject and activity. 
#
# Not being a subject matter expert we use the column names from the features with () 
# removed as desciptive names for the variables 
#
loadData <- function(dirName,featOfIntTbl,activityMapTbl) {
    ds <- read.table(paste("./",dirName,"/","X_",dirName,".txt",sep=""))
    ds <- ds[,c(featOfIntTbl$colNum)]
    colnames(ds) <- featOfIntTbl$name
    subject <- read.table(paste("./",dirName,"/","subject_",dirName,".txt",sep=""))
    colnames(subject) <- c("subject")
    activity <- read.table(paste("./",dirName,"/","y_",dirName,".txt",sep=""))
    colnames(activity) <- c("activityId")
    activity$order <-1:nrow(activity)
    activity<-merge(activity,activityMapTbl,all=TRUE,sort=FALSE)
    activity<-activity[order(activity$order),-2:-1]
    cbind(ds,subject,activity) 
}

# generate the data set from test and train data for all features we are interested in
cleanData <- function(featOfIntTbl,activityMapTbl) { 
    rbind(loadData("train",featOfIntTbl,activityMapTbl),loadData("test",featOfIntTbl,activityMapTbl))
}

# generate a tidy data set getting the mean for all features of interest grouped by activity and subject
tidyData <-function(ds,featOfIntTbl) {
    dsmelt <- melt(ds,id=c("activity","subject"),measure.vars=featOfIntTbl$name)
    tidyds <- dcast(dsmelt,activity+subject~variable,mean)
    colnames(tidyds)[3:ncol(tidyds)] <- paste("AvgOf-",colnames(tidyds)[3:ncol(tidyds)],sep="")    
    tidyds
}
 
# load up mapping tables
featOfIntTbl <-loadFeatures()
activityMapTbl <-loadActivity()

# get a clean data set with subject,activity, mean and standard deviation
har_analysis<-cleanData(featOfIntTbl,activityMapTbl)

# get averages of the clean data set and write to disk
har_analysistidy <- tidyData(har_analysis,featOfIntTbl)
write.table(har_analysistidy,"../har_analysistidy.txt",row.name=FALSE)

setwd("../")

run_analysis <- function(datadir="./") {

library("dplyr")


# set working dir to location of unzipped data
#setwd("/Users/anrao/Documents/class/cleaningdata/uci_har_dataset/")
setwd(datadir)


# We need to read in 3 files for test and train modes.
# 3 types are X_(test or train) which has measurements for different workouts.
# Y has list of diffent activities performed for all the different measurements
# done in X
# subject has list of subject id's between 1-30 who have been measured.


# read test data from 3 set of files, each creates a data frame
print ("read test data")
xtest=read.table("test/X_test.txt")
ytest=read.table("test/y_test.txt")
subjecttest=read.table("test/subject_test.txt")

# read training data  from 3 set of files, each creates a data frame
print ("read training data")
xtrain=read.table("train/X_train.txt")
ytrain=read.table("train/y_train.txt")
subjecttrain=read.table("train/subject_train.txt")

# from dim command we can see that both x_test and x_train are same set of
# columns with same set of headers

# y and subject is just 1 column each so easy  understand

# colnames for X data
features=read.table("features.txt")

# activity table, set of activities performed (havnt used)
activity=read.table("activity_labels.txt")

# add  colnames to X data
colnames(xtest)<- features[,2]
colnames(xtrain)<- features[,2]

# add colname to Y data
colnames(ytest)<- c("Activity")
colnames(ytrain)<-c("Activity")


# add colnames to activities table
colnames(activity)<-c("ID", "Activity")


# add colnames to subject table
colnames(subjecttest)<-c("Subject")
colnames(subjecttrain)<-c("Subject")

# eliminate duplicate column names by adding suffix to dups
xtest<-xtest[,]
xtrain<-xtrain[,]

# we are interested only in mean and std columns
# filtering out rest of the columns
# in total we end up getting 66 columns (33 for mean and std each)


## select mean and std columns from train and test data
print ("select only columns mean and std")
xtest <- select(xtest, contains("-mean()"), contains("-std()"))
xtrain <- select(xtrain, contains("-mean()"), contains("-std()"))



# now we can merge 3 columns of test and train

# merge columns of test data
print ("build one single test and training data table")
alltest <-cbind(subjecttest, ytest)
alltest <-cbind(alltest, xtest)

# merge columns of train data
alltrain <-cbind(subjecttrain, ytrain)
alltrain <-cbind(alltrain, xtrain)

# merge train and test data to create one big table of data points
print ("merge test and train data")
alldata <-rbind(alltrain, alltest)

# tidy the colnames of alldata and create tidysummary
# dplyr fails if we have special characters like "-" and "()"
# so we need to search and replace them

print ("tidy data")
# get column names
curcolnames <-colnames(alldata)

# remove all special chars
curcolnames<-gsub("[[:punct:]]", "", curcolnames)

# rename to make columns readable
curcolnames<-gsub("mean", "Mean", curcolnames)
curcolnames<-gsub("std", "Std", curcolnames)

tidysummary<- alldata
#update column names of alldata
colnames(tidysummary) <-curcolnames

# group_by activity and subject, summarize callculating mean of
# each of the columns for each activity and subject

print ("generate summaries calculate mean for each of column")
summary_data <-  summarize_each_(group_by(tidysummary, Activity, Subject),
            funs(mean), 
            names(tidysummary))
        
print ("write summary to file")
write.table(summary_data, "final_summary.txt", row.name = FALSE)
}


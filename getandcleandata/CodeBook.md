This file has details about what run_anaylsis does and set of variables used
to transform the data and calculate final summary.


List of variable discriptions:
==============================

Following data frames used to read test data 
xtest: has details about all measurements done during workouts
ytest: single columns listing different kind of activities performed
subjecttest: has list of subjects doing different activities
	identified by id 1-30

Corresponding versions of data for training are:
xtrain, ytrain and subjecttrain

features: column names for all the X data

activity= set of activities performed , a total of 6 activities 
	1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS
	4 SITTING 5 STANDING 6 LAYING

alltest:  is the DF which has all test columns  merged col wise
alltrain:  is the DF which has all trian columns  merged col wise
alldata:  is the DF which is merged DF of test and train rowsise.

 In order to apply dplyr to tidy the data, we need to rename some of
colnames so that special charcaters are removed.

curcolnames: is the list which has tidy colnames 

tidysummary: is the DF which has tidy column names curcolnames

summary_data: is the DF which has list of mean's of all columns
grouped by activity and subject.

final_summary.txt: summary_data is written to this file.


Set of steps done to get final_summary:

1. read test and train data into relevant DF variables
xtest,ytest,subjecttest
xtrain,ytrain,subjecttrain

2. apply column names to X data from features.txt


3 add column name "Activity" to Y data and "Subject" to subject table.

4. eliminate duplicate column names  in xtrain/xtest table by adding suffix to dups

5. filter out mean and std from X df's.
(in total we end up getting 66 columns (33 for mean and std each))
6.  merge 3 columns of test and train(column wise)
(x,y and subject)


7. rowwise merge test and train data to get complete data alldata
alldata <-rbind(alltrain, alltest)

8.  tidy the colnames of alldata and create tidysummary
dplyr fails if we have special characters like "-" and "()"
so we need to search and replace them


9. apply tidy column names to tidydata
(using gsub function remove "-", "()" and rename mean tyo Mean etc


10. run summary on tidy data of means of all olumns grouped by activity
and subject. result saved in summary_data

11. write summary_data to final_summary.txt file.
}


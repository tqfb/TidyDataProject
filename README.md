TidyDataProject
===============

This code pulls in and tidies test data from the "Human Activity Recognition Using Smartphones Dataset" by the following authors:

==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

## Assumptions
The run analysis.R script assumes that the test data is at the root of the working directory.  i.e., there is a dir for test, another for train and at least the text files features.txt and activity_labels.txt at the root.

## Read in the test and training data
The script first reads in the test and training data, and appends the subject and activity id fields to each.  It then combines the two data sets into a single data set to be processed (full_data).

## Import descriptive names for activities and column headers
The script then reads in the activity names and column headers to be used in the final data set and creates a vector of column headers to be applied to the full_data set.

## Parse out data we are interested in (means, standard deviations)
Since we are only interested in mean and standard deviation data, we split those columns from the full data set for further work (split_data).

We then replace activity id with an actual descriptive activity name and melt the data set and get rid of data we are not interested in.  We end up with the resultant data set md_test, which has only the data we are interested in.

## Group, aggregate and spread the data into a final tidy data set
Finally, we group the data and apply the mean function, to display only the mean of each of the readings for individual acitivity/participant combination.  Ignoring NAs which are irrelevant to the final result, we select the data we want, rename the columns with appropriate values and spread the result to get our final tidy data set "finaladd".


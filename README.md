# "Getting and Cleaning Data" course project cook book

This is a repository for the final peer assesment project of coursera course "Getting and Cleaning Data with R".

## File download

Please download the file from storage - "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". Unzip it to any folder on your PC. Run R, and set work directory on folder with unziped data.

## Setting up working directory

Line 2 sets the working directory. You can modify it for previous step.
In line 51 code will create file (tidy_data.txt) with result data. Code will be created in some folder.

## Reading in from dataset

In lines 7 - 13 the script performs a series of read.table operations and creat data frames for the files. Files used in the script are:
* test/X_test.txt
* test/y_test.txt
* subject_test.txt
* x_train_.txt
* y_train_.txt
* subject_train_.txt

Other files will be ignored.

## Merging data

In lines 16 - 22 you can see mearging of data frames. 

## Reading in the column names

Lines 24 - 28 are used to read in feature names and activity labels. Two objects are created:

* labels - data.frame with labels corresponding to activity ids;
* names - data.frame with column names;

## Manipulating column names with regular expressions

Code in lines 30-34 prepare names for sure it's safe for use.

## Substituting activity indexes for character label

In line 37 there is merge operation on data object which in effect produces additional column for each row - the column with label written as charaters.
In line 38 script removes the column with indices.

## Assiging column names

In lines 41 - 44 script prepares column names, adding a one for "subject" in front of xNames nad the one for "activity_label" as a last entry. Such prepared object - names$V2 (as we need only a list of column names) is used to populate names of labeledDF.

## Extraction of columns conveying mean and std

Line 47 extracts only these columns from labeledDF that have "mean" or "std" or "activity_label" or "subejct" as a part of their names. This is according to project requirements. Script behaves case sensitive here, and columns with "Mean" will not be included. This is my choice, as "angle()" features do not seem to be exactly means or standard deviations.

## Aggregation of the data to final tidy form

Line 50 produces result.

## Adjusting naming of the final data.frame column names

In lines 53 - 55 script rename columns.

## Saving files and cleanup

In line 58 you can see saving of results as table to "tidy_data.txt".

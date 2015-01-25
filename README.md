# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the script code

Once you have made sure that your initial settings are in place you can run the code to generate the tidy data set by sourcing the run_analysis.R file

```
source("run_analysis.R")
```

## Output file

After you run the code a file called "UCI_HAR_tinydata.txt" will be created with the new tidy dataset in your working directory
You can check that from R using:

```
dir()
```

## Dependencies

run_analysis.R file will help you to install the dependencies automatically. It depends on **dplyr**.


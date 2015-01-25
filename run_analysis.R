# Check for libraries
if (!"dplyr" %in% installed.packages()) install.packages("dplyr")
# Import libraries
library(dplyr)

# Download and unzip the data
if (!file.exists("UCI HAR Dataset")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile="UCI_HAR_data.zip"
    message("Downloading data")
    download.file(fileURL, destfile=zipfile)
    unzip(zipfile)
}

# Read into R the common descriptions data files
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("activity_id","activity_label"))
measurements_labels <- c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X"
                         , "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tBodyAcc-mad()-X", "tBodyAcc-mad()-Y", "tBodyAcc-mad()-Z", "tBodyAcc-max()-X"
                         , "tBodyAcc-max()-Y", "tBodyAcc-max()-Z", "tBodyAcc-min()-X", "tBodyAcc-min()-Y", "tBodyAcc-min()-Z", "tBodyAcc-sma()"
                         , "tBodyAcc-energy()-X", "tBodyAcc-energy()-Y", "tBodyAcc-energy()-Z", "tBodyAcc-iqr()-X", "tBodyAcc-iqr()-Y"
                         , "tBodyAcc-iqr()-Z", "tBodyAcc-entropy()-X", "tBodyAcc-entropy()-Y", "tBodyAcc-entropy()-Z", "tBodyAcc-arCoeff()-X1"
                         , "tBodyAcc-arCoeff()-X2", "tBodyAcc-arCoeff()-X3", "tBodyAcc-arCoeff()-X4", "tBodyAcc-arCoeff()-Y1"
                         , "tBodyAcc-arCoeff()-Y2", "tBodyAcc-arCoeff()-Y3", "tBodyAcc-arCoeff()-Y4", "tBodyAcc-arCoeff()-Z1"
                         , "tBodyAcc-arCoeff()-Z2", "tBodyAcc-arCoeff()-Z3", "tBodyAcc-arCoeff()-Z4", "tBodyAcc-correlation()-XY"
                         , "tBodyAcc-correlation()-XZ", "tBodyAcc-correlation()-YZ", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y"
                         , "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tGravityAcc-mad()-X"
                         , "tGravityAcc-mad()-Y", "tGravityAcc-mad()-Z", "tGravityAcc-max()-X", "tGravityAcc-max()-Y", "tGravityAcc-max()-Z"
                         , "tGravityAcc-min()-X", "tGravityAcc-min()-Y", "tGravityAcc-min()-Z", "tGravityAcc-sma()", "tGravityAcc-energy()-X"
                         , "tGravityAcc-energy()-Y", "tGravityAcc-energy()-Z", "tGravityAcc-iqr()-X", "tGravityAcc-iqr()-Y", "tGravityAcc-iqr()-Z"
                         , "tGravityAcc-entropy()-X", "tGravityAcc-entropy()-Y", "tGravityAcc-entropy()-Z", "tGravityAcc-arCoeff()-X1"
                         , "tGravityAcc-arCoeff()-X2", "tGravityAcc-arCoeff()-X3", "tGravityAcc-arCoeff()-X4", "tGravityAcc-arCoeff()-Y1"
                         , "tGravityAcc-arCoeff()-Y2", "tGravityAcc-arCoeff()-Y3", "tGravityAcc-arCoeff()-Y4", "tGravityAcc-arCoeff()-Z1"
                         , "tGravityAcc-arCoeff()-Z2", "tGravityAcc-arCoeff()-Z3", "tGravityAcc-arCoeff()-Z4", "tGravityAcc-correlation()-XY"
                         , "tGravityAcc-correlation()-XZ", "tGravityAcc-correlation()-YZ", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y"
                         , "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyAccJerk-mad()-X"
                         , "tBodyAccJerk-mad()-Y", "tBodyAccJerk-mad()-Z", "tBodyAccJerk-max()-X", "tBodyAccJerk-max()-Y", "tBodyAccJerk-max()-Z"
                         , "tBodyAccJerk-min()-X", "tBodyAccJerk-min()-Y", "tBodyAccJerk-min()-Z", "tBodyAccJerk-sma()", "tBodyAccJerk-energy()-X"
                         , "tBodyAccJerk-energy()-Y", "tBodyAccJerk-energy()-Z", "tBodyAccJerk-iqr()-X", "tBodyAccJerk-iqr()-Y"
                         , "tBodyAccJerk-iqr()-Z", "tBodyAccJerk-entropy()-X", "tBodyAccJerk-entropy()-Y", "tBodyAccJerk-entropy()-Z"
                         , "tBodyAccJerk-arCoeff()-X1", "tBodyAccJerk-arCoeff()-X2", "tBodyAccJerk-arCoeff()-X3", "tBodyAccJerk-arCoeff()-X4"
                         , "tBodyAccJerk-arCoeff()-Y1", "tBodyAccJerk-arCoeff()-Y2", "tBodyAccJerk-arCoeff()-Y3", "tBodyAccJerk-arCoeff()-Y4"
                         , "tBodyAccJerk-arCoeff()-Z1", "tBodyAccJerk-arCoeff()-Z2", "tBodyAccJerk-arCoeff()-Z3", "tBodyAccJerk-arCoeff()-Z4"
                         , "tBodyAccJerk-correlation()-XY", "tBodyAccJerk-correlation()-XZ", "tBodyAccJerk-correlation()-YZ", "tBodyGyro-mean()-X"
                         , "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z"
                         , "tBodyGyro-mad()-X", "tBodyGyro-mad()-Y", "tBodyGyro-mad()-Z", "tBodyGyro-max()-X", "tBodyGyro-max()-Y"
                         , "tBodyGyro-max()-Z", "tBodyGyro-min()-X", "tBodyGyro-min()-Y", "tBodyGyro-min()-Z", "tBodyGyro-sma()"
                         , "tBodyGyro-energy()-X", "tBodyGyro-energy()-Y", "tBodyGyro-energy()-Z", "tBodyGyro-iqr()-X", "tBodyGyro-iqr()-Y"
                         , "tBodyGyro-iqr()-Z", "tBodyGyro-entropy()-X", "tBodyGyro-entropy()-Y", "tBodyGyro-entropy()-Z", "tBodyGyro-arCoeff()-X1"
                         , "tBodyGyro-arCoeff()-X2", "tBodyGyro-arCoeff()-X3", "tBodyGyro-arCoeff()-X4", "tBodyGyro-arCoeff()-Y1"
                         , "tBodyGyro-arCoeff()-Y2", "tBodyGyro-arCoeff()-Y3", "tBodyGyro-arCoeff()-Y4", "tBodyGyro-arCoeff()-Z1"
                         , "tBodyGyro-arCoeff()-Z2", "tBodyGyro-arCoeff()-Z3", "tBodyGyro-arCoeff()-Z4", "tBodyGyro-correlation()-XY"
                         , "tBodyGyro-correlation()-XZ", "tBodyGyro-correlation()-YZ", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y"
                         , "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z"
                         , "tBodyGyroJerk-mad()-X", "tBodyGyroJerk-mad()-Y", "tBodyGyroJerk-mad()-Z", "tBodyGyroJerk-max()-X"
                         , "tBodyGyroJerk-max()-Y", "tBodyGyroJerk-max()-Z", "tBodyGyroJerk-min()-X", "tBodyGyroJerk-min()-Y"
                         , "tBodyGyroJerk-min()-Z", "tBodyGyroJerk-sma()", "tBodyGyroJerk-energy()-X", "tBodyGyroJerk-energy()-Y"
                         , "tBodyGyroJerk-energy()-Z", "tBodyGyroJerk-iqr()-X", "tBodyGyroJerk-iqr()-Y", "tBodyGyroJerk-iqr()-Z"
                         , "tBodyGyroJerk-entropy()-X", "tBodyGyroJerk-entropy()-Y", "tBodyGyroJerk-entropy()-Z", "tBodyGyroJerk-arCoeff()-X1"
                         , "tBodyGyroJerk-arCoeff()-X2", "tBodyGyroJerk-arCoeff()-X3", "tBodyGyroJerk-arCoeff()-X4", "tBodyGyroJerk-arCoeff()-Y1"
                         , "tBodyGyroJerk-arCoeff()-Y2", "tBodyGyroJerk-arCoeff()-Y3", "tBodyGyroJerk-arCoeff()-Y4", "tBodyGyroJerk-arCoeff()-Z1"
                         , "tBodyGyroJerk-arCoeff()-Z2", "tBodyGyroJerk-arCoeff()-Z3", "tBodyGyroJerk-arCoeff()-Z4"
                         , "tBodyGyroJerk-correlation()-XY", "tBodyGyroJerk-correlation()-XZ", "tBodyGyroJerk-correlation()-YZ"
                         , "tBodyAccMag-mean()", "tBodyAccMag-std()", "tBodyAccMag-mad()", "tBodyAccMag-max()", "tBodyAccMag-min()"
                         , "tBodyAccMag-sma()", "tBodyAccMag-energy()", "tBodyAccMag-iqr()", "tBodyAccMag-entropy()", "tBodyAccMag-arCoeff()1"
                         , "tBodyAccMag-arCoeff()2", "tBodyAccMag-arCoeff()3", "tBodyAccMag-arCoeff()4", "tGravityAccMag-mean()"
                         , "tGravityAccMag-std()", "tGravityAccMag-mad()", "tGravityAccMag-max()", "tGravityAccMag-min()", "tGravityAccMag-sma()"
                         , "tGravityAccMag-energy()", "tGravityAccMag-iqr()", "tGravityAccMag-entropy()", "tGravityAccMag-arCoeff()1"
                         , "tGravityAccMag-arCoeff()2", "tGravityAccMag-arCoeff()3", "tGravityAccMag-arCoeff()4", "tBodyAccJerkMag-mean()"
                         , "tBodyAccJerkMag-std()", "tBodyAccJerkMag-mad()", "tBodyAccJerkMag-max()", "tBodyAccJerkMag-min()"
                         , "tBodyAccJerkMag-sma()", "tBodyAccJerkMag-energy()", "tBodyAccJerkMag-iqr()", "tBodyAccJerkMag-entropy()"
                         , "tBodyAccJerkMag-arCoeff()1", "tBodyAccJerkMag-arCoeff()2", "tBodyAccJerkMag-arCoeff()3", "tBodyAccJerkMag-arCoeff()4"
                         , "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroMag-mad()", "tBodyGyroMag-max()", "tBodyGyroMag-min()"
                         , "tBodyGyroMag-sma()", "tBodyGyroMag-energy()", "tBodyGyroMag-iqr()", "tBodyGyroMag-entropy()"
                         , "tBodyGyroMag-arCoeff()1", "tBodyGyroMag-arCoeff()2", "tBodyGyroMag-arCoeff()3", "tBodyGyroMag-arCoeff()4"
                         , "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "tBodyGyroJerkMag-mad()", "tBodyGyroJerkMag-max()"
                         , "tBodyGyroJerkMag-min()", "tBodyGyroJerkMag-sma()", "tBodyGyroJerkMag-energy()", "tBodyGyroJerkMag-iqr()"
                         , "tBodyGyroJerkMag-entropy()", "tBodyGyroJerkMag-arCoeff()1", "tBodyGyroJerkMag-arCoeff()2"
                         , "tBodyGyroJerkMag-arCoeff()3", "tBodyGyroJerkMag-arCoeff()4", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y"
                         , "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAcc-mad()-X"
                         , "fBodyAcc-mad()-Y", "fBodyAcc-mad()-Z", "fBodyAcc-max()-X", "fBodyAcc-max()-Y", "fBodyAcc-max()-Z", "fBodyAcc-min()-X"
                         , "fBodyAcc-min()-Y", "fBodyAcc-min()-Z", "fBodyAcc-sma()", "fBodyAcc-energy()-X", "fBodyAcc-energy()-Y"
                         , "fBodyAcc-energy()-Z", "fBodyAcc-iqr()-X", "fBodyAcc-iqr()-Y", "fBodyAcc-iqr()-Z", "fBodyAcc-entropy()-X"
                         , "fBodyAcc-entropy()-Y", "fBodyAcc-entropy()-Z", "fBodyAcc-maxInds-X", "fBodyAcc-maxInds-Y", "fBodyAcc-maxInds-Z"
                         , "fBodyAcc-meanFreq()-X", "fBodyAcc-meanFreq()-Y", "fBodyAcc-meanFreq()-Z", "fBodyAcc-skewness()-X"
                         , "fBodyAcc-kurtosis()-X", "fBodyAcc-skewness()-Y", "fBodyAcc-kurtosis()-Y", "fBodyAcc-skewness()-Z"
                         , "fBodyAcc-kurtosis()-Z", "fBodyAcc-bandsEnergy()-18-X", "fBodyAcc-bandsEnergy()-916-X", "fBodyAcc-bandsEnergy()-1724-X"
                         , "fBodyAcc-bandsEnergy()-2532-X", "fBodyAcc-bandsEnergy()-3340-X", "fBodyAcc-bandsEnergy()-4148-X"
                         , "fBodyAcc-bandsEnergy()-4956-X", "fBodyAcc-bandsEnergy()-5764-X", "fBodyAcc-bandsEnergy()-116-X"
                         , "fBodyAcc-bandsEnergy()-1732-X", "fBodyAcc-bandsEnergy()-3348-X", "fBodyAcc-bandsEnergy()-4964-X"
                         , "fBodyAcc-bandsEnergy()-124-X", "fBodyAcc-bandsEnergy()-2548-X", "fBodyAcc-bandsEnergy()-18-Y"
                         , "fBodyAcc-bandsEnergy()-916-Y", "fBodyAcc-bandsEnergy()-1724-Y", "fBodyAcc-bandsEnergy()-2532-Y"
                         , "fBodyAcc-bandsEnergy()-3340-Y", "fBodyAcc-bandsEnergy()-4148-Y", "fBodyAcc-bandsEnergy()-4956-Y"
                         , "fBodyAcc-bandsEnergy()-5764-Y", "fBodyAcc-bandsEnergy()-116-Y", "fBodyAcc-bandsEnergy()-1732-Y"
                         , "fBodyAcc-bandsEnergy()-3348-Y", "fBodyAcc-bandsEnergy()-4964-Y", "fBodyAcc-bandsEnergy()-124-Y"
                         , "fBodyAcc-bandsEnergy()-2548-Y", "fBodyAcc-bandsEnergy()-18-Z", "fBodyAcc-bandsEnergy()-916-Z"
                         , "fBodyAcc-bandsEnergy()-1724-Z", "fBodyAcc-bandsEnergy()-2532-Z", "fBodyAcc-bandsEnergy()-3340-Z"
                         , "fBodyAcc-bandsEnergy()-4148-Z", "fBodyAcc-bandsEnergy()-4956-Z", "fBodyAcc-bandsEnergy()-5764-Z"
                         , "fBodyAcc-bandsEnergy()-116-Z", "fBodyAcc-bandsEnergy()-1732-Z", "fBodyAcc-bandsEnergy()-3348-Z"
                         , "fBodyAcc-bandsEnergy()-4964-Z", "fBodyAcc-bandsEnergy()-124-Z", "fBodyAcc-bandsEnergy()-2548-Z"
                         , "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X"
                         , "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyAccJerk-mad()-X", "fBodyAccJerk-mad()-Y"
                         , "fBodyAccJerk-mad()-Z", "fBodyAccJerk-max()-X", "fBodyAccJerk-max()-Y", "fBodyAccJerk-max()-Z", "fBodyAccJerk-min()-X"
                         , "fBodyAccJerk-min()-Y", "fBodyAccJerk-min()-Z", "fBodyAccJerk-sma()", "fBodyAccJerk-energy()-X"
                         , "fBodyAccJerk-energy()-Y", "fBodyAccJerk-energy()-Z", "fBodyAccJerk-iqr()-X", "fBodyAccJerk-iqr()-Y"
                         , "fBodyAccJerk-iqr()-Z", "fBodyAccJerk-entropy()-X", "fBodyAccJerk-entropy()-Y", "fBodyAccJerk-entropy()-Z"
                         , "fBodyAccJerk-maxInds-X", "fBodyAccJerk-maxInds-Y", "fBodyAccJerk-maxInds-Z", "fBodyAccJerk-meanFreq()-X"
                         , "fBodyAccJerk-meanFreq()-Y", "fBodyAccJerk-meanFreq()-Z", "fBodyAccJerk-skewness()-X", "fBodyAccJerk-kurtosis()-X"
                         , "fBodyAccJerk-skewness()-Y", "fBodyAccJerk-kurtosis()-Y", "fBodyAccJerk-skewness()-Z", "fBodyAccJerk-kurtosis()-Z"
                         , "fBodyAccJerk-bandsEnergy()-18-X", "fBodyAccJerk-bandsEnergy()-916-X", "fBodyAccJerk-bandsEnergy()-1724-X"
                         , "fBodyAccJerk-bandsEnergy()-2532-X", "fBodyAccJerk-bandsEnergy()-3340-X", "fBodyAccJerk-bandsEnergy()-4148-X"
                         , "fBodyAccJerk-bandsEnergy()-4956-X", "fBodyAccJerk-bandsEnergy()-5764-X", "fBodyAccJerk-bandsEnergy()-116-X"
                         , "fBodyAccJerk-bandsEnergy()-1732-X", "fBodyAccJerk-bandsEnergy()-3348-X", "fBodyAccJerk-bandsEnergy()-4964-X"
                         , "fBodyAccJerk-bandsEnergy()-124-X", "fBodyAccJerk-bandsEnergy()-2548-X", "fBodyAccJerk-bandsEnergy()-18-Y"
                         , "fBodyAccJerk-bandsEnergy()-916-Y", "fBodyAccJerk-bandsEnergy()-1724-Y", "fBodyAccJerk-bandsEnergy()-2532-Y"
                         , "fBodyAccJerk-bandsEnergy()-3340-Y", "fBodyAccJerk-bandsEnergy()-4148-Y", "fBodyAccJerk-bandsEnergy()-4956-Y"
                         , "fBodyAccJerk-bandsEnergy()-5764-Y", "fBodyAccJerk-bandsEnergy()-116-Y", "fBodyAccJerk-bandsEnergy()-1732-Y"
                         , "fBodyAccJerk-bandsEnergy()-3348-Y", "fBodyAccJerk-bandsEnergy()-4964-Y", "fBodyAccJerk-bandsEnergy()-124-Y"
                         , "fBodyAccJerk-bandsEnergy()-2548-Y", "fBodyAccJerk-bandsEnergy()-18-Z", "fBodyAccJerk-bandsEnergy()-916-Z"
                         , "fBodyAccJerk-bandsEnergy()-1724-Z", "fBodyAccJerk-bandsEnergy()-2532-Z", "fBodyAccJerk-bandsEnergy()-3340-Z"
                         , "fBodyAccJerk-bandsEnergy()-4148-Z", "fBodyAccJerk-bandsEnergy()-4956-Z", "fBodyAccJerk-bandsEnergy()-5764-Z"
                         , "fBodyAccJerk-bandsEnergy()-116-Z", "fBodyAccJerk-bandsEnergy()-1732-Z", "fBodyAccJerk-bandsEnergy()-3348-Z"
                         , "fBodyAccJerk-bandsEnergy()-4964-Z", "fBodyAccJerk-bandsEnergy()-124-Z", "fBodyAccJerk-bandsEnergy()-2548-Z"
                         , "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y"
                         , "fBodyGyro-std()-Z", "fBodyGyro-mad()-X", "fBodyGyro-mad()-Y", "fBodyGyro-mad()-Z", "fBodyGyro-max()-X"
                         , "fBodyGyro-max()-Y", "fBodyGyro-max()-Z", "fBodyGyro-min()-X", "fBodyGyro-min()-Y", "fBodyGyro-min()-Z"
                         , "fBodyGyro-sma()", "fBodyGyro-energy()-X", "fBodyGyro-energy()-Y", "fBodyGyro-energy()-Z", "fBodyGyro-iqr()-X"
                         , "fBodyGyro-iqr()-Y", "fBodyGyro-iqr()-Z", "fBodyGyro-entropy()-X", "fBodyGyro-entropy()-Y", "fBodyGyro-entropy()-Z"
                         , "fBodyGyro-maxInds-X", "fBodyGyro-maxInds-Y", "fBodyGyro-maxInds-Z", "fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y"
                         , "fBodyGyro-meanFreq()-Z", "fBodyGyro-skewness()-X", "fBodyGyro-kurtosis()-X", "fBodyGyro-skewness()-Y"
                         , "fBodyGyro-kurtosis()-Y", "fBodyGyro-skewness()-Z", "fBodyGyro-kurtosis()-Z", "fBodyGyro-bandsEnergy()-18-X"
                         , "fBodyGyro-bandsEnergy()-916-X", "fBodyGyro-bandsEnergy()-1724-X", "fBodyGyro-bandsEnergy()-2532-X"
                         , "fBodyGyro-bandsEnergy()-3340-X", "fBodyGyro-bandsEnergy()-4148-X", "fBodyGyro-bandsEnergy()-4956-X"
                         , "fBodyGyro-bandsEnergy()-5764-X", "fBodyGyro-bandsEnergy()-116-X", "fBodyGyro-bandsEnergy()-1732-X"
                         , "fBodyGyro-bandsEnergy()-3348-X", "fBodyGyro-bandsEnergy()-4964-X", "fBodyGyro-bandsEnergy()-124-X"
                         , "fBodyGyro-bandsEnergy()-2548-X", "fBodyGyro-bandsEnergy()-18-Y", "fBodyGyro-bandsEnergy()-916-Y"
                         , "fBodyGyro-bandsEnergy()-1724-Y", "fBodyGyro-bandsEnergy()-2532-Y", "fBodyGyro-bandsEnergy()-3340-Y"
                         , "fBodyGyro-bandsEnergy()-4148-Y", "fBodyGyro-bandsEnergy()-4956-Y", "fBodyGyro-bandsEnergy()-5764-Y"
                         , "fBodyGyro-bandsEnergy()-116-Y", "fBodyGyro-bandsEnergy()-1732-Y", "fBodyGyro-bandsEnergy()-3348-Y"
                         , "fBodyGyro-bandsEnergy()-4964-Y", "fBodyGyro-bandsEnergy()-124-Y", "fBodyGyro-bandsEnergy()-2548-Y"
                         , "fBodyGyro-bandsEnergy()-18-Z", "fBodyGyro-bandsEnergy()-916-Z", "fBodyGyro-bandsEnergy()-1724-Z"
                         , "fBodyGyro-bandsEnergy()-2532-Z", "fBodyGyro-bandsEnergy()-3340-Z", "fBodyGyro-bandsEnergy()-4148-Z"
                         , "fBodyGyro-bandsEnergy()-4956-Z", "fBodyGyro-bandsEnergy()-5764-Z", "fBodyGyro-bandsEnergy()-116-Z"
                         , "fBodyGyro-bandsEnergy()-1732-Z", "fBodyGyro-bandsEnergy()-3348-Z", "fBodyGyro-bandsEnergy()-4964-Z"
                         , "fBodyGyro-bandsEnergy()-124-Z", "fBodyGyro-bandsEnergy()-2548-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()"
                         , "fBodyAccMag-mad()", "fBodyAccMag-max()", "fBodyAccMag-min()", "fBodyAccMag-sma()", "fBodyAccMag-energy()"
                         , "fBodyAccMag-iqr()", "fBodyAccMag-entropy()", "fBodyAccMag-maxInds", "fBodyAccMag-meanFreq()", "fBodyAccMag-skewness()"
                         , "fBodyAccMag-kurtosis()", "fBodyAccJerkMag-mean()", "fBodyAccJerkMag-std()", "fBodyAccJerkMag-mad()"
                         , "fBodyAccJerkMag-max()", "fBodyAccJerkMag-min()", "fBodyAccJerkMag-sma()", "fBodyAccJerkMag-energy()"
                         , "fBodyAccJerkMag-iqr()", "fBodyAccJerkMag-entropy()", "fBodyAccJerkMag-maxInds", "fBodyAccJerkMag-meanFreq()"
                         , "fBodyAccJerkMag-skewness()", "fBodyAccJerkMag-kurtosis()", "fBodyGyroMag-mean()", "fBodyGyroMag-std()"
                         , "fBodyGyroMag-mad()", "fBodyGyroMag-max()", "fBodyGyroMag-min()", "fBodyGyroMag-sma()", "fBodyGyroMag-energy()"
                         , "fBodyGyroMag-iqr()", "fBodyGyroMag-entropy()", "fBodyGyroMag-maxInds", "fBodyGyroMag-meanFreq()"
                         , "fBodyGyroMag-skewness()", "fBodyGyroMag-kurtosis()", "fBodyGyroJerkMag-mean()", "fBodyGyroJerkMag-std()"
                         , "fBodyGyroJerkMag-mad()", "fBodyGyroJerkMag-max()", "fBodyGyroJerkMag-min()", "fBodyGyroJerkMag-sma()"
                         , "fBodyGyroJerkMag-energy()", "fBodyGyroJerkMag-iqr()", "fBodyGyroJerkMag-entropy()", "fBodyGyroJerkMag-maxInds"
                         , "fBodyGyroJerkMag-meanFreq()", "fBodyGyroJerkMag-skewness()", "fBodyGyroJerkMag-kurtosis()"
                         , "angle(tBodyAccMeangravity)", "angle(tBodyAccJerkMean)gravityMean)", "angle(tBodyGyroMeangravityMean)"
                         , "angle(tBodyGyroJerkMeangravityMean)", "angle(XgravityMean)", "angle(YgravityMean)", "angle(ZgravityMean)")

# Read into R the test data files
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE,col.names=c("subject_id"))

#Same column name for the id ("activity_id") as the activity_labels data set to merge them together easily with dplyr
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE,col.names=c("activity_id"))
measurements_test <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE)

# Read into R the train data files
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE,col.names=c("subject_id"))

#Same column name for the id ("activity_id") as the activity_labels data set to merge them together easily with dplyr
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE,col.names=c("activity_id"))
measurements_train <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE)

# Apply this new labels to the columns of our test and train measurements data sets
names(measurements_test) <- measurements_labels
names(measurements_train) <- measurements_labels

# Combine the different parts of each dataset
train_dataset <- cbind(subject_train,activity_train,measurements_train)
test_dataset <- cbind(subject_test,activity_test,measurements_test)
# Finally combine both datasets (train and test) into one
data <- rbind(train_dataset,test_dataset)

# Perform the steps of the course project with the help of dplyr and chain syntax
data %>%
      # Extract only the measurements on the mean and standard deviation for each measurement
      select(subject_id, activity_id, contains("-mean"), contains("-std")) %>%
      # Add the appropriate activity label to the dataset
      inner_join(activity_labels,by="activity_id") %>%
      # Generate the new tidy dataset with the average of each variable 
      # for each activity and each subject.
      group_by(subject_id,activity_id,activity_label) %>%
      # Use dplyr summarise_each function to compute the mean 
      # for all the selected measurements
      summarise_each(funs(mean)) %>%
      #Generate the output text file from the tidy dataset
      write.table("UCI_HAR_tinydata.txt",row.names=FALSE)
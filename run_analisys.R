## run_analysis.R
##   Read in the UCI HAR dataset and tidy the data in two ways: 
##     1) Extract only the measurements on the mean and standard deviation for each measurement.
##     2) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
##   Note:  data files must be in the subdirectory "UCI HAR Dataset" from
##          the current directory.

startingDir <- getwd()
setwd("UCI HAR Dataset/")

## Get the activity labels and attribute names
dt <- read.table("activity_labels.txt", sep = "")
activityLabels <- as.character(dt$V2)
dt <- read.table("features.txt", sep = "")
attributeNames <- dt$V2

## Read in the training x-y data
train.x <- read.table("train/X_train.txt", sep = "")
train.y <- read.table("train/y_train.txt", sep = "")

## Set the descriptive names
names(train.x) <- attributeNames
names(train.y) <- "Activity"

## Convert the Activity to a factor
train.y$Activity <- as.factor(train.y$Activity)
levels(train.y$Activity) <- activityLabels

## Read in the training subject data
train.Subjects <- read.table("train/subject_train.txt", sep = "")

## Set the names
names(train.Subjects) <- "subject"

## Convert to a factor
train.Subjects$subject <- as.factor(train.Subjects$subject)

## Combine the training data
train <- cbind(train.x, train.Subjects, train.y)

## Read in the test x-y data
test.x <- read.table("test/X_test.txt", sep = "")
test.y <- read.table("test/y_test.txt", sep = "")

## Set the names
names(test.x) <- attributeNames
names(test.y) <- "Activity"

## Convert to a factor
test.y$Activity <- as.factor(test.y$Activity)
levels(test.y$Activity) <- activityLabels

## Read in the test subjects
test.Subjects <- read.table("test/subject_test.txt", sep = "")

## Set the names
names(test.Subjects) <- "subject"

## Convert to factor
test.Subjects$subject <- as.factor(test.Subjects$subject)

## Combine the test data
test <- cbind(test.x, test.Subjects, test.y)

## Combine the test and training data
allData <- rbind(train, test)

## Do some cleanup
rm(train, test, dt, train.x, train.y, test.x, test.y, train.Subjects, test.Subjects, 
       activityLabels, attributeNames)

## Go back to orginal directory
setwd(startingDir)

## Remove all comluns not related to mean or standard deviation
columnNames <- names(allData)
meanStd <- sort(c(grep("mean()", columnNames),grep("std()", columnNames)))

## Keep the subject and Activity columns
colsToKeep <- c(which(names(allData) == "subject"), which(names(allData) == "Activity"), meanStd)

## Create the tidy set
tidySet <- allData[,colsToKeep]

## Divide up the data frame by subject and activity
tidy.grouped <- split(tidySet, list(tidySet$subject,tidySet$Activity))

## Go through list to calculate averages
r <- lapply(tidy.grouped, function(x) colMeans(x[,3:81]))

## Write out the results.
write.table(r, "averages.txt", row.name=FALSE)
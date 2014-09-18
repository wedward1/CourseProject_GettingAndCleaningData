### Goal of this project is to import and process two data sets,
### then merge them together, then create a table of means by group for 
### the merged data.

# set wd to where the files are located:
setwd("C:\\Users\\wedwa_000\\OneDrive\\Documents\\R\\Coursera\\Getting and Cleaning Data\\03 Course Project\\Initial Data Download Extraction\\UCI HAR Dataset")

##Load "train" dataset

# Import features table which has column labels for training table
features <- read.table("./features.txt",header=FALSE,stringsAsFactors = FALSE)

# Import features table which has activity codes for each rown of training table
y_train <- read.table("./train/y_train.txt", header = FALSE,col.names= "activity_number")

# Import training data
X_train <- read.table("./train/X_train.txt", header = FALSE, col.names=features[,2],dec=".", stringsAsFactors = FALSE)
# Add activity codes to to training codes
X_train <- cbind(y_train,X_train)

# Import data for activity descriptions
activity_labels <- read.table("./activity_labels.txt",col.names = c("activity_number","activity_description"))

# Load dplyr to manipulate this table
library(dplyr)
# Look up activity description for each activity number
X_train <- inner_join(X_train,activity_labels,by = "activity_number")
# move activity description from last column to first column
X_train <- X_train[,c(ncol(X_train),1:(ncol(X_train)-1))]

#create vector of column names
traincolNames <- names(X_train)

# Get column names that end in ".mean"
trainmeanCols <- grep("*.mean",traincolNames)
# Get column names that end in ".std"
trainstdCols<- grep("*.std", traincolNames)
# Append the two vectors
trainCols <- append(trainmeanCols,trainstdCols)
# Sort it
trainCols <- trainCols[order(trainCols)]
# only keep first two columns and columns in trainCol vector
X_train <- X_train[,c(1,2,trainCols)]

### Load "test" dataset 

# Import features table which has activity codes for each rown of training table
y_test <- read.table("./test/y_test.txt", header = FALSE,col.names= "activity_number")

# Import training data
X_test <- read.table("./test/X_test.txt", header = FALSE, col.names=features[,2],dec=".", stringsAsFactors = FALSE)
# Add activity codes to to training codes
X_test <- cbind(y_test,X_test)
# Look up activity description for each activity number
X_test <- inner_join(X_test,activity_labels,by = "activity_number")
# move activity description from last column to first column
X_test <- X_test[,c(ncol(X_test),1:(ncol(X_test)-1))]

#create vector of column names
testcolNames <- names(X_test)

# Get column names that end in ".mean"
testmeanCols <- grep("*.mean",testcolNames)
# Get column names that end in ".std"
teststdCols<- grep("*.std", testcolNames)
# Append the two vectors
testCols <- append(testmeanCols,teststdCols)
# Sort it
testCols <- testCols[order(testCols)]
# only keep first two columns and columns in testCol vector
X_test <- X_test[,c(1,2,testCols)]

#combine data sets
cdata <- rbind(X_test,X_train) 
# Load dplyr package to compute group averages
library(dplyr)
# make cdata a data frame table
cdata <- tbl_df(cdata)
tidydataset <- aggregate(cdata[c(-1,-2)],by=list(cdata$activity_description),FUN=mean)
print(tidydataset)
write.table(tidydataset,file="C:/Users/wedwa_000/OneDrive/Documents/R/Coursera/Getting and Cleaning Data/03 Course Project/tidydataset.txt",row.names=FALSE,col.names=TRUE,sep="\t")
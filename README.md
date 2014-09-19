##What the analysis file does:
#1. Processes "Train" Dataset:
*Sets the work directory in R to where the data files are located
*Loads the features.txt file which contains column names for the training data
*Loads the activity numbers for the file y_train.txt
*Loads the X_train.txt file
*Appends the activity numbers to the X_train data
*Loads the activity labels from activity_labels.txt
*Joins the X_train table with the activity_labels so that the activity descriptions are included as a column
*Removes columns that are not either a mean or standard deviation

#2. Processes "Test" Dataset:
*Loads the activity numbers for the file y_test.txt
*Loads the X_test.txt file
*Appends the activity numbers to the X_test data
*Joins the X_train table with the activity_labels so that the activity descriptions are included as a column
*Removes columns that are not either a mean or standard deviation

#3. Combines the data:
*Appends the train data to the test data and names it,"cdata"
*Calculates means for all columns in cdata by activity_labels and stores it as,"tidydataset"
*writes the "tidydataset" to a .txt file with the same name
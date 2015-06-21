The X_train.txt, y_train.txt and subject_train.txt data will be read in R as variables train_datax, train_datay 
and train_subject respectively and merged to one file, train_data.  The X_test.txt, y_train.txt and subject_train.txt 
data will be read in R as variables test_datax, test_datay and test_subject respectively and merged to one file, 
test_data.   The train_data and the test_data files were merged to become a file, the combined_data.

The test subjects and their descriptive activity names were added to the combined_data file and the variable names 
were used as the column heading.  Only the mean and the standard deviation were retrieved from the data set to 
form a new subset file, the data_subset.  

The resulting data were sorted in tidy order and the aggregate average of all variables of each subject on each 
activity were calculated and tabulated  to form another table file, the final_data.txt.

library(plyr)
library(dplyr)
library(reshape2)


# Load data set to R

train_datax <- read.table("./train/X_train.txt")
train_datay <- read.table("./train/y_train.txt")
train_subject <- read.table("./train/subject_train.txt")
test_subject <- read.table("./test/subject_test.txt")
test_datax <- read.table("./test/X_test.txt")
test_datay <- read.table("./test/y_test.txt")
col_labels <- read.table("./features.txt")
act_labels <- read.table("./activity_labels.txt")



# Combine the Activity and Subject to the data

train_data <- cbind(train_datax, train_datay, train_subject)
test_data <- cbind(test_datax, test_datay, test_subject)



# Combined train and test data

combined_data <- rbind(train_data, test_data)



# Adds descriptive heading to the column 562 and 563 of the 'col_labels'

col_labels <- rbind(col_labels, data.frame(V1 = 562, V2 = "Activity"))
col_labels <- rbind(col_labels, data.frame(V1 = 563, V2 = "Subject"))



# Adds descriptive heading to the combined data

colnames(combined_data) <-  col_labels$V2



# Subsetting mean and standard deviation of the combined data

df_mean <- col_labels[grep("mean()", col_labels$V2, fixed = TRUE),]
df_std <- col_labels[grep("std()", col_labels$V2, fixed = TRUE),]
df_act <- col_labels[grep("Activity", col_labels$V2, fixed = TRUE),]
df_sub <- col_labels[grep("Subject", col_labels$V2, fixed = TRUE),]

mean_std <- rbind(df_mean, df_std, df_act, df_sub)
mean_std <- arrange(mean_std, V1)


# The subset result was saved to data_subset

data_subset <- combined_data[,mean_std$V1]
names(data_subset) <- make.names(names(data_subset))



## Uses descriptive activity names to name the activities in the data set

data_subset$Activity <- as.factor(data_subset$Activity)
levels(data_subset$Activity) <- c(levels(data_subset$Activity), levels(act_labels$V2))
for (i in 1:6){
	data_subset[which(data_subset$Activity == i),"Activity"] <- act_labels[which(act_labels$V1 == i), "V2"]
}



## Obtains the final data set

data_subset$index <- paste(data_subset$Subject, data_subset$Activity, sep = "_")
mean_vars <- names(data_subset[,1:66])
melt_data <- melt(data_subset, id="index", measure.vars=mean_vars)
final_data <- dcast(melt_data, index ~ variable, mean)




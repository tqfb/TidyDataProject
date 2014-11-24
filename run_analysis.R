library(tidyr)
library(plyr)
library(dplyr)
library(reshape2)

# Read in all of the test data and append subject and activity id to data tables
test_sub2 <- read.csv(paste(getwd(), "/test/subject_test.txt", sep=""),header = FALSE)
test_act2 <- read.csv(paste(getwd(), "./test/y_test.txt", sep=""), header = FALSE)
test_data2 <- read.table(paste(getwd(), "./test/X_test.txt", sep=""), header = FALSE)

# Read in all of the train data and append subject and activity id to data tables
train_sub2 <- read.csv(paste(getwd(), "./train/subject_train.txt", sep=""), header = FALSE)
train_act2 <- read.csv(paste(getwd(), "./train/y_train.txt", sep=""), header = FALSE)
train_data2 <- read.table(paste(getwd(), "./train/x_train.txt", sep=""), header = FALSE)

# Combine the activity and subject IDs and combine both data sets into a single dataset
test_data <- cbind(test_sub2, test_act2, test_data2)
train_data <- cbind(train_sub2, train_act2, train_data2)
full_data <- rbind(test_data,train_data)

# Read in the activity names and column headers for data set, to be used to apply 
# descriptive names to final data set
act_labels2 <- read.table(paste(getwd(), "./activity_labels.txt", sep=""), header = FALSE)
data_labels2 <- read.table(paste(getwd(), "./features.txt", sep=""))

# Create vector of column headings and apply to full data set
data_headers2 <- as.character(data_labels2[,2])
data_headers2 <- append(data_headers2, c("SubjectID", "ActivityID"), after = 0)
names(full_data) <- data_headers2

# Get the column indices for mean and standar deviation measurements and
# split out only those columns
means <- grep("-mean\\(", data_headers2, value = FALSE,)
stdevs <- grep("std", data_headers2, value = FALSE,)
trimmedcols <- sort(append(means, c(stdevs,1:2), 0))
split_data <- full_data[,trimmedcols]

# Add activity description, rather than ID
activity_merge <- merge(split_data,act_labels2,by.x="ActivityID",by.y="V1",all.y=TRUE)
# Melt that data!
melted_data <- melt(activity_merge, id=c("SubjectID", "V2") )
# Get rid of superfluous data
md_test <- melted_data[!melted_data$variable == "ActivityID",]
# Group the data and apply mean function, ignore warnings for NA, as we'll get rid of
# those columns shortly

aggtest <- aggregate(md_test, by=list(md_test$SubjectID, md_test$V2, md_test$variable), FUN = "mean")
newagg <- select(aggtest, SubjectID, Group.2, Group.3, value )
names(newagg) <- c("SubjectID", "ActivityID", "Measurement", "Means")
finaladd <- spread(newagg, "Measurement", "Means")


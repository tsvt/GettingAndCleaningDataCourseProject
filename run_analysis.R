# start
setwd('./UCI HAR Dataset/');        # Change folder name here, if you need

# load names, test and train data

# Read data
testY = read.table('./test/y_test.txt', sep="");
testX = read.table('./test/X_test.txt', sep="");
testSubject = read.table('./test/subject_test.txt', sep="");

trainY = read.table('./train/y_train.txt', sep="");
trainX = read.table('./train/X_train.txt', sep="");
trainSubject = read.table('./train/subject_train.txt', sep="");

# Join data.frames
x = rbind(testX, trainX);
y = rbind(testY, trainY);
subject = rbind(testSubject, trainSubject);
names(y) <- c("LABEL");
names(dfSubject) <- c("SUBJECT");

data = cbind(dfSubject, x, y);

# Read in labels and column names
labels = read.table("./activity_labels.txt", sep="");
names = read.table("./features.txt", sep="");
labels$V2 <- as.character(labels$V2);
names$V2 <- as.character(names$V2);

# Do some regexps to make sure the column names are safe to use in any R script
names$V2 = gsub("-", "_", names$V2, perl=T);
names$V2 = gsub(",", "_", names$V2, perl=T);
names$V2 = gsub("\\(", "", names$V2, perl=T);
names$V2 = gsub("\\)", "", names$V2, perl=T);

# Substitute activity idicies with character labels
labeledDf = merge(data, labels, by.x = "LABEL", by.y = "V1");
labeledDf = labeledDf[,2:564];

# Assign new column naming
names = rbind(c("0", "subject"), names);
names = rbind(names, c("562", "activity_label"));

names(labeledDf) = names$V2;

# Extract only those with mean, std or activity_label or subject in column name
extracted = labeledDf[,grep("mean|std|activity_label|subject", names(labeledDf))];

# Prepare result
result = aggregate(extracted[2:80], by=list(extracted$subject,extracted$activity_label), FUN=mean);

# Prepare new column naming
names(result) = paste("mean.",names(result),sep="")
names(result)[1] = "subject";
names(result)[2] = "activity";

# Save results
write.table(result, "tidy_data.txt", row.names=F);
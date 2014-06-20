library(plyr);
setwd("D:/Study Material/Coursera-R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
activity_labels <-read.table("activity_labels.txt");
features <-read.table("features.txt");
feature_names <- features[,2];
subject_test <- read.table("test/subject_test.txt");
subject_train <- read.table("train/subject_train.txt");
subject <- rbind(subject_test,subject_train);
X_test <- read.table("test/X_test.txt");
X_train <- read.table("train/X_train.txt");
X <- rbind(X_test,X_train);
#Adding descriptive names to variables
names(X)<-feature_names;
Y_test <- read.table("test/y_test.txt");
Y_train <- read.table("train/y_train.txt");
Y <- rbind(Y_test,Y_train);
#mapping activity labels to the measured activity ids
#Y <- merge(Y,activity_labels,by=c("V1"),sort = FALSE);
join(Y,activity_labels,by=c("V1"));      
# Adding activity labels to the dataset
X <- cbind(Y[["V2"]],X);
colnames(X)[1]<- "Activity";
# Associating subject ids with the dataset
X <- cbind(subject,X);
colnames(X)[1]<- "Subject_Id";
columnswithmean <- which(sapply(colnames(X),grepl,pattern="mean",ignore.case = TRUE))
columnswithstd <- which(sapply(colnames(X),grepl,pattern="std",ignore.case = TRUE))
X<-X[,c(1,2,columnswithmean,columnswithstd)]
tidy_data_mean <- aggregate(. ~ Subject_Id + Activity, data = X, mean)
write.table(tidy_data_mean, "tidy_data.txt", sep="\t", row.names=F)

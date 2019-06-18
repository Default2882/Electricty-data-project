#Required Libraries

library(data.table)
library(dplyr)

#A function to make the dataset from the provided test raw data
testmakedataset <- function(){
  #Reading the Test Set in the folder "../Raw data/test/X_text.txt"
  testset <- read.table("../Raw data/test/X_test.txt")
  #Reading all the 561 feature vector from "../Raw data/features.txt
  features <- read.table("../Raw data/features.txt")
  #Filtering out all the index of  mean and standard deviation values from the features.txt
  k <- grep("mean|std", features$V2)
  #Testset is subsetted only by the first index because my laptop is not powerful enough to process all the data
  testset <- testset[k[1]]
  #Reading all the activities done for each observation from the file ""../Raw data/test/y_test.txt"
  activity <- read.table("../Raw data/test/y_test.txt")
  #Renaming it to activities because the default name was set to V1
  setnames(activity ,old = "V1",new = "Activity")
  #changing the activities variable into a factor where the labels are "WALKING" , "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
  activity <- factor(as.integer(activity$Activity), labels =c("WALKING" , "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
  #Reading the test subject number of each corresponding observation
  testsubject <- read.table("../Raw data/test/subject_test.txt")
  #Changing the name for the same reason i had to change it for activities
  setnames(testsubject ,old = "V1",new = "Subjects")
  #Returning a data frame of the test data set
  cbind(testsubject, activity, testset)
}

#this function is the same as the above one, i just copy pasted it and made it work for the train data set
#It returns a data frame with the same syntax as testmakedataset
trainmakedataset <- function(){
  trainset <- read.table("../Raw data/train/X_train.txt")
  features <- read.table("../Raw data/features.txt")
  k <- grep("mean|std", features$V2)
  trainset <- trainset[k[1]]
  #setnames(trainset , old = names(trainset) , new =  as.character(lapply(names(trainset), paste0, "train")))
  activity <- read.table("../Raw data/train/y_train.txt")
  setnames(activity ,old = "V1",new = "Activity")
  activity <- factor(as.integer(activity$Activity), labels =c("WALKING" , "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
  trainsubject <- read.table("../Raw data/train/subject_train.txt")
  setnames(trainsubject ,old = "V1",new = "Subjects")
  cbind(trainsubject, activity, trainset)
}

#This function combines and writes a csv file on the memory 
combine <- function(){
  testset <- testmakedataset()
  trainset <- trainmakedataset()
  findata <- rbind(trainset, testset)
  write.csv(findata, file = "../findata.csv")
  #the file is included in the Github repo saved by the name "findata.csv" 
}

#This function is defined to find the average of each variable for each activity and each subject
avg <- function(){
  #Reading the csv file created by the combine() function
  tidydata <- read.csv("../findata.csv")
  #Changing the subject variable from a list to a factor which lets me create and
  #combine the subject factor and activity factor by interaction()
  print(tidydata$Subjects)
  tidydata$Subjects <- factor(tidydata$Subjects, labels  =  1:30)
  #creating a factor variable by combining activity and subject no.
  interact <- interaction(tidydata$Subjects, tidydata$activity)
  #Finding the mean of the data by splitting it based on the interact factor variable
  mymean <- lapply(split(tidydata, interact), function(x) mean(x$V1))
  activity.subject <- names(mymean)
  value.mean <- sapply(mymean, function(x){as.numeric(x[1])})
  #Creating a data frame which have to be written on a file to be saved on memory
  finalframe <- data.frame(activity.subject, value.mean)
  #Writing it into memory so it can be accessed by others from the github repo
  write.table(finalframe,"../average-subject-activity.txt", row.names = F)
}
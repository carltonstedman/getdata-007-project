# some R

features <- read.table("UCI HAR Dataset/features.txt")

# determine indexes of features that are means and std
indexes <- grep("mean|std", ignore.case=TRUE, features$V2)

# build boolean filter from indexes
filter <- sapply(1:length(features$V2),
                 function(i) {
                     i %in% indexes })

# read in activity labels
alabels <- read.table("UCI HAR Dataset/activity_labels.txt")

# load test and train data and map activities
y <- c(scan("UCI HAR Dataset/test/y_test.txt"),
       scan("UCI HAR Dataset/train/y_train.txt"))
activities <- sapply(y, function(id) { alabels$V2[id] })

d <- scan("UCI HAR Dataset/test/subject_test.txt")

# read in x data
x <- c(scan("UCI HAR Dataset/test/X_test.txt"),
       scan("UCI HAR Dataset/train/X_train.txt"))

# build boolean filter size of x
bf <- rep(filter, length(x)/length(features$V2))

# now only get mean, std features out of x
ms <- split(x[bf], 1:length(indexes))

# get subjects
subjects <- c(scan("UCI HAR Dataset/test/subject_test.txt"),
              scan("UCI HAR Dataset/train/subject_train.txt"))


tidy <- data.frame(subjects, activities, ms)

# clean up column names
colnames(tidy) <- c("Subject",
                    "Activity",
                    as.character(features[indexes,]$V2))

# write out
write.csv(tidy, file = "tidy.csv")

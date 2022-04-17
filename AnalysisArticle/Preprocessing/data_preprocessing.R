#########################################################################################################
# Pre-processing of raw data for automatic detection of core beliefs from thought records. The raw data
# are not included in this data repository in order to ensure that no person identifying information is
# publicly shared. Consequently, this code cannot be run. We have included it, nonetheless, for the sake
# of transparency.
# 2018 TUDelft
# Author: Franziska Burger
# Date: October 2020
# Output files: 
#   Demographics.csv
#   thoughts_for_coding.csv
#   MentalHealth.csv
#   randomization_key.csv
#   complete_trs_with_key.csv
#########################################################################################################

# #remove all user-installed libraries in case we still have old versions
# #create a list of all installed packages
# ip <- as.data.frame(installed.packages())
# head(ip)
# #if you use MRO, make sure that no packages in this library will be removed
# ip <- subset(ip, !grepl("MRO", ip$LibPath))
# #we don't want to remove base or recommended packages either\
# ip <- ip[!(ip[,"Priority"] %in% c("base", "recommended")),]
# #determine the library where the packages are installed
# path.lib <- unique(ip$LibPath)
# #create a vector with all the names of the packages you want to remove
# pkgs.to.remove <- ip[,1]
# head(pkgs.to.remove)
# #remove the packages
# sapply(pkgs.to.remove, remove.packages, lib = path.lib)

#install all required libraries
#install.packages(c("plyr","dplyr","reshape2","tidyr","magrittr","Hmisc"))
require(plyr)
require(dplyr)
require(reshape2)
require(tidyr)
require(magrittr)
require(Hmisc) #for %nin%

#set working directory to data folder
setwd("~/surfdrive/Documents/Projects/ThoughtRecordChatbot/Experiments/Exploratory_TRs/Documents/Analysis/AnalysisScriptsForSubmission/")

#print session info
sessionInfo()

#Reading in the data
df <- read.csv("Raw/thought_records__numeric_raw_data.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE) #na.strings = "",
#Reading in all the to-be excluded participants
excludeb1 <- read.csv("MTurk/Batch1/thought_records_main_b1_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)
excludeb2 <- read.csv("MTurk/Batch2/thought_records_main_b2_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)
excludeb3 <- read.csv("MTurk/Batch3/thought_records_main_b3_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)
excludeb3$X <- NULL
excludeb4 <- read.csv("MTurk/Batch4/thought_records_main_b4_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)
excludeb5 <- read.csv("MTurk/Batch5/thought_records_main_b5_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)
excludeb6 <- read.csv("MTurk/Batch6/thought_records_main_b6_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)
excludeb7 <- read.csv("MTurk/Batch7/thought_records_main_b7_exclude.csv", na.strings = "", header=TRUE, sep=";",fill=TRUE)

excludes <- rbind(excludeb1,excludeb2,excludeb3,excludeb4,excludeb5,excludeb6,excludeb7)

## As a first pre-processing step all participants that incorrectly completed the comprehension questions, 
## pilot participants, and all participants that were excluded due to not finishing or because they filled 
## in non-sense into the available text input fields (excludes) are removed from the dataframe (df).

#delete rows 1&2
df <- df[-c(1,2),]
#delete those responses that missed the instruction comprehension questions
df$Q200 <- as.numeric(as.character(df$Q200))
df$Q201 <- as.numeric(as.character(df$Q201))
df <- df[which(df$Q200==1 & df$Q201==4),]
#delete pilot participants (completion codes 1000 to 9999)
df <- df[which(as.numeric(as.character(df$Participant.ID)) > 10000),]
#find other exclude participants
excludes <- excludes[which(excludes$Exclude==1),
                     c("Exclude","Participant.ID")]
df <- df[which(!(df$Participant.ID %in% excludes$Participant.ID)),]

## As a next step, relevant columns are selected from the dataframe that are of interest in later analyses. 
## This results in three separate dataframes: df.prelim for meta-data such as completion time and preliminary 
## questionnaire data, df.tr for actual thought records, and df.ment for mental health related info. Each 
## dataframe contains the participant ID for later merging.

#delete some columns that are not relevant
df.prelim <- df[,c(5,20,21,22,23,1086)] 
colnames(df.prelim)[1] <- "Duration"
df.tr <- df[,c(seq(27,1016,1),1086)] 
df.ment <- df[,c(seq(1020,1080,1),1086)]
df.ment$Q214 <- NULL
df.ment <- df.ment %>% rename("HDAS_D"= "SC0", "HDAS_A" = "SC1", "BDI_IA" = "SC2", "CB_Rel" = "SC3", "CB_Ach" = "SC4")

#to ensure that demographic data cannot be matched with responses anymore, we shuffle the dataframe
set.seed(123)
rows <- sample(nrow(df.prelim))
df.demographics <- df.prelim[rows, ]
write.table(df.demographics,
            "Preprocessing/Demographics.csv",sep=";",row.names=FALSE)

#write mental health data to a file
write.table(df.ment,
            "Preprocessing/MentalHealth.csv",sep=";",row.names=FALSE)

## To be able to work with the thought record components, the dataframe must be transformed from wide to 
## long format and each row labeled with the corresponding step in the thought record.

#wide to long format for data
df.tr <- melt(df.tr, id="Participant.ID")
#delete rows without a response
df.tr <- df.tr[!is.na(df.tr$value),]
#put the different variables into separate columns
df.tr$vals <- strsplit(as.character(df.tr$variable),"_")
df.tr$Scenario <- sapply(df.tr$vals,
                     function(x) ifelse(grepl("X",x[1]),x[2],x[1]))
df.tr$Task <- sapply(df.tr$vals,
                     function(x) ifelse(grepl("X",x[1]),x[3],x[2]))
#delete confirmation rows (not needed)
df.tr <- df.tr[!grepl("Conf",df.tr$Task),]
#revalue the tasks to numbers for sorting
df.tr$TaskEnum <- revalue(as.character(df.tr$Task),
                          c("Scen"=1,"Im"=2,"EmoCat"=3,
                            "Emo"=4,"EmoInt"=5,"AT"=6,
                            "P1"=7,"P2"=7,"DAT"=8,"Beh"=9))
df.tr$Loop <- sapply(df.tr$vals,
                     function(x) ifelse(grepl("X",x[1]),x[1],NA))
df.tr$Loop <- gsub("X","",df.tr$Loop) #remove unnecessary X
df.tr$Emo <- sapply(df.tr$vals, function(x) x[4])
#delete vals and variable, because we have all that information now
df.tr$vals <- NULL
df.tr$variable <- NULL
 
#sort
df.tr <- df.tr[UttEnum(df.tr$Participant.ID,df.tr$Scenario,df.tr$TaskEnum,df.tr$Loop),]

## The tought record components reflecting thought processes (first automatic thought and then the 
## downward arrow steps) must be hand-labeled with the corresponding core belief(s). To this end, 
## they cannot be in the correct sequence, as this influences coding. Hence, the sequence is scrambled 
## and both the randomization sequence and the scrambled dataframe are written to two files.

#keep sentences reflecting thought processes (taskenum 6, 7, or 8)
df.trcoding <- df.tr[which(df.tr$TaskEnum %in% c(6,7,8)),]

#then we append the right order
df.trcoding$UttEnum <- seq(1,nrow(df.trcoding),1)
#then we create a random sequence to switch the order
df.trcoding$RandID <- sample(seq(1, nrow(df.trcoding),1), 
                           size = nrow(df.trcoding), 
                           replace = FALSE)
#write randomization key to a file
write.table(df.trcoding[,c("Participant.ID","UttEnum","RandID")],
            "Preprocessing/randomization_key.csv",sep=";",row.names=FALSE)

#then sort on randomized sequence
df.trcoding <- df.trcoding[UttEnum(df.trcoding$RandID),]

#write to file for coding
write.table(df.trcoding[,c("RandID","value")],
            "Preprocessing/thoughts_for_coding.csv", sep=";", row.names=FALSE)

#to be on the safe side, we also write the merged df to a file
df.tr2 <- merge(df.tr,df.trcoding[,c("Participant.ID","Scenario","Task","TaskEnum","Loop","UttEnum","RandID")],
             by=c("Participant.ID","Scenario","Task","TaskEnum","Loop"),all.x=TRUE)

#and we write this one to a file as well
write.table(df.tr2, "Preprocessing/complete_trs_with_key.csv", sep=";", row.names=FALSE)

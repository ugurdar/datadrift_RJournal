library(foreign)

# Elec
## Logistic
rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","elec",".arff"))
data$class <- ifelse(data$class =="UP",1,0)
data$class <- as.factor(data$class)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Elec_logistic.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
elec_lr_results <- cbind(df_results,Model="LR")
## Decision Tree
rm(list=setdiff(ls(), "elec_lr_results"))
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","elec",".arff"))
data$class <- ifelse(data$class =="UP",1,0)
data$class <- as.factor(data$class)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Elec.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
elec_dt_results <-  cbind(df_results,Model="DT")

## Random Forest
rm(list=setdiff(ls(), c("elec_lr_results","elec_dt_results")))
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","elec",".arff"))
data$class <- ifelse(data$class =="UP",1,0)
data$class <- as.factor(data$class)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Elec_rf.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
elec_rf_results <- cbind(df_results,Model="RF")

elec_results <- rbind(elec_lr_results,elec_dt_results,elec_rf_results)
write.csv(elec_results,file=paste0("results_tables/experiments_Elec2_","results.csv"),row.names = FALSE)

# Friedman
## Logistic Regression - Friedman
rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("data/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Friedman_logistic.R")
  df_results <- rbind(df_results,df1)
}
friedman_lr_results <- cbind(df_results,Model="Linear R.")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
## Decision Tree- Friedman
rm(list=setdiff(ls(), "friedman_lr_results"))
jjj <- c(3,5,7)
data <- read.csv("data/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Friedman.R")
  df_results <- rbind(df_results,df1)
}
friedman_dt_results <- cbind(df_results,Model="DT")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Random Forest - Friedman
rm(list=setdiff(ls(), c("friedman_lr_results","friedman_dt_results")))
jjj <- c(3,5,7)
data <- read.csv("data/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Friedman_rf.R")
  df_results <- rbind(df_results,df1)
}
friedman_rf_results <- cbind(df_results,Model="RF")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

friedman_results <- rbind(friedman_lr_results,friedman_dt_results,friedman_rf_results)
write.csv(friedman_results,file=paste0("results_tables/experiments_Friedman_","results.csv"),row.names = FALSE)



# Hyperplane
## Logistic Regression - Hyperplane
rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("data/hyperplane07.csv",header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Hyperplane_logistic.R")
  df_results <- rbind(df_results,df1)
}
hyperplane_lr_results <- cbind(df_results,Model="LR")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Decision Tree- Hyperplane
rm(list=setdiff(ls(), "hyperplane_lr_results"))
jjj <- c(3,5,7)
data <- read.csv("data/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Hyperplane.R")
  df_results <- rbind(df_results,df1)
}
hyperplane_dt_results <- cbind(df_results,Model="DT")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Random Forest - Hyperplane
rm(list=setdiff(ls(), c("hyperplane_lr_results","hyperplane_dt_results")))
jjj <- c(3,5,7)
data <- read.csv("data/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Hyperplane_rf.R")
  df_results <- rbind(df_results,df1)
}
hyperplane_rf_results <- cbind(df_results,Model="RF")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

hyperplane_results <- rbind(hyperplane_lr_results,hyperplane_dt_results,hyperplane_rf_results)
write.csv(hyperplane_results,file=paste0("results_tables/experiments_Hyperplane_","results.csv"),row.names = FALSE)




# NOAA
## Logistic - NOAA
rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/NOAA_logistic.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
NOAA_lr_results <- cbind(df_results,Model="LR")
## Decision Tree - NOAA
rm(list=setdiff(ls(), "NOAA_lr_results"))
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts/NOAA_dt/"
  source("scripts/NOAA.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
NOAA_dt_results <-  cbind(df_results,Model="DT")

## Random Forest - NOAA
rm(list=setdiff(ls(), c("NOAA_lr_results","NOAA_dt_results")))
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/NOAA_rf.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
NOAA_rf_results <- cbind(df_results,Model="RF")

NOAA_results <- rbind(NOAA_lr_results,NOAA_dt_results,NOAA_rf_results)
write.csv(NOAA_results,file=paste0("results_tables/experiments_NOAA_","results.csv"),row.names = FALSE)



# Ozone
## Logistic - Ozone
rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Ozone_logistic.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
Ozone_lr_results <- cbind(df_results,Model="LR")

## Decision Tree - Ozone
rm(list=setdiff(ls(), "Ozone_lr_results"))
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Ozone.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
Ozone_dt_results <-  cbind(df_results,Model="DT")

## Random Forest - Ozone
rm(list=setdiff(ls(), c("Ozone_lr_results","Ozone_dt_results")))
jjj <- c(3,5,7)
data <- read.arff(paste0("data/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "scripts"
  source("scripts/Ozone_rf.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
Ozone_rf_results <- cbind(df_results,Model="RF")

Ozone_results <- rbind(Ozone_lr_results,Ozone_dt_results,Ozone_rf_results)
write.csv(Ozone_results,file=paste0("results_tables/experiments_Ozone_","results.csv"),row.names = FALSE)

# SEA
## Logistic - SEA
rm(list = ls())
jjj <- c(3,5,7)
xx <- read.csv("data/SEA_training_data.csv",header = FALSE)
yy <- read.csv("data/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1))
  experiment_result_path <- "scripts"
  source("scripts/SEA_logistic.R")
  df_results <- rbind(df_results,df)
}
SEA_lr_results <- cbind(df_results,Model="LR")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Decision Tree - SEA
rm(list=setdiff(ls(), "SEA_lr_results"))
jjj <- c(3,5,7)
xx <- read.csv("data/SEA_training_data.csv",header = FALSE)
yy <- read.csv("data/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1))
  experiment_result_path <- "scripts"
  source("scripts/SEA.R")
  df_results <- rbind(df_results,df)
}
SEA_dt_results <- cbind(df_results,Model="DT")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Random Forest - SEA
rm(list=setdiff(ls(), c("SEA_lr_results","SEA_dt_results")))
jjj <- c(3,5,7)
xx <- read.csv("data/SEA/SEA_training_data.csv",header = FALSE)
yy <- read.csv("data/SEA/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1))
  experiment_result_path <- "scripts"
  source("scripts/SEA_rf.R")
  df_results <- rbind(df_results,df)
}
SEA_rf_results <- cbind(df_results,Model="RF")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



SEA_results <- rbind(SEA_lr_results,SEA_dt_results,SEA_rf_results)
write.csv(SEA_results,file=paste0("results_tables/experiments_SEA_","results.csv"),row.names = FALSE)


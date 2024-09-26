
# Elec
## Logistic
rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","elec",".arff"))
data$class <- ifelse(data$class =="UP",1,0)
data$class <- as.factor(data$class)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Elec_logistic/"
  source("experiments/Elec_logistic.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
elec_lr_results <- cbind(df_results,Model="LR")
## Decision Tree
rm(list=setdiff(ls(), "elec_lr_results"))
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","elec",".arff"))
data$class <- ifelse(data$class =="UP",1,0)
data$class <- as.factor(data$class)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Elec_dt/"
  source("experiments/Elec.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
elec_dt_results <-  cbind(df_results,Model="DT")

## Random Forest
rm(list=setdiff(ls(), c("elec_lr_results","elec_dt_results")))
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","elec",".arff"))
data$class <- ifelse(data$class =="UP",1,0)
data$class <- as.factor(data$class)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Elec_rf/"
  source("experiments/Elec_rf.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
elec_rf_results <- cbind(df_results,Model="RF")

elec_results <- rbind(elec_lr_results,elec_dt_results,elec_rf_results)
write.csv(elec_results,file=paste0("experiments_elec_","results.csv"),row.names = FALSE)

# Friedman
## Logistic Regression - Friedman
rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Friedman_logistic/"
  source("experiments/Friedman_logistic.R")
  df_results <- rbind(df_results,df1)
}
friedman_lr_results <- cbind(df_results,Model="Linear R.")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
## Decision Tree- Friedman
rm(list=setdiff(ls(), "friedman_lr_results"))
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Friedman_dt/"
  source("experiments/Friedman.R")
  df_results <- rbind(df_results,df1)
}
friedman_dt_results <- cbind(df_results,Model="DT")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Random Forest - Friedman
rm(list=setdiff(ls(), c("friedman_lr_results","friedman_dt_results")))
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Friedman_rf/"
  source("experiments/Friedman_rf.R")
  df_results <- rbind(df_results,df1)
}
friedman_rf_results <- cbind(df_results,Model="RF")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

friedman_results <- rbind(friedman_lr_results,friedman_dt_results,friedman_rf_results)
write.csv(friedman_results,file=paste0("experiments_friedman_","results.csv"),row.names = FALSE)



# Hyperplane
## Logistic Regression - Hyperplane
rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/hyperplane07.csv",header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Hyperplane_logistic/"
  source("experiments/Hyperplane_logistic.R")
  df_results <- rbind(df_results,df1)
}
hyperplane_lr_results <- cbind(df_results,Model="LR")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Decision Tree- Hyperplane
rm(list=setdiff(ls(), "hyperplane_lr_results"))
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Hyperplane_dt/"
  source("experiments/Hyperplane.R")
  df_results <- rbind(df_results,df1)
}
hyperplane_dt_results <- cbind(df_results,Model="DT")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Random Forest - Hyperplane
rm(list=setdiff(ls(), c("hyperplane_lr_results","hyperplane_dt_results")))
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Hyperplane_rf/"
  source("experiments/Hyperplane_rf.R")
  df_results <- rbind(df_results,df1)
}
hyperplane_rf_results <- cbind(df_results,Model="RF")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

hyperplane_results <- rbind(hyperplane_lr_results,hyperplane_dt_results,hyperplane_rf_results)
write.csv(hyperplane_results,file=paste0("experiments_hyperplane_","results.csv"),row.names = FALSE)




# NOAA
## Logistic - NOAA
rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/NOAA_logistic/"
  source("experiments/NOAA_logistic.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
NOAA_lr_results <- cbind(df_results,Model="LR")
## Decision Tree - NOAA
rm(list=setdiff(ls(), "NOAA_lr_results"))
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/NOAA_dt/"
  source("experiments/NOAA.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
NOAA_dt_results <-  cbind(df_results,Model="DT")

## Random Forest - NOAA
rm(list=setdiff(ls(), c("NOAA_lr_results","NOAA_dt_results")))
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/NOAA_rf/"
  source("experiments/NOAA_rf.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
NOAA_rf_results <- cbind(df_results,Model="RF")

NOAA_results <- rbind(NOAA_lr_results,NOAA_dt_results,NOAA_rf_results)
write.csv(NOAA_results,file=paste0("experiments_NOAA_","results.csv"),row.names = FALSE)



# Ozone
## Logistic - Ozone
rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Ozone_logistic/"
  source("experiments/Ozone_logistic.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
Ozone_lr_results <- cbind(df_results,Model="LR")

## Decision Tree - Ozone
rm(list=setdiff(ls(), "Ozone_lr_results"))
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Ozone_dt/"
  source("experiments/Ozone.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
Ozone_dt_results <-  cbind(df_results,Model="DT")

## Random Forest - Ozone
rm(list=setdiff(ls(), c("Ozone_lr_results","Ozone_dt_results")))
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Ozone_rf/"
  source("experiments/Ozone_rf.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
Ozone_rf_results <- cbind(df_results,Model="RF")

Ozone_results <- rbind(Ozone_lr_results,Ozone_dt_results,Ozone_rf_results)
write.csv(Ozone_results,file=paste0("experiments_Ozone_","results.csv"),row.names = FALSE)

# SEA
## Logistic - SEA
rm(list = ls())
jjj <- c(3,5,7)
xx <- read.csv("experiments/data-sets/SEA/SEA_training_data.csv",header = FALSE)
yy <- read.csv("experiments/data-sets/SEA/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1)) 
  experiment_result_path <- "experiments/results/SEA_logistic/"
  source("experiments/SEA_logistic.R")
  df_results <- rbind(df_results,df)
}
SEA_lr_results <- cbind(df_results,Model="LR")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Decision Tree - SEA
rm(list=setdiff(ls(), "SEA_lr_results"))
jjj <- c(3,5,7)
xx <- read.csv("experiments/data-sets/SEA/SEA_training_data.csv",header = FALSE)
yy <- read.csv("experiments/data-sets/SEA/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1)) 
  experiment_result_path <- "experiments/results/SEA_dt/"
  source("experiments/SEA.R")
  df_results <- rbind(df_results,df)
}
SEA_dt_results <- cbind(df_results,Model="DT")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

## Random Forest - SEA
rm(list=setdiff(ls(), c("SEA_lr_results","SEA_dt_results")))
jjj <- c(3,5,7)
xx <- read.csv("experiments/data-sets/SEA/SEA_training_data.csv",header = FALSE)
yy <- read.csv("experiments/data-sets/SEA/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1)) 
  experiment_result_path <- "experiments/results/SEA_rf/"
  source("experiments/SEA_rf.R")
  df_results <- rbind(df_results,df)
}
SEA_rf_results <- cbind(df_results,Model="RF")
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



SEA_results <- rbind(SEA_lr_results,SEA_dt_results,SEA_rf_results)
write.csv(SEA_results,file=paste0("experiments_SEA_","results.csv"),row.names = FALSE)

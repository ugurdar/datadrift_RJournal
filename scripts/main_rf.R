rm(list=ls())
# 3: 10, 5: 20, 7: 30 batchs
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
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



rm(list=ls())
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




rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Hyperplane_rf/"
  source("experiments/Hyperplane_rf.R")
  df_results <- rbind(df_results,df1)
  
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)


rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/NOAA_rf/"
  source("experiments/NOAA_rf.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



rm(list=ls())
jjj <- c(3,5,7)
data <- read.arff(paste0("experiments/data-sets/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Ozone_rf/"
  source("experiments/Ozone_rf.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Friedman_rf/"
  source("experiments/Friedman_rf.R")
  df_results <- rbind(df_results,df1)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

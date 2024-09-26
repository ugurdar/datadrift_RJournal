rm(list=ls())
# 3: 10, 5: 20, 7: 30 batchs
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
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



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




rm(list=ls())
jjj <- c(3,5,7)
data <- read.csv("experiments/data-sets/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Hyperplane_logistic/"
  source("experiments/Hyperplane_logistic.R")
  df_results <- rbind(df_results,df1)
  
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)


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
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)
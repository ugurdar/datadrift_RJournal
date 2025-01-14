# 3: 10, 5: 20, 7: 30 batchs
jjj <- c(3,5,7)
xx <- read.csv("experiments/data-sets/SEA/SEA_training_data.csv",header = FALSE)
yy <- read.csv("experiments/data-sets/SEA/SEA_training_class.csv",header = FALSE)
df_results <- data.frame()
for(jj in jjj){
  data <- data.frame(xx, class = as.factor(yy$V1)) 
  experiment_result_path <- "experiments/results/SEA/"
  source("experiments/SEA.R")
  df_results <- rbind(df_results,df)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)


data <- read.csv("experiments/data-sets/friedman_drift_dataset.csv",
                 header = TRUE)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Friedman/"
  source("experiments/Friedman.R")
  df_results <- rbind(df_results,df1)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)


data <- read.arff(paste0("experiments/data-sets/","elec",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Elec/"
  source("experiments/Elec.R")
  df_results <- rbind(df_results,df2)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)

data <- read.arff(paste0("experiments/data-sets/","ozone",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Ozone/"
  source("experiments/Ozone.R")
  df_results <- rbind(df_results,df111)
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)


data <- read.arff(paste0("experiments/data-sets/","NOAA",".arff"))
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/NOAA/"
  source("experiments/NOAA.R")
  df_results <- rbind(df_results,df)
  
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)



data <- read.csv("experiments/data-sets/hyperplane07.csv",header = TRUE)
data$target <- as.factor(data$target)
df_results <- data.frame()
for(jj in jjj){
  experiment_result_path <- "experiments/results/Hyperplane/"
  source("experiments/Hyperplane.R")
  df_results <- rbind(df_results,df1)
  
}
write.csv(df_results,file=paste0(experiment_result_path,"results.csv"),row.names = FALSE)


source("experiments/utils.R")


jj <- jj # Batch bölüntüleme için, 2:5, 3:10
batch_sizes <- split_data_simple(data,jj)
number_of_batch <- ceiling((batch_sizes$total-batch_sizes$train_set-batch_sizes$test_set)/batch_sizes$test_set)



data_sudden <- data
acc <- c()
L2 <- c()
PDI <- c()
L2_der <- c()

profile_list <- list()
L2_list <- list()
PDI_list <- list()
L2der_list <- list()
data_sudden <- data
type= "partial"
set.seed(123)
first_interval <- 1:(batch_sizes$train_set)
test_interval <- max(first_interval):max(first_interval+batch_sizes$test_set)
rf <- glm(as.factor(class)~ ., data = data_sudden[first_interval,],family="binomial")
rf1 <- rf
test_preds <- predict(rf,data_sudden[test_interval,],type="response")
train_preds <- predict(rf,data_sudden[first_interval,], type = "response")
test_preds<- ifelse(test_preds>0.5,2,1)
train_preds<- ifelse(train_preds>0.5,2,1)

test_accuracy <- mean(test_preds==data_sudden[test_interval,]$class )
print(test_accuracy)
train_accuracy <- mean(train_preds==data_sudden[first_interval,]$class )
print(train_accuracy)
# Extract the coefficients excluding the intercept
coefficients <- rf$coefficients[-1]  # -1 excludes the intercept

# Find the feature with the largest absolute coefficient
most_important <- names(which.max(abs(coefficients)))

explainer_base_train <- DALEX::explain(model = rf,  
                                       data = data_sudden[first_interval,], 
                                       y =  data_sudden[first_interval,]$class, 
                                       verbose=FALSE,
                                       label="Base Train")
model_profile_base_train <- model_profile(explainer_base_train,most_important,type)
profile1_train <- data.frame(x= c(model_profile_base_train$agr_profiles$`_x_`),
                             y= c(model_profile_base_train$agr_profiles$`_yhat_`))


explainer_base <- DALEX::explain(model = rf,  
                                 data = data_sudden[test_interval,],  
                                 y =  data_sudden[test_interval,]$class, 
                                 verbose=FALSE,
                                 label="Base Test")

model_profile_base <- model_profile(explainer_base,most_important,type)
profile1 <- data.frame(x= c(model_profile_base$agr_profiles$`_x_`),
                       y= c(model_profile_base$agr_profiles$`_yhat_`))

metrics <- metric_list_cal(profile1_train,profile1)
pdi_cutoff <- metrics$PDI
l2_cutoff <- metrics$L2
l2_der_cutoff <- metrics$L2Der


print(  plot(model_profile_base_train,model_profile_base))
p1 <- plot1(profile1_train,"Train",profile1, "Test",most_important) +
  ggtitle(paste("Train/Test", "-",
                "Accuracy:",round(test_accuracy,2),"-",
                "PDI:",round(pdi_cutoff,2),"-",
                "L2Der:",round(l2_der_cutoff,2),"-",
                "L2:",round(l2_cutoff,2)
  ))
plot_list <- list()

plot_list[[1]]<- p1
save_plot(experiment_result_path, number_of_batch,
          test_accuracy, pdi_cutoff, l2_der_cutoff,
          l2_cutoff, p1)

inc_size <- batch_sizes$test_set
acc_list_pdi <- list()
acc_list_index <- 1
data_new <- data_sudden[1:max(test_interval),]
drift_number <- 0
start <- Sys.time()
for(interval_i in seq(max(test_interval),length(data_sudden$class),by=inc_size)){
  set.seed(123)
  new_interval <- interval_i:(interval_i+inc_size)
  preds_temp <- predict(rf,data_sudden[new_interval,], type = "response")
  preds_temp <- ifelse(preds_temp>0.5,2,1)
  acc_temp <- mean(preds_temp==data_sudden[new_interval,]$class,na.rm=TRUE )
  # acc_temp <- RMSE(preds_temp,data_sudden[new_interval,]$class, )
  acc_list_pdi[[acc_list_index]] <- acc_temp
  

  explainer_temp <- DALEX::explain(model = rf,  
                                   data = data_sudden[new_interval,],  
                                   y =  data_sudden[new_interval,]$class, 
                                   verbose=FALSE,
                                   label="temp")
  model_profile_temp <- model_profile(explainer_temp,most_important,type=type)
  profile2 <- data.frame(x= c(model_profile_temp$agr_profiles$`_x_`),
                         y= c(model_profile_temp$agr_profiles$`_yhat_`))
  
  if(length(profile2$x) < 5 | length(profile1$x) < 5){
    pdi_temp <- 1
    l2_temp <- 999
    l2_der_temp <- 999
  }else{
    metrics <- metric_list_cal(profile1,profile2)
    pdi_temp <- metrics$PDI
    l2_temp <- metrics$L2
    l2_der_temp <- metrics$L2Der
  }
  
  message(title(acc_temp, pdi_temp, l2_der_temp, l2_temp))
  print(plot(model_profile_base,model_profile_temp) +
          ggtitle(title(acc_temp, pdi_temp, l2_der_temp, l2_temp)))
  
  if(pdi_temp >pdi_cutoff*1.0 & l2_temp >l2_cutoff*1.0 & l2_der_temp > l2_der_cutoff*1.0){
    message(title("Cutoff", pdi_cutoff, l2_der_cutoff, l2_cutoff))
    
    drift_number <- drift_number+1
 
    p2 <- plot1(profile2 = profile2, test = "New Batch",
                profile1 = profile1, train = "Old Batch",
                most_important) +
      ggtitle(paste("Index:",acc_list_index,"-",
                    "Accuracy:",round(acc_temp,2),"-",
                    "PDI:",round(pdi_temp,2),"-",
                    "L2Der:",round(l2_der_temp,2),"-",
                    "L2:",round(l2_temp,2)
      ))
    plot_list[[drift_number+1]] <- p2
    save_plot(experiment_result_path, number_of_batch,
              test_accuracy, pdi_temp, l2_der_temp,
              l2_temp, p2)
    message("new model training")
    
    data_new <- rbind(
      data_sudden[new_interval, ],
      data_new)  
    print(nrow(data_new))
    set.seed(123)
    rf <- glm(as.factor(class) ~ ., data = data_new,family="binomial")
    explainer_base <- DALEX::explain(model = rf,
                                     data = data_new,
                                     y =  data_new$class,
                                     verbose=FALSE,
                                     label=paste("New Trained",nrow(data_new)))
    
    model_profile_base <- model_profile(explainer_base,most_important,type)
    profile1 <- data.frame(x= c(model_profile_base$agr_profiles$`_x_`),
                           y= c(model_profile_base$agr_profiles$`_yhat_`))
  }
  acc_list_index <- acc_list_index + 1
  
}

save_plots(plot_list,
           experiment_result_path,
           number_of_batch,
           round(mean(unlist(acc_list_pdi),na.rm=TRUE),2))

run_drift_detection <- function(model_type, rf1, data_sudden, test_interval, inc_size) {
  set.seed(123)
  rf <- rf1
  
  ddm <- switch(model_type,
                "HDDM_A" = HDDM_A$new(),
                "HDDM_W" = HDDM_W$new(),
                "KSWIN" = KSWIN$new(),
                "PageHinkley" = PageHinkley$new(),
                "DDM" = DDM$new(),
                "EDDM" = EDDM$new(),
                stop("Unknown model type"))
  
  acc_list <- list()
  acc_list_index <- 1
  data_new <- data_sudden[1:max(test_interval),]
  drift_number <- 0
  start <- Sys.time()
  for(interval_i in seq(max(test_interval), length(data_sudden$class), by=inc_size)){
    # ddm$reset()
    
    new_interval <- interval_i:(interval_i + inc_size)
    set.seed(1234)
    
    preds_temp <- predict(rf, data_sudden[new_interval,],type="response")
    preds_temp<- ifelse(preds_temp>0.5,2,1)
    
    acc_temp <- mean(preds_temp == data_sudden[new_interval,]$class, na.rm = TRUE)
    acc_list[[acc_list_index]] <- acc_temp
    acc_list_index <- acc_list_index + 1
    data_stream <- na.omit(1 - (data_sudden[new_interval,]$class == preds_temp))
    
    tryCatch({
      for (i in seq_along(data_stream)) {
        try(ddm$add_element(data_stream[i]))
        if (ddm$change_detected) {
          drift_number <- drift_number + 1
          # message(paste("Drift detected!", i, interval_i, round(acc_temp, 2)))
          # message("new model training")
          data_new <- rbind(data_sudden[new_interval, ], data_new)
          # print(nrow(data_new))
          set.seed(123)
          rf <- glm(as.factor(class) ~ ., data = data_new,family="binomial")
          ddm$reset()
          break
        }
      }
    }, error = function(e) {
      message("Error detected: ", e$message)
    })
  }
  runtime <- Sys.time() - start
  
  mean_acc <- rowMeans(as.data.frame(acc_list), na.rm = TRUE)
  
  list(mean_accuracy = mean_acc, drift_count = drift_number,runtime = runtime)
}
# Fonksiyonu çağırmak için örnek kullanım:
result_hddm_a <- run_drift_detection("HDDM_A", rf1, data_sudden, test_interval, inc_size)
result_hddm_w <- run_drift_detection("HDDM_W", rf1, data_sudden, test_interval, inc_size)
result_kswin <- run_drift_detection("KSWIN", rf1, data_sudden, test_interval, inc_size)
result_page_hinkley <- run_drift_detection("PageHinkley", rf1, data_sudden, test_interval, inc_size)
result_ddm <- run_drift_detection("DDM", rf1, data_sudden, test_interval, inc_size)
result_eddm <- run_drift_detection("EDDM", rf1, data_sudden, test_interval, inc_size)


results_list <- list(
  HDDM_A = result_hddm_a,
  HDDM_W = result_hddm_w,
  KSWIN = result_kswin,
  PageHinkley = result_page_hinkley,
  DDM = result_ddm,
  EDDM = result_eddm
)

# Listeyi data.frame'e dönüştürün
results_df <- do.call(rbind, lapply(names(results_list), function(name) {
  data.frame(Model = name,
             Mean_Accuracy = results_list[[name]]$mean_accuracy,
             Drift_Count = results_list[[name]]$drift_count)
}))
df <-  rbind(results_df,data.frame(Model = "PDD", Mean_Accuracy =rowMeans(as.data.frame(acc_list_pdi), na.rm = TRUE), Drift_Count = drift_number ),
              data.frame(Model = "Base Test", Mean_Accuracy=test_accuracy,Drift_Count = "0"),
              data.frame(Model = "Base Train", Mean_Accuracy=train_accuracy,Drift_Count = "0"),
              data.frame(Model = "batch sizes", Mean_Accuracy= as.integer(batch_sizes$train_set),Drift_Count = batch_sizes$test_set)
)
df$Mean_Accuracy <- format(df$Mean_Accuracy, scientific = FALSE)
df <- cbind(df,Batch = number_of_batch,most_important)




models_glm_varImp<-data.frame(1:90)

#Pm_m as Pm_sdm_geo or Pm_sdm_ocn

for (i in 1:30) {
  
#GLM 
  
  glm_varImp <- getVarImp(Pm_m,id={i},wtest = "training")
  
  capture.output(glm_varImp,file=paste0("/train/glm_varImp_",i,"train",".csv"))
 
  } 
  
#GAM
  
for (i in 31:60) {

 gam_varImp <- getVarImp(Pm_m,id={i},wtest = "training")
  
  capture.output(gam_varImp,file=paste0("/train/gam_varImp_",i,"train",".csv"))
  
}
 

#MARS
  
for (i in 61:90) {
  
  mars_varImp <- getVarImp(Pm_m,id={i},wtest = "training")
  
  capture.output(mars_varImp,file=paste0("/train/mars_varImp_",i,"train",".csv"))
  
}

  


varImp_glm_dataset<-data.frame()
varImp_gam_dataset<-data.frame()
varImp_mars_dataset<-data.frame()







#GLM
for (i in 1:30){
  
  file_glm<-paste0("/train/glm_varImp_",i,"train",".csv")
  temp_dataset <-read.csv(file_glm,header = TRUE,skip=5,sep="")
  varImp_glm_dataset<-rbind(varImp_glm_dataset, temp_dataset)
  rm(temp_dataset)
  }



#GAM
for (i in 31:60){
  
  file_gam<-paste0("/train/gam_varImp_",i,"train",".csv")
  
  temp_dataset <-read.csv(file_gam,header = TRUE,skip=5 ,sep="")
  varImp_gam_dataset<-rbind(varImp_gam_dataset, temp_dataset)
  rm(temp_dataset)
}


#MARS
for (i in 61:90){
  
  file_mars<-paste0("/train/mars_varImp_",i,"train",".csv")
  
  temp_dataset <-read.csv(file_mars,header = TRUE,skip=5 ,sep="")
  varImp_mars_dataset<-rbind(varImp_mars_dataset, temp_dataset)
  rm(temp_dataset)
}


dataset_varImp <- cbind(varImp_glm_dataset,varImp_gam_dataset,varImp_mars_dataset)

names(dataset_varImp)<-c("variables_glm","corTrain_glm","AUCtrain_glm","variables_gam","corTrain_gam","AUCtrain_gam","variables_mars","corTrain_mars","AUCtrain_mars")

write.csv(dataset_varImp,file="/train/dataset_varImptrain.csv")







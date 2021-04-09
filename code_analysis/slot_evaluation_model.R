


#Slot Evaluation Model


models_glm_AUC<-data.frame(1:30)
models_gam_AUC<-data.frame(1:30)
models_mars_AUC<-data.frame(1:30)

#Pm_m as Pm_sdm_geo or Pm_sdm_ocn

for (i in 1:30) {
 
#GLM 
   
slot_glm <- Pm_m@models$n$glm
slot_evaluation <- slot(slot_glm[[i]],"evaluation")

slot_AUC <- slot_evaluation$training@statistics$AUC

models_glm_AUC[i,] <- slot_AUC

names(models_glm_AUC)<-"glm"

#GAM
slot_gam <- Pm_m@models$n$gam
slot_evaluation <- slot(slot_gam[[i]],"evaluation")

slot_AUC <- slot_evaluation$training@statistics$AUC

models_gam_AUC[i,] <- slot_AUC

names(models_gam_AUC)<-"gam"


#MARS

slot_mars <- Pm_m@models$n$mars
slot_evaluation <- slot(slot_mars[[i]],"evaluation")

slot_AUC <- slot_evaluation$training@statistics$AUC

models_mars_AUC[i,] <- slot_AUC

names(models_mars_AUC)<-"mars"

  
}


models_list<- list(models_glm_AUC,models_gam_AUC, models_mars_AUC)




glm_model<-Pm_m@models$n$glm
gam_model <- Pm_m@models$n$gam
mars_model<- Pm_m@models$n$mars

slot_model<-function(x){
  slot_evaluation<-slot(x[[i]],"evaluation")
  slot_AUC<-slot_evaluation$training@statistics$AUC
  models_AUC[i,]<-slot_AUC
  names(models_AUC)<- paste(x)
  
}

slot_glm2<-slot_model(glm)


#Save slots

capture.output(slot_glm,file="/train/slot_glm_test.txt")

capture.output(slot_gam,file="/train/slot_gam_test.txt")

capture.output(slot_mars,file="/train/slot_mars_test.txt")



#save AUCs per model type

capture.output(models_glm_AUC,file="/train/models_glm_AUCtest.txt")

capture.output(models_gam_AUC,file="/train/models_gam_AUCtest.txt")

capture.output(models_mars_AUC,file="/train/models_mars_AUCtest.txt")


#AUC boxplots

models_AUC<-cbind(models_glm_AUC,models_gam_AUC,models_mars_AUC)

capture.output(models_AUC,file="/train/models_AUCtest.txt")

boxplot(models_AUC)


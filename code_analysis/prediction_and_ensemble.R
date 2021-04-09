#Prediction and Ensemble with sdm package
#Models selected: GLM, GAM and MARS. 


lst<-list.files("/predictors_geo",pattern="asc$",full.names=T)
preds<-stack(lst)


Pm<-shapefile("/sightings/Pm.shp")


Pm_sdmData<-sdmData(n~latitude+aspect+bathymetry+dcanyon+dcs+dcsh+dcr+dfan+dmtlow+dmtmhigh+dmtvlow+slope,
                    train=Pm,
                    predictors=preds,
                    bg=list(n=1000,method='gRandom',remove=TRUE))
                    

Pm_sdm_geo<-sdm(n~latitude+dcanyon+dcs+dcsh+dfan+dcr,
                data=Pm_sdmData,
                methods=c("glm","gam","mars"),
                replication="cv",
                cv.folds=3,n=10)

Pm_sdm_ocn<-sdm(n~bathymetry+aspect+slope,data=Pm_sdmData,
                 methods=c("glm","gam","mars"),
                 replication="cv",
                 cv.folds=3,n=10)


Pm_geo_predict<-predict(Pm_sdm_geo,newdata=preds,mean=TRUE,
                        filename="/Pm_geo_predict",overwrite=TRUE)
                        
Pm_ocn_predict<-predict(Pm_sdm_ocn,newdata=preds,mean=TRUE,
                        filename="/Pm_ocn_predict",overwrite=TRUE)
                        
                        
Pm_geo_ensemble<-ensemble(Pm_sdm_geo,newdata=preds,mean=TRUE,
                          filename="/Pm_geo_ensemble",
                          setting=list(method="weighted",stat="AUC"),overwrite=TRUE)

Pm_ocn_ensemble<-ensemble(Pm_sdm_ocn,newdata=preds,mean=TRUE,
                          filename="/Pm_ocn_ensemble",setting=list(method="weighted",stat="AUC"),overwrite=TRUE)







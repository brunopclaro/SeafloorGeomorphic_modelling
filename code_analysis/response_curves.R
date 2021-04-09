#Response curves

#For Pm_sdm_geo

  #GLM



rcurve_GLM_geom<-rcurve(Pm_sdm_geo,id=1:30,n=c("latitute","dcanyon","dcs","dcsh","dfan","dcr"), confidence=0.95, mean=TRUE, gg=TRUE,
                        main="GLM", ylab="Relative Variable Importance AUC")

ggsave(rcurve_GLM_geom, filename="/train/rcurve_GLM_geom.png")




#GAM


rcurve_GAM_geom<-rcurve(Pm_sdm_geo,id=31:60,n=c("latitute","dcanyon","dcs","dcsh","dfan","dcr"), confidence=0.95, mean=TRUE, gg=TRUE,
                        main="GAM", ylab="Relative Variable Importance AUC")

ggsave(rcurve_GAM_geom, filename="/train/rcurve_GAM_geom.png")





#MARS



rcurve_MARS_geom<-rcurve(Pm_sdm_geo,id=61:90,n=c("latitute","dcanyon","dcs","dcsh","dfan","dcr"), confidence=0.95, mean=TRUE, gg=TRUE,
			main="MARS", ylab="Relative Variable Importance AUC")

ggsave(rcurve_MARS_geom, filename="/train/rcurve_MARS_geom.png")









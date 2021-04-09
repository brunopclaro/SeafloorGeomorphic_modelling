
#The use of AUC in evaluating SDMs has been criticized (Lobo et al. 2008, Jiménez-Valverde 2011). A particularly
#sticky problem is that the values of AUC vary with the spatial extent used to select background points. Generally,
#the larger that extent, the higher the AUC value. Therefore, AUC values are generally biased and cannot be directly
#compared. Hijmans (2012) suggests that one could remove “spatial sorting bias” (the difference between the distance
#from testing-presence to training-presence and the distance from testing-absence to training-presence points) through
#“point-wise distance sampling”.



predsvals<-extract(preds,Pm)

set.seed(0)
backgr <- randomPoints(preds, 500)

nr <- nrow(Pm)
s <- sample(nr, 0.25 * nr)
pres_train <- Pm[-s, ]
pres_test <- Pm[s, ]



nr <- nrow(backgr)
set.seed(9)
s <- sample(nr, 0.25 * nr)
back_train <- backgr[-s, ]
back_test <- backgr[s, ]


sb <- ssb(pres_test, back_test, pres_train)

sb[,1] / sb[,2]    #sb[,1] / sb[,2] is an indicator of spatial sorting bias (SSB). If there is no SSB this value should be 1, in these
                     #data it is close to zero, indicating that SSB is very strong.
p 
0.977009 #no SSB!!





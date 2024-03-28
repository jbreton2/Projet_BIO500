
#Table avec le nom scientifique, le rang, le nom vernaculaire en anglais, le nom vernaculaire en français, le règne, l'embranchement, la classe, l'ordre, la famille et le genre pour chaque espèce
#Unique pour chaque espèce
clef_especes<-function(donnee){
  especes<-unique(donnee[,c(8:17)])
  write.csv(especes, file="especes.csv")
  return(especes)
}

#Table avec l'identifiant, la latitude et l'encoding pour chaque site
clef_site<-function(donnee){
  id<-unique(donnee[,c(1:2)])
  sites<-data.frame(id,SCRS=6622) #SCRS ou projection comme titre de la colonne
  write.csv(sites, file="sites.csv")
  return(sites)
}

#Table avec l'identifiant du temps, le temps de départ, le temps de fin et la date pour chaque temps de départ
clef_temps<-function(donnee){
  time<-unique(donnee[,c(3:5)])
  temps<-data.frame(time_id=c(1:nrow(time)),time)
  write.csv(temps, file="temps.csv")
  return(temps)
}

#Table avec l'identifiant du site, l'identifiant du temps, le temps de l'observation et le nom scientifique de l'espèce pour chaque observation (ligne du data frame)
clef_obs<-function(donnee,temps){
  id_temps<-data.frame()
  for(i in 1:nrow(donnee)){
    id_tim<-temps[temps[,2]==donnee[i,3]&temps[,3]==donnee[i,4]&temps[,4]==donnee[i,5],]
    id_temps[i,1]<-id_tim[,1]
  }
  obs<-data.frame(id_temps,donnee[,c(1,6,8)])
  colnames(obs)[1]<-"temps_id"
  write.csv(obs, file="observations.csv")
  return(obs)
}




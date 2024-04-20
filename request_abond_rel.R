
table.abond.rel<-function(connexion.SQL){
  
  request.nb_obs_temp<- "
    SELECT valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat <= 48
    GROUP BY valid_scientific_name
    ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_temp<-dbGetQuery(connexion.SQL,request.nb_obs_temp)
  
  request.nb_obs_bor<- "
    SELECT valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 48 AND lat <= 58
    GROUP BY valid_scientific_name
    ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_bor<-dbGetQuery(connexion.SQL,request.nb_obs_bor)
  
  request.nb_obs_arct<- "
    SELECT valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 58
    GROUP BY valid_scientific_name
    ORDER BY valid_scientific_name
    ; "
  
  nb.obs_pour_arct<-dbGetQuery(connexion.SQL,request.nb_obs_arct)
  
  abondance_relative<-data.frame(zone=" ", espece=" ",abondance_relative=0)
  for(i in 1:3) { # boucle pour les zones
    n <-1
    h <-1
    if (i==1){   
      for(j in 1: nrow(nb.obs_pour_temp)) {
      abondance_relative[j,1]<-"temperee"
      abondance_relative[j,2]<-nb.obs_pour_temp[j,1] #mettre le nom des especes dans le data frame
      abondance_relative[j,3]<-(nb.obs_pour_temp[j,2])/sum(nb.obs_pour_temp$nombre.observations)*100
      }
    }
    else if(i==2){
      for(t in (1+nrow(nb.obs_pour_temp)): (nrow(nb.obs_pour_bor)+nrow(nb.obs_pour_temp))) {
      abondance_relative[t,1]<-"boreale"
      abondance_relative[t,2]<-nb.obs_pour_bor[n,1] #mettre le nom des especes dans le data frame
      abondance_relative[t,3]<-(nb.obs_pour_bor[n,2])/sum(nb.obs_pour_bor$nombre.observations)*100
      n <-n+1
    }
    }
    
    else if(i==3){
      for(z in (1+nrow(nb.obs_pour_temp)+nrow(nb.obs_pour_bor)) : (nrow(nb.obs_pour_temp)+nrow(nb.obs_pour_bor)+nrow(nb.obs_pour_arct))) { 
      abondance_relative[z,1]<-"arctique"
      abondance_relative[z,2]<-nb.obs_pour_arct[h,1] #mettre le nom des especes dans le data frame
      abondance_relative[z,3]<-(nb.obs_pour_arct[h,2])/sum(nb.obs_pour_arct$nombre.observations)*100
      h <-h+1
      }
   }
   }
  
  
  dbDisconnect(connexion.SQL)
  
  return(abondance_relative)
}

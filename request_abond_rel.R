
table.abond.rel<-function(connexions.SQL){
  
  
  ## est-ce que j'ai besoin des latitudes pour pouvoir les classer?
  request.nb_obs_temp<- "
    SELECT lat, valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat <= 48
    GROUP BY valid_scientific_name
    #ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_temp<-dbGetQuery(connexion.SQL,request.nb_obs_temp)
  
  request.nb_obs_bor<- "
    SELECT lat, valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 48 AND lat <= 58
    GROUP BY valid_scientific_name
    #ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_bor<-dbGetQuery(connexion.SQL,request.nb_obs_bor)
  
  request.nb_obs_arct<- "
    SELECT lat, valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 58
    GROUP BY valid_scientific_name
   #ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_arct<-dbGetQuery(connexion.SQL,request.nb_obs_arct)
  
  request.nb_obs_tot<-"
  SELECT COUNT (observations.site_id)
  FROM observations
  #INNER JOIN sites ON observations.site_id = sites.site_id
  #est-ce que je peux mettre INNER JOIN?
  ; "
  nb.obs_total<-dbGetQuery(connexion.SQL,request.nb_obs_tot)
  
  
  request.nb_esp_tot<-"
  SELECT COUNT(valid_scientific_name)
  FROM observations; "
  
  nb.esp_total<-dbGetQuery(connexion.SQL,request.nb_esp_tot)
  
  j <- 1 #nb d'especes
  k <- 3 #nb de zones?
  abondance_relative<-data.frame(zone=" ", espece=" ",abondance_relative=0)
  for(i in k) {# boucle pour les zones
   for(j in nb.esp_total) {
    if (i==1){
      abondance_relative[j,1]<-"temperee"
      abondance_relative[j,2]<-nb.obs_pour_temp[valid_scientific_name[,j]] #mettre le nom des especes dans le data frame
      abondance_relative[j,3]<-(nb.obs_pour_temp[nombre_observations[,j]])/nb.obs_total*100
    }
    else if(i==2){
      abondance_relative[j,1]<-"boreale"
      abondance_relative[j,2]<-nb.obs_pour_bor[valid_scientific_name[,j]] #mettre le nom des especes dans le data frame
      abondance_relative[j,3]<-(nb.obs_pour_bor[nombre_observations[,j]])/nb.obs_total*100
    }
    else{
      abondance_relative[j,1]<-"arctique"
      abondance_relative[j,2]<-nb.obs_pour_arct[valid_scientific_name[,j]] #mettre le nom des especes dans le data frame
      abondance_relative[j,3]<-(nb.obs_pour_artc[nombre_observations[,j]])/nb.obs_total*100
    }
     j<-j+1
   }
    i<-i+1
  }
  
  dbDisconnect(connexion.SQL)
  
  return(abondance_relative)
}


table.abond.rel<-function(connexion.SQL){
  
  connexion.SQL <- dbConnect(SQLite(), dbname="oiseaux.db")
  
  # Création table contenant les espèces et le nombre de fois que chaque espèces (GROUP BY) ont été vue dans la zone tempérée. 
  # La zone tempérée est délimiter (WHERE) par toutes les zones qui se trouvent sous la latitude 48.
  
  request.nb_obs_temp<- "
    SELECT valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat <= 48
    GROUP BY valid_scientific_name
    ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_temp<-dbGetQuery(connexion.SQL,request.nb_obs_temp)
  
  
  # Même principe que la première table, mais pour la zone boréale (se trouvant entre les latitudes 48 et 58).
  
  request.nb_obs_bor<- "
    SELECT valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 48 AND lat <= 58
    GROUP BY valid_scientific_name
    ORDER BY valid_scientific_name
  ; "
  
  nb.obs_pour_bor<-dbGetQuery(connexion.SQL,request.nb_obs_bor)
  
  
  # Même principe que la première table, mais pour la zone arctique (se trouvant au-dessus de la latitude 58).
  
  request.nb_obs_arct<- "
    SELECT valid_scientific_name, COUNT (DISTINCT(observations.site_id)) AS nombre_observations
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 58
    GROUP BY valid_scientific_name
    ORDER BY valid_scientific_name
    ; "
  
  nb.obs_pour_arct<-dbGetQuery(connexion.SQL,request.nb_obs_arct)
  
  # Création d'une table contenant la zone écologique, l'espèce observée et l'abondance relative (le nombre de fois que l'espèce a été vue).
  
  abondance_relative<-data.frame(zone=" ", espece=" ",abondance_relative=0)
  for(i in 1:3) { # Boucle pour les zones (1 = Tempérée, 2 = Boréale et 3 = Arctique).
    
    n <-1         # Sert pour la boucle de boréale.
    h <-1         # Sert pour la boucle de arctique.
   
    
    if (i==1){   
       
       # Boucle de la zone tempérée
       for(j in 1: nrow(nb.obs_pour_temp)) { 
      abondance_relative[j,1]<-"temperee"
      abondance_relative[j,2]<-nb.obs_pour_temp[j,1] # Mettre le nom des espèces dans le data frame abondance_relative.
      abondance_relative[j,3]<-(nb.obs_pour_temp[j,2])/sum(nb.obs_pour_temp[,2])*100 # Calcule de l'abondance relative d'observation (Nombre de fois observé / Nombre d'observation totale dans la zone tempérée).
      }
    }
    
    
    else if(i==2){
      
      # Boucle de la zone Boréale
      for(t in (1+nrow(nb.obs_pour_temp)): (nrow(nb.obs_pour_bor)+nrow(nb.obs_pour_temp))) {
      abondance_relative[t,1]<-"boreale"
      abondance_relative[t,2]<-nb.obs_pour_bor[n,1] # Mettre le nom des espèces dans le data frame abondance_relative.
      abondance_relative[t,3]<-(nb.obs_pour_bor[n,2])/sum(nb.obs_pour_bor[,2])*100 # Calcule de l'abondance relative d'observation (Nombre de fois observé / Nombre d'observation totale dans la zone boréale).
      n <-n+1
      }
    }
    
    
    else if(i==3){
      
      # Boucle de la zone arctique
      for(z in (1+nrow(nb.obs_pour_temp)+nrow(nb.obs_pour_bor)) : (nrow(nb.obs_pour_temp)+nrow(nb.obs_pour_bor)+nrow(nb.obs_pour_arct))) { 
      abondance_relative[z,1]<-"arctique"
      abondance_relative[z,2]<-nb.obs_pour_arct[h,1] # Mettre le nom des espèces dans le data frame
      abondance_relative[z,3]<-(nb.obs_pour_arct[h,2])/sum(nb.obs_pour_arct[,2])*100 # Calcule de l'abondance relative d'observation (Nombre de fois observé / Nombre d'observation totale dans la zone arctique).
      h <-h+1
      }
    }
  }
  
  # Déconnexion
  dbDisconnect(connexion.SQL)
  
  return(abondance_relative)

}



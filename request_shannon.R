Shannon<-function(){
  
  connexion.SQL <- dbConnect(SQLite(), dbname="oiseaux.db")
  
  #Requête liste des sites
  request.site <- "
    SELECT observations.site_id, lat
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  nb_site <- dbGetQuery(connexion.SQL,request.site)
  
  #Requête nombre d'observation de la même espèce par site
  request.nb_esp <- "
    SELECT observations.site_id, lat, valid_scientific_name, COUNT(valid_scientific_name)
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    GROUP BY sites.site_id, valid_scientific_name
    ORDER BY lat ASC;"
  
  nb_par_esp <- dbGetQuery(connexion.SQL,request.nb_esp)
  
  #Calcul de l'indice de Shannon
  j <- 1
  indice_shannon<-data.frame(site=0,lat=0,shannon=0)
  for (i in nb_site[,1]) {
    indice_shannon[j,1]<-i
    indice_shannon[j,2]<-nb_site[j,2]
    par_site<-nb_par_esp[nb_par_esp[,1]==i,]
    indice_shannon[j,3]<-diversity(par_site[,4], index = "shannon")
    j<-j+1
  }
  
  dbDisconnect(connexion.SQL)
  
  return(indice_shannon)
}

Shanon<-function(connexion.SQL){
  
  request.site <- "
    SELECT observations.site_id, lat
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  nb_site <- dbGetQuery(connexion.SQL,request.site)
  
  request.nb_esp <- "
    SELECT observations.site_id, lat, valid_scientific_name, COUNT(valid_scientific_name)
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    GROUP BY sites.site_id, valid_scientific_name
    ORDER BY lat ASC;"
  
  nb_par_esp <- dbGetQuery(connexion.SQL,request.nb_esp)
  
  j <- 1
  indice_shanon<-data.frame(site=0,lat=0,shanon=0)
  for (i in nb_site[,1]) {
    indice_shanon[j,1]<-i
    indice_shanon[j,2]<-nb_site[j,2]
    par_site<-nb_par_esp[nb_par_esp[,1]==i,]
    indice_shanon[j,3]<-diversity(par_site[,4], index = "shannon")
    j<-j+1
  }
  
  dbDisconnect(connexion.SQL)
  
  return(indice_shanon)
}

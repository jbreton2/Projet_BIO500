
table.rich.sp <- function(connexion.SQL){
  
  request.rich.tot <- "
    SELECT observations.site_id, lat, COUNT(DISTINCT(valid_scientific_name)) AS richesse_sp
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  rich.sp.tot <- dbGetQuery(connexion.SQL,request.rich.tot)
  
  request.rich.temp <- "
    SELECT observations.site_id, lat, COUNT(DISTINCT(valid_scientific_name)) AS richesse_sp
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat <= 48
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  rich.sp.temp <- dbGetQuery(connexion.SQL,request.rich.temp)
  
  request.rich.bor <- "
    SELECT observations.site_id, lat, COUNT(DISTINCT(valid_scientific_name)) AS richesse_sp
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 48 AND lat <= 55
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  rich.sp.bor <- dbGetQuery(connexion.SQL,request.rich.bor)
  
  request.rich.arct <- "
    SELECT observations.site_id, lat, COUNT(DISTINCT(valid_scientific_name)) AS richesse_sp
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    WHERE lat > 55
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  rich.sp.arct <- dbGetQuery(connexion.SQL,request.rich.arct)
  
  return(list(global = rich.sp.tot, tempéré = rich.sp.temp, boréale = rich.sp.bor, arctique = rich.sp.arct))

  }





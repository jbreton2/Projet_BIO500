
table.rich.sp <- function(connexion.SQL){
  
  connexion.SQL <- dbConnect(SQLite(), dbname="oiseaux.db")
  
  # Création d'une table qui contient le site.ID, la latitude de chaque site et la richesse spécifique observée à chaque site.
  # La richesse spécifique est calculé en prenant le nombre (COUNT) d'espèces différentes (DISTINCT) observée par site (GROUP BY).
  # Finalement, pour avoir une meilleure vision des résultats dans la table, les données sont mise en ordre décroissant de latitude.
  
  request.rich.tot <- "
    SELECT observations.site_id, lat, COUNT(DISTINCT(valid_scientific_name)) AS richesse_sp
    FROM observations
    INNER JOIN sites ON observations.site_id = sites.site_id
    GROUP BY sites.site_id
    ORDER BY lat ASC;"
  
  rich.sp.tot <- dbGetQuery(connexion.SQL,request.rich.tot)
  
  # Déconnexion
  dbDisconnect(connexion.SQL)
  
  return(rich.sp.tot)

  }





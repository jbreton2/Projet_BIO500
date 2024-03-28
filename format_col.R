
type.format.col <- function(data.base){
  
  # Set site_id en valeur "integer" et Format déja bon
  data.base$site_id <- as.integer(data.base$site_id)
  
  # Set lat en valeur "real" et Format déja bon
  data.base$lat <- as.numeric(data.base$lat)
  
  # Time déja en "character" et Format déja bon (HH:MM:SS)
  
  # Format des données de la colonne date_obs en YYYY-MM-DD seulement quand il est incorrecte, sinon le laisser intact
  data.base$date_obs <- ifelse(!grepl("^\\d{4}-\\d{2}-\\d{2}$", data.base$date_obs),
                               format(as.Date(data.base$date_obs, format = "%d/%m/%Y"), "%Y-%m-%d"),
                               data.base$date_obs)
  
  # Set variable en valeur "boolean"
  data.base$variable <- as.logical(data.base$variable)
  
  # Valid, rank,vern, kingdom... sont déja en "Character" 
  
  return(data.base)
}





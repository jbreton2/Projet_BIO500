
verif.data <- function(data.base) {
  
  result <- list()
  
  # Verifie les valeurs manquantes pour l'intégralité de la base de données
  result$missing_values <- any(is.na(data.base))
  
  # Verifie pour les lignes qui seraient dupliquées et mentionne lesquelles le sont
  dup_rows <- which(duplicated(data.base) | duplicated(data.base, fromLast = TRUE))
  duplicated_data <- data.base[dup_rows, ]
  result$duplicated_rows <- duplicated_data
  
  # Verifie les erreurs de conversion (vérifie si un des caractères suivant se trouve dans les données)
  #result$erreurs_conv <- sapply(data.base, function(x) any(grepl("[éêôèÉâ?]", x))) 
  
  # Vérifie les types de données
  result$incorrect_data_types <- sapply(data.base, function(x) !inherits(x, c("numeric", "integer", "character","logical")))
  
  return(result)
  
}

                             
                             
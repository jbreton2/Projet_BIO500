
 # Création de la fonction qui va lire tous les fichier CSV en même temps
 read.all.csv <- function(chemin){
   
   # Liste de tous les fichiers ".csv" qui devront être lu en utilisant "chemin" comme working.directory
   fichiers <- list.files(path= chemin, pattern = "\\.csv$", full.names = TRUE)
   
   # Lecture des données dans de chaque fichiers se trouvant dans l'objet "fichiers" créé à la dernière étape et mise des données dans une liste compressée
   donnees_liste <-lapply(fichiers, read.csv)
   
   # Combinaison de toutes les listes ensemble dans une même base de données
   donnees_combine <- do.call(rbind, donnees_liste)
   
   return(donnees_combine)
}
  

  

 

 
 
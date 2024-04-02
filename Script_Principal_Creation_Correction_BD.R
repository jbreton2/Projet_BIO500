
################ Lecture des fichier csv regrouper en un Dataframe ###################
#Mettre le bon chemin
direction <- "C:/Users/Xavier/Documents/Université Sherbrooke/H2024/Méthode computationnelle/Projet/acoustique_oiseaux/oiseaux_test/Data"
direction<-"C:/Users/leaga/Documents/UdeS/H24/Prog/projet/oiseaux_test/Data"
direction<-"~/Library/CloudStorage/OneDrive-Personnel/BIO500/version2_crea_bd/acoustique_oiseaux"

source("read_all_csv.R")
data <- read.all.csv(direction)


################# Vérification des données initial ######################

source("verif_data.R")
results.deb <- verif.data(data)

# True signifie qu'il y a une erreur 
results.deb


################# Correction des données ####################

source("correction_bird.R")
data.cor <- correction.bird(data)


################# Changement de type et de format de données des colonnes (quand nécessaire) ######################

source("format_col.R")
data.final <- type.format.col(data.cor)


################# Vérification finale des données  ####################

source("verif_data.R")
results.fin <- verif.data(data.final)


################# Création des diff tables ######################

source("function_clef.R")
esp<-clef_especes(data.final)
time<-clef_temps(data.final)
site<-clef_site(data.final)
obs<-clef_obs(data.final, time)


#################Création base de données SQL####################

source("table_sql.R")
con <- table.sql(esp, site, time, obs)


#################################################################

# Requetes testant si les tables fonctionnent bien (* = tous les champs d'une tables)

sql_requete <- "
  SELECT *
  FROM especes;"

test1 <- dbGetQuery(con, sql_requete)
head(test1)

sql_requete <- "
  SELECT *
  FROM sites;"
test2 <- dbGetQuery(con, sql_requete)
head(test2)

sql_requete <- "
  SELECT *
  FROM temps;"
test3 <- dbGetQuery(con, sql_requete)
head(test3)

sql_requete <- "
  SELECT *
  FROM observations;"
test4 <- dbGetQuery(con, sql_requete)
head(test4)



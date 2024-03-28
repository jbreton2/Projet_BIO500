
################ Lecture des fichier csv regrouper en un Dataframe ###################
#Mettre le bon chemin
direction <- "C:/Users/Xavier/Documents/Université Sherbrooke/H2024/Méthode computationnelle/Projet/acoustique_oiseaux/oiseaux_test/Data"
direction<-"C:/Users/leaga/Documents/UdeS/H24/Prog/projet"
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


################# Vérification des données final ####################

source("verif_data.R")
results.fin <- verif.data(data.final)


################# Création des diff tables ######################

source("function_clef.R")
esp<-clef_especes(data.final)
time<-clef_temps(data.final)
site<-clef_site(data.final)
obs<-clef_obs(data.final, time)


#################Création base de données SQL####################

library(RSQLite)
con <- dbConnect(SQLite(), dbname="oiseaux.db")

#Création table d'espèces
table.esp<-  
"CREATE TABLE especes (
  valid_scientific_name         VARCHAR(50) PRIMARY KEY,
  rank                          VARCHAR(50),
  vernacular_en                 VARCHAR(50),
  vernacular_fr                 VARCHAR(50),
  kingdom                       VARCHAR(50),
  phylum                        VARCHAR(50),
  class                         VARCHAR(50),
  `order`                       VARCHAR(50),
  family                        VARCHAR(50),
  genus                         VARCHAR(50)
);"
dbSendQuery(con,table.esp)

#Au besoin
#dbSendQuery(con,"DROP TABLE especes;")

#Création table de sites
table.sites<-
"CREATE TABLE sites (
  site_id                       INTEGER PRIMARY KEY NOT NULL,
  lat                           REAL,
  SCRS                          INTEGER
);"
dbSendQuery(con,table.sites)


#Création table de temps
table.temps<-
  "CREATE TABLE temps (
  time_id                       INTEGER PRIMARY KEY NOT NULL,
  time_start                    TIME,
  time_finish                   TIME,
  date_obs                      DATE
);"
dbSendQuery(con,table.temps)

#Insertion des données dans les tables
dbWriteTable(con,append=TRUE,name="especes",value=esp,row.names=FALSE)
dbWriteTable(con,append=TRUE,name="sites",value=site,row.names=FALSE)
dbWriteTable(con,append=TRUE,name="temps",value=time,row.names=FALSE)

#Création table d'observations
table.obs <- 
  "CREATE TABLE observations (
    temps_id                INTEGER,
    site_id                 INTEGER,
    time_obs                TIME,
    valid_scientific_name   VARCHAR(50),
    PRIMARY KEY (temps_id, site_id, time_obs,valid_scientific_name),
    FOREIGN KEY (temps_id) REFERENCES temps(time_id),
    FOREIGN KEY (site_id) REFERENCES sites(site_id),
    FOREIGN KEY (valid_scientific_name) REFERENCES especes(valid_scientific_name)
);"
dbSendQuery(con,table.obs)
dbWriteTable(con,append=TRUE,name="observations",value=obs,row.names=FALSE)

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




table.sql <- function(donnees_especes, donnees_sites, donnees_temps, donnees_observations){ 
  
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
  
  
  #Création table de sites
  table.sites<-
    "CREATE TABLE sites (
    site_id                       INTEGER PRIMARY KEY NOT NULL,
    lat                           REAL CHECK(lat >=45 AND lat <=63),
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
  dbWriteTable(con,append=TRUE,name="especes",value=donnees_especes,row.names=FALSE)
  dbWriteTable(con,append=TRUE,name="sites",value=donnees_sites,row.names=FALSE)
  dbWriteTable(con,append=TRUE,name="temps",value=donnees_temps,row.names=FALSE)
  
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
  dbWriteTable(con,append=TRUE,name="observations",value=donnees_observations,row.names=FALSE)
  
  return(con)
}



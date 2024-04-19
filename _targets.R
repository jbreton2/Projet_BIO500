# ===========================================
# _targets.R file
# ===========================================
# Dépendances
library(targets)
library(rmarkdown)
library(RSQLite)
library(vegan)
library(tarchetypes)
#tar_option_set(packages = c())     Pour d'autres packages

# Scripts R
source("read_all_csv.R")
source("correction_bird.R")
source("format_col.R")
source("function_clef.R")
source("table_sql.R")
source("fonct_request_rich_sp.R")
source("request_shanon.R")


# Pipeline
list(
  
  tar_target(    # Établissement du path pour lire les données brutes
    name = path,
    command = "Data"
  ), 
  
  tar_target(    # Lecture des données et combiner en un dataframe
    name = data, 
    command = read.all.csv(path) 
  ),   
  
  tar_target(    # Correction des données
    name = data.cor,
    command = correction.bird(data)
  ),
  
  tar_target(    # Changement de format des données
    name = data.final, 
    command = type.format.col(data.cor) 
  ),
  
  tar_target(    # Création table Espèces
    name = esp,
    command = clef_especes(data.final)
  ),
  
  tar_target(    # Création table Time
    name = time,
    command = clef_temps(data.final)
  ),
  
  tar_target(    # Création table Sites
    name = site,
    command = clef_site(data.final)
  ),
  
  tar_target(    # Création table Observations
    name = obs,
    command = clef_obs(data.final, time)
  ),
  
  tar_target(     #Création base de données
    name = con,   
    command = table.sql(esp, site, time, obs)
  ),
  
  tar_target(     #Requêtes richesse spécifique
    name = res.rich.sp,   
    command = table.rich.sp(con)
  ),
  
  tar_target(     #Requêtes indice de Shanon
    name = indice.shanon,   
    command = Shanon(con)
  ),
  
  tar_render(     #Rapport
    name = rapport,         
    path = "rapport/rapport.Rmd"
  )
)

#1.fonction des analyses de donnees
#2.tar.render pour ficher rmarkdown




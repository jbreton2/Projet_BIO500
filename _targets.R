# ===========================================
# _targets.R file
# ===========================================
# Dépendances
library(targets)
library(rmarkdown)
library(RSQLite)
library(vegan)
library(tarchetypes)
library(ggplot2)
#tar_option_set(packages = c())     Pour d'autres packages

# Scripts R
source("read_all_csv.R")
source("correction_bird.R")
source("format_col.R")
source("function_clef.R")
source("table_sql.R")
source("fonct_request_rich_sp.R")
source("request_shannon.R")
source("request_abond_rel.R")

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
    command = table.rich.sp()
  ),
  
  tar_target(     #Requêtes indice de Shannon
    name = indice.shannon,   
    command = Shannon()
  ),
  
  tar_target(     #Requêtes abondance relative
    name = abondance.relative,   
    command = table.abond.rel()
  ),
  
  tar_render(     #Rapport
    name = rapport,         
    path = "rapport/rapport.Rmd"
  )
)







correction.bird <- function(data.base){
  
  # Changement en valeur logique de la colonne "variable"
  data.base$variable <- gsub("présence",T,data.base$variable)
  data.base$variable <- as.logical(data.base$variable)
  
  # Correction des noms vernaculaire anglais qui ne font pas de sens
  data.base$vernacular_en <- gsub("Animals","Winter wren", data.base$vernacular_en)
  data.base$vernacular_en <- gsub("Chordates","Northern harrier", data.base$vernacular_en)
  
  # Correction des noms vernaculaire (Anglais et Français) qui sont manquant 
  # À quelques reprises, les noms était manquant, ne rendant pas valid_scentific_name UNIQUE pour SQL
  for (i in 1: nrow(data.base)){
  
    if(data.base[i,8] =="Anatidae"){ # Quand valid_scentif_name = Anatidae
      data.base[i,10] = "Ducks"      # Mettre Ducks pour vernacular_en
      data.base[i,11] = "Canards"    # Mettre Canards pour vernacular_fr
    }
  
    if(data.base[i,8] =="Dryobates pubescens"){ # Même principe que 1er
      data.base[i,10] = "Downy woodpecker"
      data.base[i,11] = "Pic mineur"
    }
  
    if(data.base[i,8] =="Passeriformes"){ # Même principe que 1er
      data.base[i,10] = "Perching birds"
      data.base[i,11] = "Passereaux"
    }
  
    if(data.base[i,8] =="Vireo"){ # Même principe que 1er
      data.base[i,10] = "Vireos"
      data.base[i,11] = "Viréo"
    }
  
  }
  
  # Crée un objet contenant seulement les lignes qui sont dupliquées (dup.rows) et crée une nouvelle base de doné?e contenant des lignes uniques seulement
  dup.rows <- duplicated(data.base) | duplicated(data.base, fromLast = TRUE)
  unique.data <- data.base[!dup.rows | duplicated(data.base), ]
  
  # Refait la mme chose pour permettre d'enlever les duplication^s qui était là 3 fois (lignes précédentes enlève un des 3 lignes dupliquées donc en reste encore 2 lignes identiques)
  dup.rows2 <- duplicated(unique.data) | duplicated(unique.data, fromLast = TRUE)
  unique.data2 <- unique.data[!dup.rows2 | duplicated(unique.data), ]
  
  return(unique.data2)

}



















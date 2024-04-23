
fig.abon.rel<-function(donnees.ab.rel){ 
  library(ggplot2)
  
  # Création d'une base de données qui prend toutes les informations de la zone tempérée et qui est en ordre décroissant d'abondance relative.
  temperee.db <-donnees.ab.rel[donnees.ab.rel$zone=="temperee",]
  temperee.fin <-temperee.db[order(-temperee.db$abondance_relative),]
  
  # Création de la table contenant seulement les espèces qui feront les 15 premiers % d'observation de la zone tempérée.
  temp.fig <-data.frame(Zone=" ", Espèces=" ", Abondance_relative=0)
  
  # Boucle de la zone tempérée qui prend seulement les espèces qui ont des abondances relatives. 
  for (n in 1: nrow(temperee.fin)){
    if (sum(temp.fig[,3]) < 15) { # Prend la prochaine espèce si la somme des abondances relatives est plus petite que 15% (seuil établie).
      temp.fig[n,1]<-"temperee"
      temp.fig[n,2]<-temperee.fin[n,2]
      temp.fig[n,3]<-temperee.fin[n,3]
    }
    
    else { # Quand la somme des abondances relatives est plus de 15%.
      
      break # Arrêt de la boucle.
      
    }
  }
  
  # Création d'une base de données qui prend toutes les informations de la zone boréale et qui est en ordre décroissant d'abondance relative.
  bor.db <-donnees.ab.rel[donnees.ab.rel$zone=="boreale",]
  bor.fin<-bor.db[order(-bor.db$abondance_relative),]
  
  # Création de la table contenant seulement les espèces qui feront les 15 premiers % d'observation de la zone boréale.
  bor.fig <-data.frame(Zone=" ", Espèces=" ", Abondance_relative=0)
  
  # Boucle de la zone boréale qui prend seulement les espèces qui ont des abondances relatives. 
  for (n in 1: nrow(bor.fin)){
    if (sum(bor.fig[,3]) < 15) { # Prend la prochaine espèce si la somme des abondances relatives est plus petite que 15% (seuil établie).
      bor.fig[n,1]<-"boreale"
      bor.fig[n,2]<-bor.fin[n,2]
      bor.fig[n,3]<-bor.fin[n,3]
    }
    
    else { # Quand la somme des abondances relatives est plus de 15%.
      
      break # Arrêt de la boucle.
      
    }
  }
  
  # Création d'une base de données qui prend toutes les informations de la zone arctique et qui est en ordre décroissant d'abondance relative.
  arc.db <-donnees.ab.rel[donnees.ab.rel$zone=="arctique",]
  arc.fin<-arc.db[order(-arc.db$abondance_relative),]
  
  # Création de la table contenant seulement les espèces qui feront les 15 premiers % d'observation de la zone boréale.
  arc.fig <-data.frame(Zone=" ", Espèces=" ", Abondance_relative=0)
  
  # Boucle de la zone arctique qui prend seulement les espèces qui ont des abondances relatives. 
  for (n in 1: nrow(arc.fin)){
    if (sum(arc.fig[,3]) < 15) { # Prend la prochaine espèce si la somme des abondances relatives est plus petite que 15% (seuil établie).
      arc.fig[n,1]<-"arctique"
      arc.fig[n,2]<-arc.fin[n,2]
      arc.fig[n,3]<-arc.fin[n,3]
    }
    
    else { # Quand la somme des abondances relatives est plus de 15%.
      
      break # Arrêt de la boucle.
      
    }
  }
  
  
  db.fig<-rbind(temp.fig,bor.fig,arc.fig)
  
  
  # Création de la figure utilisant le package ggplot2
  plot_ab_rel <- ggplot(data=db.fig, aes(x=Zone, y=Abondance_relative, fill=Espèces))+ 
    geom_bar(aes(), stat="identity", position="stack")
  
  plot_ab_rel

}



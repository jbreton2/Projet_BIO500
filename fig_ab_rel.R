
fig.abon.rel<-function(donnees.ab.rel){ 
  library(ggplot2)
  
  temperee.db <-donnees.ab.rel[donnees.ab.rel$zone=="temperee",]
  temperee.fin <-temperee.db[order(-temperee.db$abondance_relative),]
  
  temp.fig <-data.frame(Zone=" ", Espèces=" ", Abondance_relative=0)
  
  for (n in 1: nrow(temperee.fin)){
    if (sum(temp.fig[,3]) < 15) {
      temp.fig[n,1]<-"temperee"
      temp.fig[n,2]<-temperee.fin[n,2]
      temp.fig[n,3]<-temperee.fin[n,3]
    }
    
    else {
      
      break
      
    }
  }
  
  bor.db <-donnees.ab.rel[donnees.ab.rel$zone=="boreale",]
  bor.fin<-bor.db[order(-bor.db$abondance_relative),]
  
  bor.fig <-data.frame(Zone=" ", Espèces=" ", Abondance_relative=0)
  
  for (n in 1: nrow(bor.fin)){
    if (sum(bor.fig[,3]) < 15) {
      bor.fig[n,1]<-"boreale"
      bor.fig[n,2]<-bor.fin[n,2]
      bor.fig[n,3]<-bor.fin[n,3]
    }
    
    else {
      
      break
      
    }
  }
  
  arc.db <-donnees.ab.rel[donnees.ab.rel$zone=="arctique",]
  arc.fin<-arc.db[order(-arc.db$abondance_relative),]
  
  arc.fig <-data.frame(Zone=" ", Espèces=" ", Abondance_relative=0)
  
  for (n in 1: nrow(arc.fin)){
    if (sum(arc.fig[,3]) < 15) {
      arc.fig[n,1]<-"arctique"
      arc.fig[n,2]<-arc.fin[n,2]
      arc.fig[n,3]<-arc.fin[n,3]
    }
    
    else {
      
      break
      
    }
  }
  
  
  db.fig<-rbind(temp.fig,bor.fig,arc.fig)
  
  
  # fig
  #couleurs_espece<- colorRampPalette(brewer.pal(183,"PuBu")) (length(levels(espece)))
  plot_ab_rel <- ggplot(data=db.fig, aes(x=Zone, y=Abondance_relative, fill=Espèces))+ 
    geom_bar(aes(), stat="identity", position="stack")
  
  plot_ab_rel

}



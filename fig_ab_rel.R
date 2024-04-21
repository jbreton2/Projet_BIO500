fig.abon.rel <- function(data.abond, zone, espece, abondance.relative){
  
  #couleurs_espece<- colorRampPalette(brewer.pal(183,"PuBu")) (length(levels(espece)))
  plot_ab_rel <- ggplot(data=data.abond, aes(x=zone, y=abondance.relative, fill=espece))+ 
  geom_bar(aes(), stat="identity", position="stack")
  
}

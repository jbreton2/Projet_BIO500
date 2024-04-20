fig.abon.rel <- function(data.abond){
  
  couleurs_espece<- colorRampPalette(brewer.pal(8,"Dark2")) (length(levels(data.abond$espece)))
  plot_ab_rel <- ggplot(data=data.abond, aes(x=Sample, y=Abundance, fill=data.abond$espece))+ 
  geom_bar(aes(), stat="identity", position="stack")+scale_fill_manual(values = couleurs_espece)
  
}

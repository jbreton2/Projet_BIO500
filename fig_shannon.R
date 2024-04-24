fig.shannon <- function(data.shannon){ 
  #points
  plot(data.shannon$lat, data.shannon$shannon, xlab = "Latitude", ylab = "Indice de Shannon", cex.axis = 0.8, cex.lab = 0.8,cex=0.5)
  #modèle
  mod.shan <-lm(shannon~lat, data=data.shannon)
  #droite de régression
  abline (mod.shan, col="red")
  #délimitations des sections géographique
  abline(v=48)
  abline(v=58)
  #paramètres de la régression
  ordo<-round(unname(coef(mod.shan)[1]), 2)
  pente<-round(unname(coef(mod.shan)[2]), 2)
  r2 <- round(summary(mod.shan)$r.squared, 2)
  text(x = 60, y = 1.6, paste("R² =",r2), cex = 0.5)
  text(x = 60, y = 1.7, paste("y =", pente, "x +", ordo), cex = 0.5)
  #Titre zones
  text(x = 46.2, y = 3.9, paste("Tempérée"), cex = 0.5)
  text(x = 53, y = 3.9, paste("Boréale"), cex = 0.5)
  text(x = 60, y = 3.9, paste("Arctique"), cex = 0.5)
}
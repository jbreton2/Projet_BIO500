fig.shanon <- function(data.shanon){ 
  #points
  plot(data_shanon$lat, data_shanon$shanon, xlab = "Latitude", ylab = "Indice de Shanon", cex=1.1)
  #modèle
  mod.shan <-lm(shanon~lat, data=data_shanon)
  #droite de régression
  abline (mod.shan, col="red")
  #délimitations des sections géographique
  abline(v=48)
  abline(v=58)
  #paramètres de la régression
  ordo<-round(unname(coef(mod.shan)[1]), 2)
  pente<-round(unname(coef(mod.shan)[2]), 2)
  r2 <- round(summary(mod.shan)$r.squared, 2)
  #légende
  text(x = 60, y = 1.6, paste("R² =",r2), cex = 0.8)
  text(x = 60, y = 1.7, paste("y =", pente, "x +", ordo), cex = 0.8)
  text(x = 46.2, y = 3.9, paste("Tempérée"), cex = 0.8)
  text(x = 53, y = 3.9, paste("Boréale"), cex = 0.8)
  text(x = 60, y = 3.9, paste("Arctique"), cex = 0.8)
  title(main = "Indice de Shanon des oiseaux observés au Québec en fonction de la latitude")
}
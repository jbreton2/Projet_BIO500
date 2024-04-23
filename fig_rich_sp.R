
fig.rich.sp <- function(data.rich){ 
  
  # Figure globale
  plot(data.rich$lat, data.rich$richesse_sp, xlab = "Latitude", ylab = "Richesse spécifique")  
  
  #Modèle
  mod.glob <-lm(richesse_sp~lat, data=data.rich)
  #droite de régression
  abline (mod.glob, col="red")
  #délimitations des sections géographique
  abline(v=48)
  abline(v=58)
  #Paramètres régression
  ordo<-round(unname(coef(mod.glob)[1]), 2)
  pente<-round(unname(coef(mod.glob)[2]), 2)
  r2 <- round(summary(mod.glob)$r.squared, 2)
  text(x = 60.5, y = 37, paste("R² =",r2), cex = 0.5)
  text(x = 60.2, y = 34, paste("y =", pente,  "x +", ordo), cex = 0.5)
  #Titre zones
  text(x = 46.2, y = 70, paste("Tempérée"), cex = 0.5)
  text(x = 53, y = 70, paste("Boréale"), cex = 0.5)
  text(x = 60, y = 69, paste("Arctique"), cex = 0.5)

}







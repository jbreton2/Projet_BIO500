
fig.rich.sp <- function(data.rich){ 
  
  # Figure globale
  plot(data.rich$global$lat, data.rich$global$richesse_sp, xlab = "Latitude", ylab = "Richesse spécifique", cex=1.1)  
  
  mod.glob <-lm(richesse_sp~lat, data=data.rich$global)
  abline (mod.glob, col="red")
  abline(v=48)
  abline(v=58)
  r2 <- round(summary(mod.glob)$r.squared, 2)
  text(x = 60.5, y = 37, paste("R² =",r2), cex = 0.8)
  text(x = 60.2, y = 34, paste("y = -2.01x + 133.287"), cex = 0.8)
  text(x = 46.2, y = 70, paste("Tempérée"), cex = 0.8)
  text(x = 53, y = 70, paste("Boréale"), cex = 0.8)
  text(x = 60, y = 69, paste("Arctique"), cex = 0.8)
  title(main = "Richesse spécifique des oiseaux observés au Québec en fonction de la latitude")

}







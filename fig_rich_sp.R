
# Décide comment on dispose les figure (ici 2 rangées de 2 colonnes)
par(mfrow = c(2,2))

layout(matrix(c(1,1,1,2,3,4), ncol=3, byrow=TRUE))

# Figure globale
plot(richesse.sp$global$lat, richesse.sp$global$richesse_sp, xlab = "Latitude", ylab = "Richesse spécifique", cex=1.1)  

mod.glob <-lm(richesse_sp~lat, data=richesse.sp$global)
abline (mod.glob, col="red")
abline(v=48)
abline(v=58)
r2 <- round(summary(mod.glob)$r.squared, 2)
text(x = 60.5, y = 20, paste("R² =",r2), cex = 1)
text(x = 46.2, y = 70, paste("Tempéré"), cex = 1)
text(x = 53, y = 70, paste("Boréale"), cex = 1)
text(x = 60, y = 69, paste("Arctique"), cex = 1)
title(main = "Richesse spécifique d'oiseaux observés au Québec en fonction de la latitude")


#legend(x = 60, y = 50, inset = 0, xjust = 1, y.intersp = 0.5,  bty = "n",col = c("black","red"), pch = c(1,NA),lty = c(NA,1) ,legend = c("Observations", "Régression linéaire"),cex = 1)

# Figure zone tempéré
#plot(richesse.sp$tempéré$lat, richesse.sp$tempéré$richesse_sp, xlab = "Latitude", ylab = "Richesse spécifique")   

#mod.temp <-lm(richesse_sp~lat, data=richesse.sp$tempéré)
#summary(mod.temp)
#abline (mod.temp, col="red")
#title(main = "Zone tempéré du Québec")

# Figure zone boréale
#plot(richesse.sp$boréale$lat, richesse.sp$boréale$richesse_sp, xlab = "Latitude", ylab = "Richesse spécifique")   

#mod.bor <-lm(richesse_sp~lat, data=richesse.sp$boréale)
#summary(mod.bor)
#abline (mod.bor, col="red")
#title(main = "Zone boréale du Québec")

# Figure zone arctique
#plot(richesse.sp$arctique$lat, richesse.sp$arctique$richesse_sp, xlab = "Latitude", ylab = "Richesse spécifique")   

#mod.arct <-lm(richesse_sp~lat, data=richesse.sp$arctique)
#summary(mod.arct)
#abline (mod.arct, col="red")
#title(main = "Zone arctique du Québec")





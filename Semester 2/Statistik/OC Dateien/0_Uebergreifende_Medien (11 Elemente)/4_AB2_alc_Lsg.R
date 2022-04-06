library(mosaic)

#Wir betrachten den Datensatz ,Alcohol' (siehe Online Campus "R-Übungsdatensätze.R"
                                        
data(Alcohol)
View(Alcohol)
?Alcohol

#1. Begrenzen Sie auf 2005, sortieren Sie absteigend den Alkoholkonsum und speichern Sie dies als "alc05" ab.

alc05 <- Alcohol %>% filter(year=="2005") %>% arrange(-alcohol)

# 2. Erzeugen Sie eine neue Spalte/ Variable in "alc05" mit dem Namen "per_max". Setzen Sie den Maximalwert auf 100 (im Sinne von 100 %). Alle anderen Werte sollen den prozentualen Anteil wiedergeben (bezogen auf diesen Maximalwert).

alc05<-alc05 %>% mutate(per_max = alc05$alcohol/max(alc05$alcohol))
max(alc05$alcohol) #18.28


# 3. Überprüfen Sie die folgenden Mittelwerte (mit gruppieren):

s<-summarize(group_by_at (Alcohol, vars(year)), mean(alcohol))
s %>% arrange(-year)

#2008            6.69
#2005            6.54

# 4. Schätzen Sie für 2005 mit simulationsbasierten Verfahren den unbekannten Mittelwert µ der Gesamtpopulation und geben Sie wie folgt an:
# Der Punktschätzer beträgt... Der wahre unbekannte Populationsparameter µ liegt in 95% der Stichproben zwischen x und y.

set.seed(2021)

alc_resample_loop <- do (1000000)*mean(resample(alc05$alcohol)) #for-loop
mean(alc_resample_loop$mean) #mean der means (grand mean)
sd(alc_resample_loop$mean) #Standardfehler

hist(alc_resample_loop$mean, breaks=50)
plot(density(alc_resample_loop$mean,bw=1)) #GlÃ¤ttung Dichteplot
abline(v = mean(alc_resample_loop$mean), col = 2) #mean StichprobenMW

## 2.5% und 97.5% quantile (mittleren 95%)
q<-quantile(alc_resample_loop$mean, prob=c(0.025,0.975));q
abline(v = q, col = 2, lty = 2)
paste("Der Punktschaetzer betraegt",mean(alc_resample_loop$mean),". Der wahre unbekannte Populationsparameter µ liegt
      in 95% der Stichproben zwischen ",q[1]," und",q[2])

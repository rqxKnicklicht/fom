library(mosaic) #shortcut für RUN: strg+ENTER
library(tidyverse)

# installieren und importieren von nycflights13
install.packages("nycflights13") #installieren
library(nycflights13) #importieren
View(flights)
# zunächst bereinigen von NA und selektieren nur arr_delay
flights_clean <- drop_na(flights, arr_delay) #ohne NA


### Resamplen: mehrfaches Ziehen aus EINER Stichprobe ########++++++++++

# Schritt 1: ziehe EIN sample

fl_sample<- sample(flights_clean$arr_delay, size = 3) #2500
fl_sample
mean(fl_sample)

# Schritt 2: resample: Ziehen mit Zurücklegen aus unserem (einzigen) sample
fl_resample <- resample(fl_sample, size = 3)
fl_resample


######################### als loop ##############
# als loop
# etwas Größeres sample ziehen
fl_sample<- sample(flights_clean$arr_delay, size = 2500)
mean(fl_sample) #an dieser Stelle läßt sich nur der mean des samples berechnen

#aus diesem sample resamplen um die Breite des Konf-intervalls zu schätzen
set.seed(2021)

fl_resample_loop <- do (100000)*mean(resample(fl_sample)) #for-loop
mean(fl_resample_loop$mean) #mean der means (grand mean)
sd(fl_resample_loop$mean) #Standardfehler

hist(fl_resample_loop$mean, breaks=50) #Histogramm
plot(density(fl_resample_loop$mean,bw=1)) #Glättung Dichteplot

mu<-mean(flights_clean$arr_delay);mu # Mittelwert der population
abline(v = mean(flights_clean$arr_delay), col = 4) #mean population

m_<-mean(fl_resample_loop$mean);m_ # MW der Mittelwerte der samples
abline(v = mean(fl_resample_loop$mean), col = 2) #mean StichprobenMW

## 2.5% und 97.5% quantile (mittleren 95%)
q<-quantile(fl_resample_loop$mean, prob=c(0.025,0.975));q
abline(v = q, col = 2, lty = 2)

paste("Der Punktschätzer beträgt",mean(fl_resample_loop$mean),". Der wahre unbekannte Populationsparameter µ liegt
      in 95% der Stichproben zwischen ",q[1]," und",q[2])

sd(fl_resample_loop$mean) #bootstrap Standardfehler, empirisch


################### Ein Ausreißertest #################
library(mosaic)
# Ausreißertest: Es liegt eine Messung von Körpergrößen vor 

height <- c(1.78,1.69,1.81,1.83,1.80,1.40) #c für Vektor
favstats(height) #Kennzahlen anzeigen
boxplot(height) #visualisieren
# der Wert 1.40 m wird hier als Ausreißer (outlier) gesehen, siehe 
# Punkt unten unterhalb des boxplots
#iqr_test (nach boxplot), untere und obere Grenze
quantile(height) # wir brauchen Q1 und Q3

iqr_test_u <- function(x){
  quantile(x)[2]-1.5*(iqr(x))   #Q1-1.5*IQR
}
iqr_test_o <- function(x){
  quantile(x)[4]+1.5*(iqr(x))   #Q3+1.5*IQR
}
u<-iqr_test_u(height);u
o<-iqr_test_o(height);o

boxplot(height,ylim=c(0.9*min(height),1.1*max(height)))
abline(h=u); abline(h=o)

############################# end QM7 ###############



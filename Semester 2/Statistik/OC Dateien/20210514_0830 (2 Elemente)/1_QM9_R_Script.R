library(mosaic)
library(tidyverse)

# Demonstration: Testen auf Normalverteilung
#1) Visuelles Testen auf NV mit einem QQ-plot
# ?qqplot
# Normalverteilte Daten liegen im QQ-plot auf der Diagonalen

#?rnorm
nv<-rnorm(5000,0,1) #erzeuge normalverteilten Daten
hist(nv) #Gausssche Glockenkurve bei normalverteilten Daten
qqnorm(nv) # Normalverteilte Daten liegen auf der Diagonalen
qqline(nv) #Diagonale Linie einzeichnen

# Gegenbeispiel: gleichverteilte Daten (z.B. beim würfeln)
#?runif
uni<-runif(5000,0,1) #erzeuge gleichverteilten Daten
hist(uni) #gleichverteilte Daten haben dieselben Wahrscheinlichkeiten
qqnorm(uni) #nicht-gleichverteilte Daten liegen nicht auf der Diagonalen
qqline(uni) #Diagonale Linie einzeichnen

#2) Statistischer Test auf Normalverteilung: Shapiro-Wilk Test
# ?shapiro.test
# Achtung: Nullhypothese lautet hier dass EINE NV vorliegt
# (p-Werte < 0.05 bedeuten dann nicht- NV)
# p-Werte > 0.05 bestätigen dann die H_0: Daten sind dann NV
shapiro.test(nv) #testen auf NV
shapiro.test(uni) #testen auf NV


##### Kurzform Veranschaulichung Shapiro- Wilk Test ########
shapiro.test(rnorm(100, mean = 5, sd = 3))
shapiro.test(runif(100, min = 2, max = 4))
############################################################




# installieren und importieren von nycflights13
install.packages("nycflights13") #installieren
library(nycflights13) #importieren
View(flights)
#?flights
# zunaechst bereinigen von NA und selektieren nur arr_delay
flights_clean <- drop_na(flights, arr_delay) #ohne NA

# arr_delay filtern nach 'JFK' und 'non_JFK'
# nur jfk
jfk <- flights_clean %>% filter(origin == "JFK") %>% select(arr_delay)
str(jfk) #109.079

# nicht jfk
non_jfk <- flights_clean %>% filter(origin != "JFK") %>% select(arr_delay)
str(non_jfk) #218.267
# 109.079 + 218.267 = 327.346

# Anzahl prüfen mit Population (ohne NA)
str(flights_clean) #327,346 x 19 --> stimmt

favstats(jfk$arr_delay)
favstats(non_jfk$arr_delay)

jfk_sample<- sample(jfk$arr_delay, size = 2500)
mean(jfk_sample)
histogram(jfk_sample, breaks=100) #linkssteil, also nicht NV
qqnorm(jfk_sample)
qqline(jfk_sample)


non_jfk_sample<- sample(non_jfk$arr_delay, size = 2500)
mean(non_jfk_sample)
histogram(non_jfk_sample, breaks=100) #linkssteil, also nicht NV
qqnorm(non_jfk_sample) 
qqline(non_jfk_sample)


shapiro.test(jfk_sample) #testen auf NV
shapiro.test(non_jfk_sample) #testen auf NV

#FAZIT: beide Datensätze sind nicht normalverteilt.
# Es können deshalb keine parametrischen Verfahren angewandt werden.
# Es liegen 2 unabhängige Gruppen vor (kein vorher-nachher)

# Laut Diagramm 'Testauswahl' kommt der Mann-Whitney U-Test
# (auch Wilcoxon Test) zum Einsatz
#?wilcox.test
wilcox.test(jfk_sample,non_jfk_sample)






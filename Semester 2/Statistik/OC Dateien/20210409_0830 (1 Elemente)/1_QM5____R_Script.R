#### Einführung Fallstudie 'flights' ###############
#Quelle: https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf

#- Datensatz 'flights' als großen Datensatz kennen lernen
#- Daten (u.a. mit Paket tidyverse) bereinigen (NA eliminieren)

library(mosaic) #shortcut für RUN: strg+ENTER
library(tidyverse) #ggfs. vorher installieren mit 
# install.packages("tidyverse)

# installieren und importieren von nycflights13
install.packages("nycflights13") #installieren
library(nycflights13) #importieren

flights #großer Datensatz, nur ein Teil wird angezeigt
?flights #On-time data for all flights that departed NYC

inspect(flights) #4 kategorial, 14 metrisch und 1 "Zeitstempel"
# A tibble: 336,776 x 19
View(flights) #336.776 Beobachtungen

head(flights)
head(flights) %>% select(dep_delay) #z.B. Verspätung Abflugzeit


#NA entfernen:
mean(flights$dep_delay) #Fehler weil NA (not applicable), fehlende Daten

# es gibt verschiedene Methoden um NA zu eliminieren:
# na.omit (base) und tidyr::drop_na sind die Häufigsten, als Argument
# gibt es teilweise na.rm = TRUE (je nach Funktion)

# mean ohne NA
mean(flights$dep_delay, na.rm =TRUE) #NA remove

# length gibt Anzahl der Beobachtungen zurück
length(flights$dep_delay) #gibt Anzahl (incl. NA) zurück: 336.776
length(flights$dep_delay,na.rm =TRUE) #Fehler: length nur 1 arg

# z.B.nachlesen welche Argumente diese Funktionen übernehmen 
?mean #nimmt na.rm als logical value
?length #nimmt na.rm nicht

# dann eben mit der dplyr- Pfeife:
na.omit(flights$dep_delay)  %>% length #NA remove,DANN Länge:328.521

favstats(flights$dep_delay, na.rm =TRUE) #NA remove
?favstats
# oder mit %>% 
flights$dep_delay %>% na.omit %>% favstats

### end  ##########




################# Einführung Schätzen #########################
#- Variation von verschiedenen Stichproben: Stichproben ziehen ohne 
# zurück legen (sampling) und Kennwerte der samples vergleichen 
# als gute Schätzwerte (Erwartungswerte) für die Population
#- Einführung Standardfehler, Konfidenzintervall

######### Frage: welche Kennzahlen sind gute/ stabile (brauchbare) 
# Schätzwerte für die Gesamtpopulation?

#### Wir ziehen verschiedene Stichproben (samples) ###
set.seed(2021) #Startwert für Zufallszahlengenerator
fl_sample <- na.omit(flights) %>% 
  sample_n(size = 30)

fl_sample #aufrufen


## Wir berechnen nun viele samples und vergleichen mit der population ########

# zunächst bereinigen von NA und selektieren nur arr_delay
flights_clean <- drop_na(flights, arr_delay) #ohne NA

#favourite statistics von arr_delay aller Beobachtungen (ohne NA)
favstats(flights_clean$arr_delay) # Population


# erzeuge x samples der Größe size und zeige favstats
fl_sample_loop <- do(10) * 
  favstats(sample(flights_clean$arr_delay, size = 10))

head(fl_sample_loop)


# Fazit: je größer die Stichprobe, desto eher repräsentiert sie 
# die population


## Vergleiche verschiedene Kennzahlen der gezogenen samples mit dem
# kompletten Datensatz. Welche Kennzahlen ähneln der Population eher?

# eher näher an der Population
boxplot(mean(flights_clean$arr_delay) - fl_sample_loop$mean) # Mittelwert
boxplot(median(flights_clean$arr_delay) - fl_sample_loop$median) # Median
boxplot(iqr(flights_clean$arr_delay) - (fl_sample_loop$Q3-fl_sample_loop$Q1)) #IQR

# eher entfernter von der Population
boxplot(min(flights_clean$arr_delay) - fl_sample_loop$min)
boxplot(max(flights_clean$arr_delay) - fl_sample_loop$max)

# eher abhängig von Stichprobengröße
boxplot(sd(flights_clean$arr_delay) - fl_sample_loop$sd)


# FAZIT: mean, median, iqr scheinen bessere Schätzer zu sein #########################

#### end ######


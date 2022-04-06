#### so Schreiben Sie Kommentare

library(mosaic)


# sib importieren
View(sib)
str(sib)
summary(sib)

## Häufigkeitstabelle ##
tally(sib$number)  # absolute Häufigkeiten
freq<-tally(sib$number, format ="proportion") # relative Häufigkeiten
freq
cumsum(freq)
cumsum(sib$number) # Datenpunkte werden kumuliert
#cumsum(~number, data=sib) # Fehler

cumsum(tally(sib$number)) # abs. H. werden kumuliert

## Stabdiagramm ##
bargraph(~number, data=sib) # Säulendiagramm 
barchart(sib) # Balkendiagramm
#defaults haben absolute Werte

barplot(sib$number) #alle Werte als Säulen

## empirische Verteilungsfunktion (cumulative distribution function (cdf))
# empirical distribution function (ecdf)
ecdf(sib$number)
plot(ecdf(sib$number))

## Einzelne rel. H. ansprechen
freq
freq[4]

## Beispiel n=50 Noten: grad as num vector; variable is grades 
View(grad)
bargraph(~grades, data=grad) #Säulendiagramm
plot(ecdf(grad$grades)) #ecdf

histogram(grad$grades) # default Histogramm



##QM data/Aufg 2.1 Gewichte.txt
##Variable „weight“ as integer einlesen
##Name of data in (z.B.) „kg“ umbenennen
View(kg)
mean(kg$weight) # arithmetischer Mittelwert
median(kg$weight) # Median
min(kg$weight)
max(kg$weight)
quantile(kg$weight)
iqr(kg$weight)
#ODER:
favstats(kg$weight) #summary der beliebtesten Kennzahlen
var(kg$weight)
sd(kg$weight)
boxplot(kg$weight) # boxplot
bwplot(kg$weight) # horizontaler boxplot
## siehe auch ggplot2

## Import Trunkey; Delimiter: Tab; Data type: integer
View(Trunkey)
str(Trunkey)
favstats(Trunkey$Krebs)
mean(Trunkey$Krebs, na.rm = TRUE)
?mean
favstats(Trunkey$Trauma)
boxplot(Trunkey)


############# end QM3 #############

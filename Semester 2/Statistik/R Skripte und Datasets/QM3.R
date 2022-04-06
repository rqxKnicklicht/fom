# Unbedingt auf die Großschreibung achten
View(sib)

str(sib)

# Gibt eine 5-Zahlen-Zusammenfassung aller Spalten einzeln (Min, Max, Median, 1/4 und 3/4 Quartil) zurück
summary(sib)

# Gibt eine Zusammenfassung der ausgewählten Spalte zurück
summary(sib$number)

# Gibt die absoluten Häufigkeiten der DISTINCT-Werte der Spalte zurück
tally(sib$number)

# Gibt die relativen Häufigkeiten der DISTINCT-Werte der Spalte zurück und speichert sie in "freq"
freq <- tally(sib$number, format = "proportion")

# Gibt die kumulierte Summe der Werte in den Spalten zurück
cumsum(freq)

# Erstellt ein einfaches Säulendiagramm mit der Spalte <number> aus dem Dataset "sib"
bargraph(~number, data = sib)

# Erstellt ein einfaches Balkendiagramm mit der absoluten Häufigkeit der Werte
barchart(sib)

# Erstellt eine Art Histogramm, das auf der X-Achse den Index und auf der Y-Achse die Ausprägung anzeigt
barplot(sib$number)

# Erstellt ecdf -> empirical cumulative distribution function, also eine Art Graph der kumulierten Wahrscheinlichkeit und plottet es
plot(ecdf(sib$number))

# Gibt den entsprechenden Wert aus "freq" aus, freq[0] sind Metadaten, also ist freq[1] das erste Objekt, sprich unsere "0"
freq[1];freq[3];freq[4]

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Neues Datenset "grades"
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bargraph(~grades, data = grad)
plot(ecdf(grad$grades))
histogram(grad$grades)

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Neues Datenset "kg"
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

summary(kg$weight)

# Gibt eine 8-Zahlen-Zusammenfassung, die üblichen 5 aus "summary()" 
# und zusätzlich die Standartabweichung (sd), die Anzahl an Zeilen (n) und die Anzahl an <null> Spalten (missing)
favstats(kg$weight)

# Horizontales Boxplot mit Median als Punkt, "bwplot()" kann nur je eine Spalte des Datasets nehmen und druckt je ein Boxplot
bwplot(kg$weight)

# Vertikales Boxplot mit Median als Strich, "boxplot()" kann das gesamte Dataframe als Argument nehemen und druckt dann mehrere Boxplots
boxplot(kg$weight)

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Neues Datenset "Trunkey"
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

favstats(Trunkey$Krebs)
favstats(Trunkey$Trauma)

boxplot(Trunkey)
bwplot(Trunkey$Krebs)


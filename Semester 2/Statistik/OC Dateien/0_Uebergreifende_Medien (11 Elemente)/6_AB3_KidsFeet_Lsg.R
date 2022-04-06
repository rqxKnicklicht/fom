library(mosaic)
#AB3_KidsFeet

# schoener uebersichtlicher Datensatz ueber n=39 Kinderfuesse
data(KidsFeet)
View(KidsFeet)
?KidsFeet
inspect(KidsFeet)
head(KidsFeet)

#Aufg. 3a (man könnte Breite*Länge noch berechnen)
summarize(group_by_at (KidsFeet, vars(birthyear)), mean(length))
summarize(group_by_at (KidsFeet, vars(birthyear)), mean(width))

#Aufg. 3b
summarize(group_by_at (KidsFeet, vars(sex)), mean(length))
summarize(group_by_at (KidsFeet, vars(sex)), mean(width))


#Aufg. 4
gf_bar(~ biggerfoot | sex, data= KidsFeet)
gf_bar(~ domhand | sex, data= KidsFeet)

#Aufg. 5
#H_1: Aeltere kids haben groessere Fuesse (µ_aelter > µ_nicht_aelter)
#H_0: Aeltere kids haben nicht größere Füße (µ_aelter < = µ_nicht_aelter)

#H_1: girl kids haben kleinere Füße (µ_girls < µ_boy)
#H_0: girl kids haben nicht kleinere Füße (µ_girls > = µ_boys)

#Aufg. 6
sd(KidsFeet$length)/sqrt(39)
sd(KidsFeet$width)/sqrt(39)

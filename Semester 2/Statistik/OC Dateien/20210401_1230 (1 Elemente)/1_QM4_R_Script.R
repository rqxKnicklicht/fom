library(mosaic)

#Hinweis: Spell Checking abstellen:
#Tools -> Global Options -> Spelling 
#and disable the “Use real time spellchecking” check box.

# Videodemos QM4
## QM4_0_Einführung Fallstudie 'tips' ##

#Quelle: Bryant, P. G. and Smith, M (1995) Practical Data Analysis: 
#Case Studies in Business Statistics. Homewood, IL: Richard D. Irwin Publishing

install.packages("reshape2")  # installieren
library(reshape2) # import. der Datensatz "tips" ist in dieser library
?tips # Erklärungen für tips

tips
View(tips) #Ein Kellner hat Daten über seine Trinkgelder notiert, sowie einige
#Zusatzdaten erhoben

head(tips,3) # oberen 6 Beobachtungen anzeigen
tail(tips) # unteren 6 Beobachtungen anzeigen

str(tips) #Betrachten Sie die Struktur dieses data frames
inspect(tips) # "inspizieren" Aufbau: 3 quant. + 4 categorial
glimpse(tips) # andere Möglichkeit den Aufbau zu untersuchen

# Säulendiagramm Frauen/ Männer
bargraph(~sex, data=tips) # 
bargraph(tips$sex) # Error (im Video falsch)

gf_bar(~sex, data=tips) #Aber:
gf_bar(tips$sex) #Error: $ operator is invalid for atomic vectors


tally(tips$sex) #Häufigkeit Männer/ Frauen
tally(tips$sex, format="proportion") #in %


## Ende QM4_0_Einführung Fallstudie tips ##

########## QM4_1_PRAXISTIPPS ##############

#filtern (nach Zeilen)
#selektieren (nach Spalten)
#Neue erzeugen
#löschen
#sortieren
#gruppieren

  
#die sog. Pfeife %>% bedeutet DANN 
#shortcut für diese Pfeife: strg+shift+m

#Bsp.: nimm den Datensatz xy DANN wähle 2 Variablen davon
#DANN filter diese nach irgendwas


# 'filtern' nach einem Kriterium (filtert Zeilen)
tips %>% filter(sex == "female") #Fehler: "Female" (case sensitive)
#Lies: Nimm tips DANN wähle die Zeilen mit sex = Female
head(tips) %>% filter(sex == "Female") #nur head
head(tips) %>% filter(sex == "Male") #nur head

tips %>% filter(sex == "Female") %>% count # Frauen zählen (mit Pfeife)


## Variablen auswählen mit 'select' (selektiert Spalten)
head(tips) %>% select(sex, size) #zeigt die ausgewählten Variablen
#Lies: Nimm tips DANN wähle die Spalten sex, size
tail(tips) %>% select(total_bill, tip)

#oder kombiniert:
head(tips) %>% filter(sex == "Female") %>% select(sex,tip, size, time) #oder
head(tips) %>% select(sex,tip, size, time) %>% filter(sex == "Female") 

# mutate erzeugt neue Variablen (Spalten)

#Beispiel: wie hoch waren im Schnitt die Einzelrechnungen?
#teile Gesamtrechnung durch Anzahl Personen, erzeuge neue Variable
#erzeuge zunächst neuen Datensatz mit wenigen interessierenden Variablen
s_bill <- tips %>% select(total_bill, size, sex) #speichere Auswahl als neues Objekt 
head(s_bill) 


s_bill <- s_bill %>% mutate(s_ = tips$total_bill/tips$size) #erzeuge neue Variable 
#und füge dem Datensatz hinzu
head(s_bill) #nur head, der Übersicht halber..

#löschen von Spalten
s_bill$s_ <- NULL
s_bill

# oder tip in Prozent
pc_tip <- tips %>% mutate(pc_ = tips$tip/tips$total_bill)
head(pc_tip)
View(pc_tip)



#sortieren mit arrange
head(tips) %>% arrange (-size) # '-size' für absteigend
tail(tips) %>% arrange (-size,-tip, sex)
# erst -size dann -tip dann sex alphabetisch


#gruppieren von Kategorien, z.B. Female und Male
group_by_at (s_bill, vars(sex)) #es gibt sex[2] Kategorien
group_by_at (tips, vars(day)) #day [4]

summarize(group_by_at (tips, vars(sex)), mean(tip))
summarize(group_by_at (tips, vars(day)), mean(tip))
summarize(group_by_at (tips, vars(smoker,day,sex)), mean(tip))

#Bedingte Häufigkeiten/ Gruppierungen

# Analysiere Essenszeit (time) jeweils nach Geschlecht

gf_bar(~ sex | time, data= tips) # "bedingt nach", "aufgeteilt" 
#ODER
bargraph(~ sex | time, data= tips)
# wer zahlt wann mehr? Bei lunch visuell nicht deutlich, deshalb:

tally(~sex | time, data=tips) # lunch: female 35, male 33
tally(~sex | time, format= "proportion", data=tips) 
#In dieser Stichprobe haben Frauen häufiger bezahlt als Männer


# Tipp: die Reihenfolge entscheidet:
tally(~time | sex, data=tips)
tally(~time | sex, format= "proportion", data=tips) 
#die 87 Frauen entsprechen 100% (Summe 1. Spalte) und
#die Männer entsprechen 100%

tally(~sex | time, data=tips)
tally(~sex | time, format= "proportion", data=tips) 
#alle Dinner (n=176) sind 100% und alle vom lunch sind 100%


############## Ende QM4_1_Praxistipps ##########


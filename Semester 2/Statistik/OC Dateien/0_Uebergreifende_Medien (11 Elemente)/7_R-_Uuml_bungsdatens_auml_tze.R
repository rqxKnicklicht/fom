library(mosaic)

# es finden sich zahlreiche Datensätze für R, z.B.:
# https://cran.r-project.org/web/packages/mosaicData/mosaicData.pdf
# oder
# data()


### Datensätze mit sehr wenigen Variablen

data(Alcohol)
View(Alcohol)
?Alcohol
# filtern, selektieren, Gruppierungen etc.

data(CoolingWater)
View(CoolingWater)
# z.B. graphische Darstellungen

data(SwimRecords)
View(SwimRecords)
?SwimRecords

data(Whickham)
View(Whickham)
?Whickham



### Datensätze mit ca. 4-8 Variablen

data(Galton)
View(Galton)
?Galton

# schöner übersichtlicher Datensatz über n=39 Kinderfüße
data(KidsFeet)
View(KidsFeet)
?KidsFeet


library(reshape2)
tips
View(tips)
?tips



## mehr als 8 Variablen
data(mtcars)
View(mtcars)
?mtcars


install.packages("nycflights13") #installieren
library(nycflights13) #importieren
flights
View(flights)
?flights

#############

#############










library(mosaic, reshape2)
library(reshape2)

View(tips)

# Gibt die obersten/untersten 6 Werte des Datasets aus, das zweite Argument bestimmt die Anzahl an Zeilen
head(tips)
head(tips, 3)

tail(tips)
tail(tips, 3)

str(tips)
inspect(tips)
glimpse(tips)


bargraph(~day, data = tips)

colnames(tips)

tally(tips$sex)
freq_tips <- tally(tips$sex, format = "proportion")

cumsum(freq_tips)

# Filtern mit "%>%"
head(tips) %>% filter(sex == "Female")

# Nimm "tips", filter es nach "sex == "Female"" und dann nimm "count()"
tips %>%  filter(sex == "Female") %>% count

# Gleiches Ergebnis wie
count(tips %>% filter(sex == "Female"))

tips %>% select(sex, size, total_bill)
s_bill <- tips %>% select(sex, size, total_bill)
s_bill <- s_bill %>% mutate(s_ = tips$total_bill/tips$size)
head(s_bill)
s_bill$s_ <- NULL
  

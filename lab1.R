vector <- seq(5, 25, by = 5)
cat(vector)
cat(vector[vector > 15])
cat(mean(vector))
cat(sum(vector[1:3]))


wyniki <- c(75, 48, 90, 60, 30)
for (wynik in wyniki) {
  if (wynik >= 60){
    cat("Negatywny\n")
  } else{
    cat("Pozytywny\n")	
	}

}

imiona = c("Jan", "Ola", "Ela")
wiek = c(25, 30, 28)
punkty = c(85, 92, 78)

df <- data.frame(Imię = imiona, Wiek = wiek, Punkty=punkty)

oceny <- rep(0, times=length(punkty))
for (i in 1:length(punkty)) {
  if (punkty[i] < 50) {
    oceny[i] = 2.0
  } else if (punkty[i] < 61){
    oceny[i] = 3.0
  } else if (punkty[i] < 71){
    oceny[i] = 3.5
  } else if (punkty[i] < 81){
    oceny[i] = 4.0
  } else if (punkty[i] < 91){
    oceny[i] = 4.5
  } else {
    oceny[i] = 5.0
  }
}

df$Oceny <- oceny
data = df[df$Wiek < 30,]


install.packages("ggplot2")
library(ggplot2)

df_AIR <- data.frame(
  Przedmiot = c("Analiza i Bazy Danych", "Metody Numeryczne", "Eksploracja Danych"),
  Średnia = c(71, 67, 89),
  Rocznik = c(2022, 2022, 2022)
)

wykres_AIR <- ggplot(df_AIR, aes(x = Przedmiot, y = Średnia)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Średnia z przedmiotów dla rocznika 2022",
       x = "Przedmiot",
       y = "Średnia")

print(wykres_AIR)


#wyniki_grupa_A <- c(60, 65, 75, 68, 62)
#wyniki_grupa_B <- c(78, 80, 85, 92, 88)

wyniki_grupa_A <- c(80, 65, 75, 68, 72)
wyniki_grupa_B <- c(78, 80, 85, 92, 88)

grupa = c("grupa A", "grupa B")
srednia = c(mean(wyniki_grupa_A), mean(wyniki_grupa_B))
if(mean(wyniki_grupa_A) < 70){
  cat("Grupa A ze srednia ponizej 70")
  
}

dane <- data.frame(
  Grupa = grupa,
  Matematyka = srednia
)

#dane_filtr <- dane[dane$Grupa == "grupa A" & dane$Matematyka >= 70, ]
dane_filtr <- subset(dane, ! (Grupa == "grupa A" & Matematyka < 70))
  
wykres <- ggplot(dane_filtr, aes(x = Grupa, y = Matematyka)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Średnie wyniki z testów z Matematyki",
       x = "grupa",
       y = "średnia")

print(wykres)
  
  





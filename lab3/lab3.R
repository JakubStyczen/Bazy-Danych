library(DBI)
library(RPostgres)

dsn_database = "wbauer_adb_2023"   
dsn_hostname = "pgsql-196447.vipserv.org"  
dsn_port = "5432"                
dsn_uid = "wbauer_adb"        
dsn_pwd = "adb2020" 


con <- dbConnect(Postgres(), dbname = dsn_database, host=dsn_hostname, port=dsn_port, user=dsn_uid, password=dsn_pwd) 
query <- 'SELECT category_id FROM category ORDER BY category_id DESC FETCH FIRST ROW ONLY'

df1 <- dbGetQuery(con, query) 
print('ILOSC KATEGORII FILMOW: ')
print(df1$category_id)

query <- 'SELECT name FROM category ORDER BY name ASC'
df2 <- dbGetQuery(con, query) 
print("Kategorie filmow alfabetycznie")
print(df2)

query <- 'SELECT title FROM film ORDER BY release_year ASC LIMIT 1'
df3_1 <- dbGetQuery(con, query) 
cat("Najstarszy film:")
print(df3_1)
query <- 'SELECT title FROM film ORDER BY release_year ASC LIMIT 1 OFFSET 3'
df3_2 <- dbGetQuery(con, query) 
cat("Najmłodszy film:")
print(df3_2)

query <- "
SELECT 
  COUNT(rental_date) 
FROM 
  rental 
WHERE
  rental_date BETWEEN '2005-07-01'
AND '2005-08-01'
"
df4 <- dbGetQuery(con, query) 
cat("ILOŚĆ FILMOW wypozyczonych w okresie 2005-07-01 a 2005-08-01: ")
print(df4$count)

query <- "
SELECT 
  COUNT(rental_date) 
FROM 
  rental 
WHERE
  rental_date BETWEEN '2010-01-01'
AND '2011-02-01'
"
df5 <- dbGetQuery(con, query) 
cat("ILOŚĆ FILMOW wypozyczonych w okresie 2010-01-01 a 2011-02-011: ")
print(df5$count)

query <- 'SELECT amount FROM payment LEFT JOIN rental
ON payment.rental_id = rental.rental_id
ORDER BY amount DESC FETCH FIRST ROW ONLY'
df6 <- dbGetQuery(con, query) 
cat("Najwieksza płatność wypożyczenia: ")
print(df6)

query <- "
SELECT 
   first_name, last_name, country
FROM 
  country RIGHT JOIN city ON country.country_id = city.country_id
    RIGHT JOIN address ON city.city_id = address.city_id
    RIGHT JOIN customer ON address.address_id = customer.address_id
WHERE
  country IN ('Poland', 'Nigeria', 'Bangladesh')
"
df7 <- dbGetQuery(con, query) 
cat("Klienci z Polski, Nigeri i Bangladeszu")
print(df7)


query <- '
SELECT
  first_name, last_name, address, address2, city, country
FROM
  country RIGHT JOIN city ON country.country_id = city.country_id
  RIGHT JOIN address ON address.city_id = city.city_id
    RIGHT JOIN staff ON staff.address_id = address.address_id
'
df8 <- dbGetQuery(con, query) 
cat("Miejsce zamieszkania personelu: ")
print(df8)

query <- "
SELECT
  COUNT(Country)
FROM
  country RIGHT JOIN city ON country.country_id = city.country_id
  RIGHT JOIN address ON address.city_id = city.city_id
    RIGHT JOIN staff ON staff.address_id = address.address_id
WHERE
  country IN ('Argentina', 'Spain')
"
df9 <- dbGetQuery(con, query) 
cat("Ilość pracowników z Argentyny lub Hiszpani: ")
print(df9)


query <- "
SELECT
  customer.first_name, customer.last_name, category.name
FROM
    customer LEFT JOIN rental ON rental.customer_id = customer.customer_id
    LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
    LEFT JOIN film ON film.film_id = inventory.film_id
    LEFT JOIN film_category ON film.film_id = film_category.film_id
    LEFT JOIN category ON category.category_id = film_category.category_id
"
df10 <- dbGetQuery(con, query) 
cat("Kategorie wypożyczane przez klientów: ")
print(df10)

query <- "
SELECT
  DISTINCT category.name
FROM
  country INNER JOIN city ON country.country_id = city.country_id
    INNER JOIN address ON city.city_id = address.city_id
    INNER JOIN customer ON address.address_id = customer.address_id
    INNER JOIN rental ON customer.customer_id = rental.customer_id
    INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film ON film.film_id = inventory.film_id
    LEFT JOIN film_category ON film.film_id = film_category.film_id
    LEFT JOIN category ON category.category_id = film_category.category_id
WHERE
  country IN ('United States')
"
df11 <- dbGetQuery(con, query) 
cat("Kategorie wypożyczone w Ameryce")
print(df11)

query <- "
SELECT
  title, first_name, last_name
FROM
  actor RIGHT JOIN film_actor ON actor.actor_id = film_actor.actor_id
  RIGHT JOIN film ON film.film_id = film_actor.film_id
WHERE
  actor.last_name IN ('Pfeiffer', 'Zellweger', 'Presley') AND
  actor.first_name IN ('Olympia', 'Julia', 'Ellen')
"
df12 <- dbGetQuery(con, query) 
print("Wszystkie tytuły filmów, w których grał: Olympia Pfeiffer lub Julia Zellweger lub Ellen Presley")
print(df12)

library(DBI)
library(RPostgres)

dsn_database = "wbauer_adb_2023"   
dsn_hostname = "pgsql-196447.vipserv.org"  
dsn_port = "5432"                
dsn_uid = "wbauer_adb"        
dsn_pwd = "adb2020" 


con <- dbConnect(Postgres(), dbname = dsn_database, host=dsn_hostname, port=dsn_port, user=dsn_uid, password=dsn_pwd) 
query <- 'SELECT category_id FROM category ORDER BY category_id DESC FETCH FIRST ROW ONLY'

#df1 <- dbGetQuery(con, query) 
#print(df1)

query <- 'SELECT name FROM category ORDER BY name ASC'
#df2 <- dbGetQuery(con, query) 
#print(df2)

query <- 'SELECT * FROM film'
#df3 <- dbGetQuery(con, query) 
#print(df3)

query <- 'SELECT * FROM payment ORDER BY amount DESC FETCH FIRST 5 ROW only'
#df6 <- dbGetQuery(con, query) 
#print(df6)

query <- 'SELECT country FROM country WHERE country IN (76, 69)'
df7 <- dbGetQuery(con, query) 
print(df7)


query <- 'SELECT address_id FROM address LEFT JOIN staff ON addres_id == adress_id'
df8 <- dbGetQuery(con, query) 
print(df8)

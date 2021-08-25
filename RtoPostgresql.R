install.packages("RPostgreSQL")
library(RPostgreSQL)
library(DBI)

con <- dbConnect(RPostgres::Postgres())


connection <- dbConnect(Rpostgres::Postgres())

con= dbConnect(PostgreSQL(), user = "postgres", dbname = "testdb", host = "localhost", port = 5432,password = "hadoop")


con <- dbConnect(RPostgres::Postgres(),dbname = 'testdb', 
                 #host = 'HOST', # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'
                 port = 5432, # or any other port specified by your DBA
                 user = 'postgres',
                 password = 'hadoop')

out = dbGetQuery(con,"select * from public.test_tbl")

regres <- lm(out$type_id ~ out$numbr)
par(cex =.7)
plot(out$type_id,out$numbr)
abline(regres)


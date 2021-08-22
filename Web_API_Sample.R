install.packages("httr")
library(httr)

r <- GET("http://swapi.com/api/planets/1")

r

status_code(r)

headers(r)

View(r)

str(content(r))

http_status(r)

r$status_code

headers(r)

cookies(r)

content(r,"text")

content(r,"raw")

content(r,"parsed")


install.packages("jsonlite")
install.packages("magrittr")
library(jsonlite)
library(magrittr)

alderaan <- GET("http://swapi.com/api/planets/?search = alderaan")

alderaan <- GET("http://swapi.com/api/planets/", query = list(search = "alderaan"))

names(alderaan)
alderaan$status_code
alderaan$headers$'content-type'

textcontent <- content(alderaan, "text",encoding = "UTF-8")
textcontent
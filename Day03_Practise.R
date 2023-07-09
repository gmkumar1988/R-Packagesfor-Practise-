library(kernlab)
data("spam")
spam$capitalAvesq <- spam$capitalAve^2
head(spam$capitalAvesq)

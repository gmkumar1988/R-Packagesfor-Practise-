install.packages("MASS")
install.packages("reshape2")
install.packages("reshape")

library(MASS)
library(reshape2)
library(reshape)

n <- c(1, 1, 2, 2)
time <- c(1, 2, 1, 2)
x <- c(6, 3, 2, 5)
y <- c(1, 4, 6, 9)

df <- data.frame(n, time, x, y)


cat("Original data frame:\n")
print(df)



# Organize data w.r.t. n and time
molten.data <- melt(df, id = c("n","time"))


cat("\nAfter melting data frame:\n")
print(molten.data)



# Print recasted dataset using cast() function
cast.data <- cast(molten.data, n~variable, sum)

print(cast.data)


cat("\n")
time.cast <- cast(molten.data, time~variable, mean)
print(time.cast)
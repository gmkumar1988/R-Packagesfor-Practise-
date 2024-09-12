install.packages("UsingR")
library(UsingR)
data("galton")
install.packages("reshape")
library(reshape)
long <- melt(galton)
install.packages("ggplot")
library(ggplot2)
g <- ggplot(long, 
            aes(x = value, fill = variable))
g <- g + geom_histogram(color = 'black',binwidth =  1)
g <- g + facet_grid(. ~ variable)
g


###Finding the center of mass : 
install.packages("manipulate")
library(manipulate)
myhist <- function(mu) {
  mse <- mean((galton$child = mu)^2)
  g <- ggplot(galton, aes(x = child)) + geom_histogram(fill = 'salmon',colour = 'black', binwidth = 1)
  g <- g + geom_vline(xintercept = mu, size = 3)
  g <- g + ggtitle(paste("mu = ", mu, ", MSE = ", round(mse,2), sep = ""))
  g
}
manipulate(myhist(mu), mu = slider(62, 74, step = 0.5))

##Comparing children's heights and their parent's height: 
ggplot(galton, aes(x = parent, y = child)) + geom_point() + geom_abline()
lm(I(child - mean(child)) ~ I(parent - mean(parent)) - 1 , data = galton)

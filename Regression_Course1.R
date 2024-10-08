library(UsingR)
data("father.son")
y <- (father.son$sheight - mean(father.son$sheight)) / sd(father.son$sheight)
x <- (father.son$fheight - mean(father.son$fheight)) / sd(father.son$fheight)
rho <- cor(x,y)
library(ggplot2)
g = ggplot(data.frame(x = x, y = y), aes(x = x, y = y))
g = g + geom_point(size = 6, colour = 'black', alpha = 0.2)
g = g + geom_point(size = 4, colour = 'salmon', alpha = 0.2)
g = g + xlim(-4, 4 ) + ylim(-4,4)
g = g + geom_abline(intercept = 0, slope = 1)
g = g + geom_vline(xintercept = 0)
g = g + geom_hline(yintercept = 0)
g = g + geom_abline(intercept = 0, slope = rho, size = 2)
g = g + geom_abline(intercept = 0, slope = 1/ rho , size = 2)
print(g)

###Predicting the price of the diamond
newx <- c(0.16,0.27,0.34)
coef(fit1) + coef(fit2) * newx


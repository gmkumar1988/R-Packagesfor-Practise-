library(UsingR)
data("diamond")
library(ggplot2)
View(diamond)
g = ggplot(diamond, aes(x = carat, y = price))
g = g + xlab("Mass(carats")
g = g + ylab("Price(SIN$")
g = g + geom_point(size = 6, colour = 'black', alpha = 0.2)
g = g + geom_point(size = 5, colour = 'blue',alpha = 0.2)
g = g + geom_smooth(method = 'lm',colour = 'black')
print(g)

fit <- lm(price ~ carat, data = diamond)
coef(fit)
summary(fit)

fit2 <- lm(price ~ I(carat - mean(carat)), data = diamond)
coef(fit2)
summary(fit2)

fit3 <- lm(price ~ I(carat * 10), data = diamond)
coef(fit3)

###Predict the price of the diamond: 
newx <- c(0.16,0.27,0.34)
coef(fit)[1] + coef(fit)[2] * newx
predict(fit, newdata = data.frame(carat = newx))
predict(fit)



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

###Residuals: 
data(diamond)
y <- diamond$price 
x <- diamond$carat
n <- length(y)
# print(n)
fit <- lm(y ~ x)
e <- resid(fit)
yhat <- predict(fit)
max(abs(e - (y - yhat)))
max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))
sum(e)
sum(e * x)

plot(x, e, 
     xlab = "Mass(carots)",
     ylab = "Residuals(SIN$)",
     bg = 'lightblue',
     col = 'black',cex = 2, pch = 21, frame = FALSE)
abline(h= 0, lwd = 2)
for(i in 1 : n)
  lines(c(x[i],x[i]), c(e[i],0), col = 'red',lwd = 2)

x = runif(100, -3, 3)
y = x + sin(x) + rnorm(100, sd = 0.2)
library(ggplot2)
g = ggplot(data.frame(x = x, y = y), 
           aes(x = x, y = y))
g = g + geom_smooth(method = 'lm', colour = 'black')
g = g + geom_point(size = 7 , colour = 'black', alpha = 0.4)
g = g + geom_point(size = 5, colour = 'red', alpha = 0.4)
print(g)

install.packages("gganimate")
library(gganimate)
library(ggplot2)
###Herecomes animation 
ggplot(data = diamond,aes(price, carat)) +
  geom_boxplot() +
  transition_states(
    price,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() +
  exit_shrink() +
  ease_aes('sine-in-out')


library(UsingR)
data("diamonds")
y <- diamond$price 
x <- diamond$carat
n <- length(y)
beta1 <- cor(y,x) * sd(y) /sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / (n-2))
ssx <- sum((x - mean(x))^2)

           
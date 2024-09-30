x <- seq(-10,10, lenght = 1000)
# library(manipulate)
manipulate(
  plot(x, exp(beta0 + beta1 *x) / (1 + exp(beta0 + beta1 *x)),
       type = "l",lwd = 3, frame = FALSE),
  beta1 = slider(-2,2, step = 0.1, initial = 2),
  beta0 = slider(-2,2, step = 0.1, initial = 0)
)

###Simulated example - Hodgepodge : 
n <- 500 
x<- seq(0,4 * pi, length = n)
y <- sin(x) + rnorm(n, sd = 0.3)
knots <- seq(0, 8 * pi, length = 20)
splineterms <- sapply(knots, function(knot) (x>knots) * (x- knots))
xmat <- cbind(1, x, splineterms)
yhat <- predict(lm(y ~ xmat -1 ))
plot(x,y, frame = FALSE, pch = 21, bg = "lightblue",cex = 2)
lines(x, yhat, col ="red",lwd = 2)


n <- 500 
x<- seq(0,4 * pi, length = n)
y <- sin(x) + rnorm(n, sd = 0.3)
knots <- seq(0, 8 * pi, length = 20)
splineterms <- sapply(knots, function(knot) (x>knots) * (x- knots)^2)
xmat <- cbind(1, x, splineterms)
yhat <- predict(lm(y ~ xmat -1 ))
plot(x,y, frame = FALSE, pch = 21, bg = "lightblue",cex = 2)
lines(x, yhat, col ="red",lwd = 2)


###Harmonics using linear model : 
notes4 <- c(250,251,252)
t <- seq(0,1, by = 0.001)
print(t)
n <- length(t)
print(n)
c4 <- sin(2 * pi * notes4[1] * t)
e4 <- sin(2 * pi * notes4[2] * t)
g4 <- sin(2 * pi * notes4[3] * t)
chord <- c4 + e4 + g4 + rnorm(n, 0,0.3)
x <- sapply(notes4, function(freq) sin(2 * pi * freq * t))
fit <- lm(chord ~ x - 1)

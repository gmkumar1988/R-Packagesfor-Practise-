#' Building a model with top ten features
#'
#' This function develops a prediction algorithm based on the top ten features in 'x' that are most predictive of 'y'
#'
#' @param x a n x p matrix of n observations and p predictors
#' @param y a vector of length n representing the response
#' @return a vector of coefficients fro the final fitted model
#' @author Mahesh G
#' This function runs a univariate regression of y on each predictor x
#' final set of 10 predictors are taken from the 10 smallest p values
#' @export
#' @importFrom stats lm

topten <- function(x, y){
  p<- ncol(x)
  if(p<10)
    stop("there are leass than 10 predictors")
  pvalues <- numeric(p)
  for(i in seq_len(p)) {
    fit <- lm(y ~x[,i])
    sum <- summary(fit)
    pvalues[i] <- sum$coefficients[2,4]
  }
  ord <- order(pvalues)
  ord <- ord[1:10]
  x10 <- x[,ord]
  fit <- lm(y~x10)
  coef(fit)
}


#'Prediction with top ten features
#'
#'Functions makes a prediction for each values provided in the input 'x' matrix
#'@param x a n* 10 matrix
#'@param b is a vector of co efficient obtained from top ten function
#'@export
#'
predict10 <- function(x,b) {
  x <- cbind(1,x)
  drop(x %*% b)
}

set.seed(3)
df <- data.frame(x = rnorm(100), y = 1:100)
sapply (df, mean)
####
set.seed(3)
x <- rnorm(100)
x <- as.ts(x)
plot(x)


###Creating new class using setmethod function :

library(methods)
setClass("polygon",
         representation(x = "numeric",
                        y = "numeric"))
showMethods("plot")
p <- new("polygon", x = c(1,2,3,4), y = c(11,3,5,4))
plot(p)
# setMethod("plot","polygon",
#           function(x,y){
#             plot(x@x, x@y, type = "n",)
            
            
          })

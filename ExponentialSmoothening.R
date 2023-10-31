library(tidyverse)
library(fpp2)
goog.train <- window(goog,
                     end = 900)
goog.test <- window(goog,
                    end = 901)
#Sample Market Mix Module:
sales <- c(37, 89, 82, 58, 110, 77, 103, 78, 95, 106, 98, 96, 68, 96, 157, 198, 145, 132, 96, 135)
ad <- c(6, 27, 0, 0, 20, 0, 20, 0, 0, 18, 9, 0, 0, 0, 13, 25, 0, 15, 0, 0)
modfit <- lm(sales ~ ad)
summary(modfit)
plot(modfit)
ad.adstock <- as.numeric(filter(x=ad, filter=.50, method="recursive"))
modfit1 <- lm(sales ~ ad.adstock)
summary(modfit1)
plot(modfit1)

#Marketing Media Mix Model:
classroom <- read.csv("/Users/maheshgurumoorthi/Dropbox/online_classroom_data.csv")

str(classroom)

classroom$sk1_classroom <- as.numeric(classroom$sk1_classroom)
classroom$sk2_classroom <- as.numeric(classroom$sk2_classroom)
classroom$sk3_classroom <- as.numeric(classroom$sk3_classroom)
classroom$sk4_classroom <- as.numeric(classroom$sk4_classroom)
classroom$sk5_classroom <- as.numeric(classroom$sk5_classroom)

classroom$sk1_classroom[is.na(classroom$sk1_classroom)] <- 0
classroom$sk2_classroom[is.na(classroom$sk2_classroom)] <- 0
classroom$sk3_classroom[is.na(classroom$sk3_classroom)] <- 0
classroom$sk4_classroom[is.na(classroom$sk4_classroom)] <- 0
classroom$sk5_classroom[is.na(classroom$sk5_classroom)] <- 0




# classroom$classroominfo[is.na(classroom$classroominfo)] <- 0

library(tidyverse)
classroom <- classroom %>%
  mutate(classroominfo = sk1_classroom + sk2_classroom + sk3_classroom + sk4_classroom) %>%
  select(helpful_post, nice_code_post,collaborative_post, classroominfo) %>%
  rename(HelpfulPost = helpful_post, NiceCode = nice_code_post, CollaboratePost = collaborative_post, ClassroomInfor = classroominfo)

View(classroom)

install.packages("DataExplorer")
library(DataExplorer)
plot_missing(classroom)

library(corrplot)
library(gplots)
corrplot.mixed(corr = cor(classroom, use = "complete.obs"),
               upper = "ellipse",tl.pos = "lt",
               upper.col = colorpanel(50, "red", "gray60", "blue4"))

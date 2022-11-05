library(tidyverse)

carProd <- read_csv("Dataset/05/CarProduction.csv", show_col_types = FALSE)

head(carProd)

glimpse(carProd)

length(unique(carProd$Year))

carMalaysia <- ts(carProd$Malaysia, start = "1999", frequency = 1)

plot(carMalaysia, main = "Malaysia Car")

x.SESmodel <- HoltWinters(carMalaysia, beta=FALSE, gamma=FALSE)

plot(x.SESmodel, main="Malaysia Car")




# Japan
carJapan <- ts(carProd$Japan, start = "1999", frequency = 1)

plot(carJapan, main = "Japan Car")

x.SESmodel <- HoltWinters(carJapan, beta=FALSE, gamma=FALSE)

plot(x.SESmodel, main="Japan Car")
stop()
















lend <- read_csv("Dataset/accepted_2007_to_2018Q4.csv", 
                 show_col_types = FALSE)

head(lend, 3)

airbnb <- read_csv("Dataset/AB_NYC_2019.csv", show_col_types = FALSE)

dim(airbnb)

head(airbnb, 10)
View(airbnb)


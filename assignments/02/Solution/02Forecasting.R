library(tidyverse)

# HoltWinters is needed to forecast.
# It is already shipped with R

phoneplans <- read_csv("assignments/02/Dataset/PhonePlans.csv", show_col_types = FALSE)

# View(phoneplans)

# Convert phoneplans to time series
phoneplans.ts <- ts(phoneplans, start = 2005, frequency = 1)

# (A)

## Plot of the time series for Land lines in Developing Countries
landlinedeving.ts <- ts(phoneplans$LandLinesDeveloping, start = 2005, frequency = 1)
plot(landlinedeving.ts)

# (B)

## Single Exponential Model for Land lines for Developing Countries
model_landdeving.SESmodel <- HoltWinters(landlinedeving.ts, beta = FALSE, gamma = FALSE)
plot(model_landdeving.SESmodel, main = "Land lines for developing countries")


## Single Exponential Model for Land lines for Developing countries Using dplyr
phoneplans %>% 
  select(LandLinesDeveloping) %>% 
  ts(start = 2005, frequency = 1) %>% 
  HoltWinters(beta = FALSE, gamma = FALSE) %>% 
  plot(main = "Land lines for developing countries")


## Single Exponential model for Mobile plans for developing countries
mobplandeving.ts <- ts(phoneplans$MobilePlansDeveloping, start = 2005, frequency = 1)
model_mobplandeving.SESmodel <- HoltWinters(mobplandeving.ts, beta = FALSE, gamma = FALSE)
plot(model_mobplandeving.SESmodel, main = "Mobile plans for developing countries")



## Single Exponential model for phone plans for Developing countries Using dplyr
phoneplans %>% 
  select(MobilePlansDeveloping) %>% 
  ts(start = 2005, frequency = 1) %>% 
  HoltWinters(beta = FALSE, gamma = FALSE) %>% 
  plot(main = "Mobile Plans for developing countries")


# (C)
## Predict number of land lines in 2022
predict(model_landdeving.SESmodel, 1)

## Predict number of mobile plans in 2022
predict(model_mobplandeving.SESmodel, 1)


# (D)

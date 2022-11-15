library(tidyverse)

library(fastDummies)

coffee <- read_csv("docs/readings/08/CoffeeShops.csv", show_col_types = F)

head(coffee)

length(unique(coffee$Type))

coffee.new <- dummy_cols(coffee, select_columns = "Type")

coffee.new

coffee.MLModel <- lm(Sales ~ Temperature + Type_Full + Type_InStore, coffee.new)

summary(coffee.MLModel)


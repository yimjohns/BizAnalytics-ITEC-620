library(tidyverse)


tribble(
  ~ColdMedicine, ~Bandages, ~Painkillers, ~TopicalCream, ~Antiseptic,
  1, 0, 0, 0, 0,
  0, 1, 1, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 1,
  0, 1, 0, 0, 1
) -> Purchases

newPurchases <- read_csv("Dataset/purchases.csv", show_col_types = F)

class(newPurchases)


write_csv(Purchases, "Dataset/purchases.csv")

x <- Purchases[ , 1:3]

class(x)


Purchases[Purchases$Painkillers==1,]


Purchases[,c("TopicalCream", "Antiseptic")]

x <- Purchases[1,1] > 0.5
x

typeof(x)

Purchases > 0.5


x <- ts(Purchases$Bandages)
x

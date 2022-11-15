library(tidyverse)

camry = read_csv("../BizAnalytics/docs/dataset/08/Camry.csv", show_col_types = F)

camry.SLRModel <- lm(Price ~ Miles, camry)

summary(camry.SLRModel)



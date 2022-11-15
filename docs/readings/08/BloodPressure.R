library(tidyverse)

bp <- read_csv("docs/readings/08/BloodPressure.csv", show_col_types = F)

head(bp)

bp.MLModel <- lm(BloodPressure ~ Age + Weight + Female, bp)

summary(bp.MLModel)

new.points <- data.frame(
  Age = 40,
  Weight = 170,
  Female = 0
)

predict(bp.MLModel, newdata = new.points)

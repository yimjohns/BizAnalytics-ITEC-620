library(tidyverse)
library(arules)

tvshows <- read_csv("Dataset/TVShows.csv", show_col_types = FALSE)

View(tvshows)

tvshows.binary <- tvshows > 0.5

rules <- apriori(tvshows.binary, parameter = list(supp=0.01, conf=0.1))

inspect(rules)

rules.sorted <- rules[order("subscribers")]

rules3 <- apriori(tvshows.binary, parameter = list(supp=0.01, conf = 0.1, minlen = 2),
                  appearance = list(default = "rhs", lhs="Archer"))

inspect(rules3)

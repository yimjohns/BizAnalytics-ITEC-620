library(tidyverse)
library(arules)

principal <- read_csv("../BizAnalytics/assignments/02/Dataset/Principal.csv", 
                      show_col_types = FALSE)

# View(principal)
principal.binary <- principal >= 0.1


# Parameters: support = 0.03, confidence = 0.08
# Operation: Sort by confidence in the descending order
# My preference is to use dplyr as in methods 1 and 2.
# Method 3 is what we were taught in class.
# I have written all the methods out for any future reference.

# Method 1
principal.binary %>% 
  apriori(parameter = list(supp = 0.03, conf = 0.08), data = .) %>% 
  sort(by = "confidence") -> principal.rules
inspect(principal.rules)

# Method 2
principal.binary %>% 
  apriori(parameter = list(supp = 0.03, conf = 0.08), data = .) %>% 
  sort(by = "confidence") -> principal.rules2
inspect(principal.rules2)

# Method 3 - Method in class
rules <- apriori(principal.binary, parameter = list(supp = 0.03, conf = 0.08))
princip.rules <- sort(rules, by = "confidence")
inspect(princip.rules)

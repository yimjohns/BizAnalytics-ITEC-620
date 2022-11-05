library(cluster)
library(DMwR)
library(tidyverse)
# Read the data
Employees <- read_csv("Dataset/Employees.csv", show_col_types = F)

# Normalize the data
Employees.norm <- scale(Employees)

# Seeding for uniformity
set.seed(12345)

# Do the KMeans Clustering
Employees.norm %>% 
  kmeans(4, nstart = 10) -> Employees.kmclusters

Employees.kmclusters$centers

Employees.kmclusters$size
# Another way to do the KMeans Clustering
Employees.kmclusters2 <- kmeans(Employees.norm, 4, nstart = 10)
Employees.kmclusters2$size


unscale(Employees.kmclusters2$centers, Employees.norm)

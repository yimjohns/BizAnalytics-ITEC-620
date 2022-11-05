library(tidyverse)
library(FactoMineR)
library(factoextra)
library(cluster)
library(DMwR)

dell <- read_csv("Dataset/Dell.csv", show_col_types = F)

dell.norm <- scale(dell)

set.seed(12345)

dell.kmclusters <- kmeans(dell.norm, 3, nstart = 10)

dell.centroid <- dell.kmclusters$centers

dell.size <- dell.kmclusters$size

unscale(dell.centroid, dell.norm)

fviz_cluster(dell.kmclusters, dell.norm)

# Silhouette
dell.norm %>% 
  fviz_nbclust(kmeans, method = "silhouette")

# WSS
dell.norm %>% 
  fviz_nbclust(kmeans, method = "wss")

wssplot(kmeans)
# Gap_Stat
dell.norm %>% 
  fviz_nbclust(kmeans, method = "gap_stat")

fviz_nbclust(dell.norm, )
fviz_nbclust(dell.norm, kmeans, method = "silhouette")

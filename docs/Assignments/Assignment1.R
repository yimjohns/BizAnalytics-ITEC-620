library(tidyverse)
library(cluster)
library(DMwR)

Damon <- read_csv("Dataset/Damon.csv", show_col_types = FALSE)

dim(Damon)


Damon[12 , ]

mean(Damon$BoxOffice)

min(Damon$Rating)

Damon[(Damon["Rating"] >= 8), ]


Damon %>% 
  select(Rating, BoxOffice) %>% 
  scale() -> Damon.norm
Damon.norm

set.seed(12345)

Damon.norm %>% 
  kmeans(3, nstart = 10) -> Damon.kmcluster
Damon.kmcluster$centers


Damon.kmcluster$size


Damon.kmcluster <- kmeans(Damon.norm, 3, nstart = 10)
Damon.kmcluster$centers

unscale(Damon.kmcluster$centers, Damon.norm)


Damon2 <- Damon[ , -1]
Damon2

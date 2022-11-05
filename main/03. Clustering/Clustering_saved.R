##############
# Clustering #
##############

# Prepared by Jay Simon
# Last updated on 7/23/2022

# This script is intended for use in ITEC 620: Business Insights through Analytics at American University

# This script provides a demonstration of how to perform k-means and hierarchical clustering in R
# The script uses the mtcars data set.

# Packages required: cluster, ggdendro, factoextra, FactoMineR
# install.packages("FactoMineR")
# install.packages("cluster")
# install.packages("ggdendro")
# install.packages("factoextra")
# install.packages("remotes")
# remotes::install_github("cran/DMwR")
# install.packages("FactoMineR")
install.packages("hclust")


library(cluster)
library(ggdendro)
library(factoextra)
library(FactoMineR)
library(tidyverse)
library(DMwR)
library(hclust)

# If you have not installed & loaded the "cluster" package, do so before continuing.


# Before clustering, we will want to normalize the data set.
# The following command converts the mtcars data set into standardized values (z-scores)
# mtcars.norm <- scale(mtcars) - Commented out - Oluwayimika Johnson

mtcars.norm <- as.vector(scale(mtcars)) # Added - Oluwayimika Johnson
mtcars.norm <- scale(mtcars)

class(mtcars.norm) # Added - Oluwayimika Johnson
# The set.seed function sets the starting point for random number generation
# When using the same seed, random processes will always produce the same output
# It's useful for being able to reproduce your results
# Always run this command immediately before the command that uses randomness
set.seed(12345)

# "kmeans" is the function that applies k-means clustering to a data set
# The following command uses k-means clustering to split the data into 3 clusters
# ----------------------------------------------------------------------------- 
# Doing kmeans using forward piping - Johnson
# -----------------------------------------------------------------------------
# mtcars.norm %>% 
#   kmeans(3, nstart = 10) -> mtcars.kmclusters2
# mtcars.kmclusters2$centers

mtcars.kmclusters <- kmeans(mtcars.norm, 3, nstart=10)

# The following command displays the centroids of the 3 clusters (in z-scores)
mtcars.kmclusters$centers

# We then need to convert the centroids back into their original units.
# THE PACKAGE THAT WAS USED FOR THIS IS NO LONGER AVAILABLE.
# INSTEAD, RUN THE BLOCK OF CODE ON LINES 89-101 THAT DEFINES THE UNSCALE FUNCTION BEFORE PROCEEDING.

# The following command shows the centroids in original units
unscale(mtcars.kmclusters$centers, mtcars.norm)

# The following command displays the sizes (# of data points) of the 3 clusters
mtcars.kmclusters$size

# Create a scatterplot of the clusters, condensed into two dimensions (requires the factoextra package)
fviz_cluster(mtcars.kmclusters,mtcars.norm)

# Each dimension is a weighted combination of variables
# fviz_cluster uses principal component analysis (PCA) to create the two dimensions
# Running PCA directly can give us more information about them (requires the FactoMineR package)
mtcars.PC <- PCA(mtcars.norm)

# fviz_contrib shows the % breakdown of each variable's contribution to each dimension
fviz_contrib(mtcars.PC, choice = "var", axes = 1)
fviz_contrib(mtcars.PC, choice = "var", axes = 2)

# fviZ_contrib doesn't show if the variables' contributions are positive or negative
# The following command will give us that information (we only care about Dim.1 and Dim.2)
mtcars.PC$var$cor
# In this case, for example, a high mpg decreases Dim.1
# If you know a lot about cars, you can probably describe exactly what Dim.1 is capturing!





# "hclust" is the function that applies hierarchical clustering to a data set
# The following two commands will apply hierarchical clustering using the centroid method
distances <- dist(mtcars.norm, method="euclidean")

mtcars.hclusters <- hclust(distances, method="centroid")
mtcars.hclusters
# See online documentation for the hclust function for additional methods (e.g. Ward's method).

# We will need the "ggdendro" package to get a good display of the dendrogram
# Install and load the ggdendro package before proceeding, if you have not already

#The following command creates a dendrogram
#Set labels to FALSE if you do not want the labels for each data point to appear
ggdendrogram(mtcars.hclusters, labels=TRUE)

#Click "Zoom" above the plot to show the dendrogram in a new window for a better display
#Use the "Export" options above the plot to transfer the dendrogram outside of R




# The following block of code defines the unscale function (formerly part of the DMwR package that is no longer available)
unscale <- function (vals, norm.data, col.ids)
{
  cols <- if (missing(col.ids))
    1:NCOL(vals)
  else col.ids
  if (length(cols) != NCOL(vals))
    stop("Incorrect dimension of data to unscale.")
  centers <- attr(norm.data, "scaled:center")[cols]
  scales <- attr(norm.data, "scaled:scale")[cols]
  unvals <- scale(vals, center = (-centers/scales), scale = 1/scales)
  attr(unvals, "scaled:center") <- attr(unvals, "scaled:scale") <- NULL
  unvals
}

###################
# Dummy Variables #
###################

# Prepared by Jay Simon
# Last updated on 11/10/2021

# This script is intended for use in ITEC 620: Business Insights through Analytics at American University

# This script demonstrates how to create dummy variables from a categorical variable in R three different ways.
# The script uses the chickwts data set. This data set contains the "weight" (numeric) and type of "feed" (text) for 71 chickens.
# For further explanation of the data set, see https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/chickwts.html

# In this script, we create a dummy variable for every value of the categorical variable.
# Note that in some methods, such as linear regression, one value should be omitted and treated as the base case.

#To view the data set:
chickwts

head(chickwts)

length(unique(chickwts$feed))
# METHOD 1

# The key function is model.matrix.  It will create a dummy variable for each value of a category variable and store them in a new data set
feeds <- model.matrix(~feed-1, data=chickwts)

#We can then add these new dummy variables to the chickwts data set (shown with two different syntaxes; using either the column number or name will work)
chickwts$casein <- feeds[,1]
chickwts$horsebean <- feeds[,2]
chickwts$linseed <- feeds[,3]
chickwts$meatmeal <- feeds[,'feedmeatmeal']
chickwts$soybean <- feeds[,'feedsoybean']
chickwts$sunflower <- feeds[,'feedsunflower']

#To view the updated data set:
chickwts


# METHOD 2

#First, remove the added columns to get back the original chickwts data if you already ran method 1.
chickwts <- chickwts[,1:2]

#Then use the ifelse function to create a new column for each type of feed:
chickwts$horsebean <- ifelse(chickwts$feed == 'horsebean',1,0)
chickwts$linseed <- ifelse(chickwts$feed == 'linseed',1,0)
chickwts$soybean <- ifelse(chickwts$feed == 'soybean',1,0)
chickwts$sunflower <- ifelse(chickwts$feed == 'sunflower',1,0)
chickwts$meatmeal <- ifelse(chickwts$feed == 'meatmeal',1,0)
chickwts$casein <- ifelse(chickwts$feed == 'casein',1,0)

#To view the updated data set:
chickwts


# METHOD 3

#Again, remove the added columns to get back the original chickwts data if you already ran a previous method:
chickwts <- chickwts[,1:2]

#Then use the dummy_cols function from the fastDummies package (install before running this code):
install.packages("fastDummies")
library(fastDummies)
chickwts <- dummy_cols(chickwts, select_columns='feed')

#That's it!  To view the updated data set:
chickwts

feed_MLModel <- lm(weight ~ casein + horsebean + linseed + meatmeal + soybean, chickwts)

summary(feed_MLModel)

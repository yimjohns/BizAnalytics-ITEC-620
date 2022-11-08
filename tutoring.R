library(tidyverse)

# Show all the data sets available in R
data() 

# Displays the first 6 rows in the data set.
head(trees)

# Display the number of rows and columns in a data set
dim(trees)

# View the entire data set in another tab - 
# Notice that V is in upper case
View(trees)

# Read an external csv file
voter <- read_csv("Dataset/05/CarProduction.csv", show_col_types = FALSE)

head(voter)

voter[ , 1:5]


#######################
# ITEC 620 - R Basics #
#######################

# This script provides an introduction to R syntax and some common tasks and commands.
# It is intended for use in ITEC-620: Business Insights through Analytics, at American University

# Anything in this document preceded by a pound sign is a comment, and is not intended to be entered into the R console.
# Everything else can be copied and pasted into the R console.
# or executed by moving the cursor to that line and clicking "Run" in the menu above.
# If you select multiple lines and click "Run," all of the selected lines will be executed in order.


# The <- operator assigns something to a variable, in this case, the number 5.
# If the variable does not exist already, R creates it automatically.
# When you enter the name of the variable, R will display whatever it contains.
x <- 5
x

# You may have heard R described as an "object oriented" language.
# In the above lines of code, x is an object.
# In this case, it contains only a number, but objects can contain many different things.

# An object can contain a vector of numbers.  The "c" function combines the individual numbers into a vector.
x <- c(1,5,12,33,100)
x

# You can refer to individual elements of that vector.
x[4]

# You can also exclude elements from a vector; the following command displays all of the elements except the 4th.
x[-4]

# The following syntax assigns a vector of all numbers from 1 to 10 to the variable x.
x <- 1:10
x

# The data() command displays a list of the data sets currently loaded to R.
# You should already have some that came with the version of R you downloaded.
# More will be included with some packages you'll install later.
# You can also import data sets from Excel, HTML, etc.
data()

# The head command shows the first several rows of a dataset.
head(mtcars)

# You can refer to a single cell of the data set; the following command shows the top-left cell:
mtcars[1,1]

# You can refer to entire rows or columns of data:
mtcars[2,]
mtcars[,4]
mtcars[,"hp"] # Referring to columns by name also works
mtcars$hp # The $ notation is more general.  It's how we can refer to a property of any kind of object, not just one that contains data.
?paste

# The paste command combines multiple components into a text string.
# The individual components may be either text or variables.
print(paste("The Mazda RX4's mpg is",mtcars[1,1]))

# If this command is used by itself, the print function is not needed
# However, when it's embedded within more involved code, the output won't be displayed unless the print function is used.


# There are many functions in R that take data as inputs.
# For example, the following command computes the average of the first column of data (mpg) in the mtcars data set.
mean(mtcars[,1])

# The following function shows the correlations between all pairs of variables in the mtcars data set.
cor(mtcars)

# Because R is a programming language, it can do more complicated tasks than just individual functions one at a time.
# It's possible to create long & complex sequences of commands.
# There are two very common structures of commands that will be helpful to learn.

# The first is if/else commands.
# The "if" command allows you to display different output or do different computations depending on whether or not a condition is met.
# You can have an "if" command without an "else" following it; nothing will happen when the condition isn't met.
# For example, the following four lines check whether the mean mpg is greater than the median mpg, and then tells us which way the data are skewed.
if(mean(mtcars[,1])>median(mtcars[,1]))
{print("Skew right")
} else
{print("Skew left")}

# The second is a for loop.
# The purpose of a for loop is to carry out the same command or sequence of commands repeatedly, usually for each element of an array.
# It uses a variable called an "index." In the example below, the variable i is the index.
# The code inside the for loop will run for every value of i between 1 and 5.
for (i in 1:5) {
  print(paste("Car number", i, "has an mpg of", mtcars[i,1]))
}

# The index of a for loop usually takes numeric values, but it doesn't have to.  Let's say we want information about a few specific variables:
vars <- c("mpg","cyl","hp")
for (i in vars) {
  print(paste(i,"summary statistics:"))
  print(summary(mtcars[,i]))
}

# Looping over an entire dataset is generally not recommended.  It can be extremely slow with very large datasets.
# A better approach is to use vector operations.
# For instance, let's say we want to convert the mpg numbers to liters per 100 kilometers and store that as a new column.
km_per_m <- 1.60934
l_per_g <- 3.78541
mtcars[,"l_per_100k"] <- 100*l_per_g / (mtcars[,"mpg"]*km_per_m)
head(mtcars)
# Notice that in the 3rd line here, we applied the same calculation to all of the mpgs.  R can do that very quickly, even for large datasets.

# We can also retrieve only the rows that meet a condition we specify
# The "==" notation checks if two values are equal;
# here, it's checking whether the number of cylinders for each car is 8
mtcars_8cyl <- mtcars[mtcars$cyl==8,]
mtcars_8cyl
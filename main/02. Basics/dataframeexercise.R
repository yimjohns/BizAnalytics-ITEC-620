# library(tidyverse)

View(Orange)

# Question 1
Orange[1 , ]


# Question 2
cor(Orange$age, Orange$circumference)
cor(Orange[ , 2:3])


# Question 3
Orange[ , 1]
Orange[Orange$Tree==4,]

# Question 4
cor(Orange$age[4], Orange$circumference[4])
cor(Orange[Orange$Tree==4,2:3])

cor(Orange[Orange$Tree==4,c("age","circumference")])


# Question 5
Orange[ , "diameter"] <- Orange$circumference / pi
View(Orange)

Orange[,"diameter"] <- Orange[,"circumference"] / pi
View(Orange)

for(i in 1:5){
  print(max(Orange$diameter[i]))
}

for (i in 1:5) {
  print(paste("The largest diameter for tree",i,"is",max(Orange[Orange$Tree==i,"diameter"])))
}

aggregate(diameter ~ Tree, data=Orange, max)

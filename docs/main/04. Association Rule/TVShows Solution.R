
TVShows <- read.csv("TVShows.csv", header=T)

TVShows.binary <- TVShows > 0.5

rules <- apriori(TVShows.binary, parameter = list(supp=0.01, conf=0.1),minlen=2)


#A


rules3 <- apriori(TVShows.binary, parameter = list(supp=0.01, conf=0.1,minlen=2), appearance = list (default="rhs",lhs="Archer"))

inspect(rules3)

#The rule with highest confidence and lift is Ash vs. Evil Dead

#B

#to fine rules Game.of.Thrones as premise:

rules4 <- apriori(TVShows.binary, parameter = list(supp=0.01, conf=0.1,minlen=2), appearance = list (default="rhs",lhs="Game.of.Thrones"))

inspect(rules4)
# The rule with highest confidence is Archer

#C

rules5 <- apriori(TVShows.binary, parameter = list(supp=0.01, conf=0.1,minlen=2), appearance = list (default="rhs",lhs="You.re.the.Worst"))

inspect(rules5)
#one(s) with the highest confidence or lift ratio. Depending on the cutoffs you used to generate the set of rules, it is likely to be Red Oaks or Archer.

#D
rules <- apriori(TVShows.binary, parameter = list(supp=0.01, conf=0.1))
rules.sorted6 <- sort(rules, by="lift")
inspect(rules.sorted6)

# The rules with highest lify ratio: Broad City and Bojack Horseman



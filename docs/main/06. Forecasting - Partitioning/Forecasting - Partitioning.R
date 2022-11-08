###############
# Forecasting #
###############

# Prepared by Jay Simon
# Last updated on 10/31/2021

# This script is intended for use in ITEC 620: Business Insights through Analytics at American University

# This script provides a demonstration of how to partition a time series, which then allows us to
# compare models based on predictive accuracy instead of goodness of fit.
# The script uses the USAccDeaths data set. This data set contains monthly accidental deaths in the US from 1973-1978

# We will build the models using only a "training" set of data that excludes some recent data points (called a "test" set)
# We will then compare their mean squared errors of the predicted values for the test set vs. the actual values in those periods

# First, create the training and test sets.  Here, we're taking the first 4 years (which leaves out the last 2 years of data)
# These three variables state the number of data points in the training and test sets, and the length of each cycle
# Omit the cycle variable if no models with seasonality will be used
train.periods <- 48
test.periods <- 24
cycle <- 12
x.training <- ts(USAccDeaths[1:train.periods],start=1973,freq=cycle)

# Let's also store the full time series in x, which we'll need later:
x <- ts(USAccDeaths,start=1973,freq=cycle)

length(USAccDeaths)
# Then, build each of the three models using the training set
x.training.SESmodel <- HoltWinters(x.training, beta=FALSE, gamma=FALSE)
x.training.DESmodel <- HoltWinters(x.training, gamma=FALSE)
x.training.HWmodel <- HoltWinters(x.training)

# Because exponential smoothing uses the new data points when making subsequent predictions, we cannot simply compare
# the predictions from these training models to the actual recent data.  Instead, we create models for the full time series
# and force them to take the values of alpha/beta/gamma from the training models.
x.SESmodel <- HoltWinters(x, alpha=x.training.SESmodel$alpha, beta=FALSE, gamma=FALSE)
x.DESmodel <- HoltWinters(x, alpha=x.training.DESmodel$alpha, beta=x.training.DESmodel$beta, gamma=FALSE)
x.HWmodel <- HoltWinters(x, alpha=x.training.HWmodel$alpha, beta=x.training.HWmodel$beta, gamma=x.training.HWmodel$gamma)

# Now we can compute MSE on the most recent two years of data with each model

# First, specify the starting & ending indices of the time series to use
data.start <- train.periods + 1
data.end <- train.periods + test.periods

# Then, for each model, specify the starting & ending indices of the fitted values to use, and compute MSE

fit.start <- train.periods # The fitted points for SES start in period 2, so we want to begin 1 row before the test set starting row number
fit.end <- train.periods + test.periods - 1
SES.MSE <- sum((x.SESmodel$fitted[fit.start:fit.end] - x[data.start:data.end])^2) / (test.periods)

fit.start <- train.periods - 1 # The fitted points for DES start in period 3, so we want to begin 2 rows before the test set starting row number
fit.end <- train.periods + test.periods - 2
DES.MSE <- sum((x.DESmodel$fitted[fit.start:fit.end] - x[data.start:data.end])^2) / (test.periods)

fit.start <- train.periods - cycle + 1 # The fitted points in HW skip the first cycle, so we want to begin 1 cycle's worth of rows before the test set starting row number
fit.end <- train.periods + test.periods - cycle
HW.MSE <- sum((x.HWmodel$fitted[fit.start:fit.end] - x[data.start:data.end])^2) / (test.periods)

cat(paste("SES MSE =",SES.MSE,"\nDES MSE =",DES.MSE,"\nHW MSE =",HW.MSE))
# (the cat function can produce cleaner output than the print function when special characters like newlines are needed.)

# We can use the same "predict" and "plot" commands from the Forecasting.R script
predict(x.HWmodel, 12)
plot(x.HWmodel)

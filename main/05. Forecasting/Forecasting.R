###############
# Forecasting #
###############

# Prepared by Jay Simon
# Last updated on 10/31/2021

# This script is intended for use in ITEC 620: Business Insights through Analytics at American University

# This script provides a demonstration of several time series forecasting techniques in R
# There is also code at the end showing how to compute mean squared error (MSE)
# The script uses the USAccDeaths data set. This data set contains monthly accidental deaths in the US from 1973-1978

# This script relies on the HoltWinters function that comes with R
# The forecast & xts packages have additional time series functions, but they are not needed in this course
data("USAccDeaths")

View(USAccDeaths)
class(USArrests)
# Before running any forecasting methods, we need to store our data explicitly as a time series using the ts function

# The following command stores the accidental death data as a time series contained by the variable x
# The start parameter tells R the starting date of the time series
# The freq parameter tells R how many periods ("seasons") there are; in this case, we have monthly data, so there are 12-period cycles
x <- ts(USAccDeaths,start=1973,freq=12)

USDeaths <- as.data.frame(USAccDeaths)

ts_USDeath <- ts(USDeaths, start = 1973, frequency = 12)

ts_USAccDeaths <- ts(USAccDeaths, start = 1973, freq=12)



# Note: if the data set has multiple columns, you must specify the name of the column as well
# For instance, if the USAccDeaths data set had separate columns for each state, and we wanted to analyze
# the Maryland column, the command would be:
x <- ts(USAccDeaths$Maryland,start=1973,freq=12)
# (Of course, this exact command will produce an error, because the data set does not have a column called Maryland.)

# If there is no start date, omit the "start" parameter, and the points will be numbered starting at 1.
# If the data are not seasonal (i.e. do not have a fixed # of repeating periods), omit the "freq" parameter.

# The following command shows the time series
plot(x, main="US Accidental Deaths")

# The following command fits a single exponential smoothing model to the data, and stores it in a variable called x.SESmodel
# It automatically optimizes the parameters (in this case, alpha is the only parameter used)
x.SESmodel <- HoltWinters(x, beta=FALSE, gamma=FALSE)

# The following command shows the model's output (including parameter values)
x.SESmodel

# The following command shows the time series along with the model
plot(x.SESmodel, main="US Accidental Deaths: SES Model")

# The following command uses the model to predict the next period
predict(x.SESmodel,1)


# The following command fits a double exponential smoothing model to the data, and stores it in a variable called x.DESmodel
x.DESmodel <- HoltWinters(x, gamma=FALSE)

# The same commands we used for the single exponential smoothing model will still work (replace x.SESmodel with x.DESmodel):
x.DESmodel
plot(x.DESmodel)
predict(x.DESmodel,1)


# The following command fits a Holt-Winters smoothing model to the data, and stores it in a variable called x.HWmodel
x.HWmodel <- HoltWinters(x)

# It uses additive seasonal factors by default; the following command will use multiplicative seasonal factors instead
x.HWmodel.mult <- HoltWinters(x,seasonal="multiplicative")

# The same commands we used for the earlier models will still work, with a couple of modifications
x.HWmodel
plot(x.HWmodel)

# We may want to forecast an entire set of periods, instead of only the next period
predict(x.HWmodel,12)


# It is possible to compare the models informally simply by looking at the plots we've generated
# Or, we can use mean squared error (MSE) as a metric to tell us how well each model fits the data

x <- ts(USAccDeaths,start=1973,freq=12)
x.SESmodel <- HoltWinters(x, beta=FALSE, gamma=FALSE)
x.DESmodel <- HoltWinters(x, gamma=FALSE)
x.HWmodel <- HoltWinters(x)

# Each of the following lines divides the sum of squared errors (a property included with each model) by the number of forecasts made.
# That gives us MSE
x.SESmodel$SSE / nrow(x.SESmodel$fitted)
x.DESmodel$SSE / nrow(x.DESmodel$fitted)
x.HWmodel$SSE / nrow(x.HWmodel$fitted)
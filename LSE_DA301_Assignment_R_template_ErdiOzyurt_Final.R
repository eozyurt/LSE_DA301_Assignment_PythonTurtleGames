## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
##performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points (Week 1)
## - how useful are remuneration and spending scores data (Week 2)
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns (Week 3)
## - what is the impact on sales per product (Week 4)
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
##     (Week 5)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales (Week 6).

################################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, Year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
install.packages("tidyverse")
library(tidyverse)

# Import the data set.
turtle_sales <- read.csv('turtle_sales.csv', header=T)

# Print the data frame.
view(turtle_sales)


# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
turtle_sales_subset <- select(turtle_sales, -c(Ranking, Year, Genre, Publisher))

# View the data frame.
head(turtle_sales_subset)

# View the descriptive statistics.
summary(turtle_sales_subset)
as_tibble(turtle_sales_subset)

# Create a report to explore the data set in more detail
library(DataExplorer)
create_report(turtle_sales_subset)

################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots
# Create scatterplots.
qplot(NA_Sales,
      EU_Sales,
      colour=Global_Sales,
      data=turtle_sales_subset)

qplot(NA_Sales,
      Global_Sales,
      data=turtle_sales_subset)

qplot(EU_Sales,
      Global_Sales,
      data=turtle_sales_subset)

## 2b) Histograms
# Create histograms.
qplot(NA_Sales, data=turtle_sales_subset)
qplot(EU_Sales, data=turtle_sales_subset)
qplot(Global_Sales, data=turtle_sales_subset)

## 2c) Bar Chart
qplot(Platform, data=turtle_sales_subset)


## 2c) Boxplots
# Create boxplots.
qplot(EU_Sales, Platform, data=turtle_sales_subset, geom='boxplot')
qplot(NA_Sales, Platform, data=turtle_sales_subset, geom='boxplot')
qplot(Global_Sales, Platform, data=turtle_sales_subset, geom='boxplot')

###############################################################################

# 3. Observations and insights

## Your observations and insights here ......

## By looking at the bar chart above there seem to be a positive correlation 
## between NA sales, EU sales and Global Sales, this will need to be further 
## analysed in  more detail. 

## The histograms of the EU sales, NA sales and Global sales are all skewed 
## to the right 


###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and maniulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 3. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 4. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 5. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 6. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4.
view(turtle_sales_subset)

# Check output: Determine the min, max, and mean values.
sales_turtle <- select(turtle_sales_subset, c('NA_Sales',
                                   'EU_Sales',
                                   'Global_Sales'))

sales_turtle_min <- sapply(sales_turtle, min)
sales_turtle_min
sales_turtle_max <- sapply(sales_turtle, max)
sales_turtle_max
sales_turtle_mean <- sapply(sales_turtle, mean)
sales_turtle_mean

# View the descriptive statistics.
summary(turtle_sales_subset)

###############################################################################

# 2. Determine the impact on sales per product_id.

## 2a) Use the group_by and aggregate functions.
# Group data based on Product and determine the sum per Product.
turtle_sales_product <- turtle_sales_subset %>% 
  group_by(Product) %>%
  summarise(total_sales_NA = sum(NA_Sales),
            total_sales_EU = sum(EU_Sales),
            total_sales_Global = sum(Global_Sales))

# Transform the Product column into a categorical column
turtle_sales_product$Product <- as.character(turtle_sales_product$Product)

# View the data frame.
view(turtle_sales_product)
turtle_sales_product

# Explore the data frame.
summary(turtle_sales_product)

# Add a new column with the percentage of sales
sales_pct <- turtle_sales_product %>%
  mutate(sales_pct = total_sales_Global/sum(total_sales_Global) * 100) %>%
  arrange(desc(sales_pct))

view(sales_pct)
summary(sales_pct)
sales_pct

# We will now create a boxplot to better understand the distribution of the sales_pct column
ggplot(sales_pct,
       aes(y=sales_pct)) +
  geom_boxplot() +
  labs(title="Total Global Sales Boxplot percentage per product") +
  scale_y_continuous(limits = c(0, 2))


## 2b) Determine which plot is the best to compare game sales.
# Create scatterplots.

ggplot(turtle_sales_product,
       aes(x=total_sales_NA, y=total_sales_EU, col = total_sales_Global)) +
  geom_point() +
  geom_smooth(se = FALSE) +
    labs(title="Relationship between NA Sales and EU Sales")

# Create histograms.
ggplot(turtle_sales_product,
       aes(x=total_sales_NA)) +
  geom_histogram() +
    labs(title="Total NA Sales")

ggplot(turtle_sales_product,
       aes(x=total_sales_EU)) +
  geom_histogram() +
  labs(title="Total EU Sales")

ggplot(turtle_sales_product,
       aes(x=total_sales_Global)) +
  geom_histogram() +
  labs(title="Total Global Sales")

# Create boxplots.
ggplot(turtle_sales_product,
       aes(y=total_sales_NA)) +
  geom_boxplot() +
  labs(title="Total NA Sales Boxplot") +
  scale_y_continuous(limits = c(0, 15))

ggplot(turtle_sales_product,
       aes(y=total_sales_EU)) +
  geom_boxplot() +
  labs(title="Total EU Sales Boxplot") +
  scale_y_continuous(limits = c(0, 15))

ggplot(turtle_sales_product,
       aes(y=total_sales_Global)) +
  geom_boxplot() +
  labs(title="Total Global Sales Boxplot") +
  scale_y_continuous(limits = c(0, 30))


###############################################################################


# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots
# Create Q-Q Plots.
# Q-Q Plots for NA Sales
qqnorm(sales_turtle$NA_Sales)
qqline(sales_turtle$NA_Sales)

# Q-Q Plots for EU Sales
qqnorm(sales_turtle$EU_Sales)
qqline(sales_turtle$EU_Sales)

# Q-Q Plots for Global Sales 
qqnorm(sales_turtle$Global_Sales)
qqline(sales_turtle$Global_Sales)


## 3b) Perform Shapiro-Wilk test
# Install and import Moments.
library(moments)

# Perform Shapiro-Wilk test.
# NA Sales 
shapiro.test(sales_turtle$NA_Sales)
# Our output is smaller than 0.5, and we can't assume normality.

# EU Sales
shapiro.test(sales_turtle$EU_Sales)
# Our output is smaller than 0.5, and we can't assume normality.

# Global Sales
shapiro.test(sales_turtle$Global_Sales)
# Our output is smaller than 0.5, and we can't assume normality.


## 3c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.
# NA Sales 
skewness(sales_turtle$NA_Sales)
kurtosis(sales_turtle$NA_Sales)

# EU Sales
skewness(sales_turtle$EU_Sales)
kurtosis(sales_turtle$EU_Sales)

# Global Sales
skewness(sales_turtle$Global_Sales)
kurtosis(sales_turtle$Global_Sales)

## 3d) Determine correlation
# Determine correlation.
# NA Sales Vs EU Sales
cor(sales_turtle$NA_Sales, sales_turtle$EU_Sales)

# NA Sales Vs Global Sales
cor(sales_turtle$NA_Sales, sales_turtle$Global_Sales)

# EU Sales Vs Global Sales
cor(sales_turtle$EU_Sales, sales_turtle$Global_Sales)

###############################################################################

# 4. Plot the data
# Create plots to gain insights into data.
# Choose the type of plot you think best suits the data set and what you want 
# to investigate. Explain your answer in your report.

# We will add a new column with the percentage of sales
sales_pct <- turtle_sales_product %>%
  mutate(sales_pct = total_sales_Global/sum(total_sales_Global) * 100) %>%
  arrange(desc(sales_pct))

summary(sales_pct)

# We will now create a boxplot to better understand the distribution of the sales_pct column
ggplot(sales_pct,
       aes(y=sales_pct)) +
  geom_boxplot() +
  labs(title="Total Global Sales Boxplot") +
  scale_y_continuous(limits = c(0, 2))

###############################################################################

# 5. Observations and insights
# Your observations and insights here...
## Looking at the Q-Q plot for the NA , EU and Global sales these don't seem 
## to be a good fit for a normal distribution, the points aren't seating on 
## the vertical line.

## The Shapiro test has a really small p-value for all sales so this indicates
## that we can reject the null hypothesis and that the data isn't normally
## distributed. We can also confirm with the skewness that the data is skewed 
## to the right. The high kurtosis value also confirm what the Q-Q plot shows
## that the data is heavy tailed. 

## Looking at the correlation the NA, EU and Global sales have a strong positive correlation
## between each other. The strongest correlation is between NA sales and Global Sales 
## with a value of 0.934 and the weakest is between NA and Eu sales with a value
## of 0.705.


###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
##  - NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
##  - NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
##  - NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
##  - NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explor the data
# View data frame created in Week 5.
View(turtle_sales_product)

# Determine a summary of the data frame.
summary(turtle_sales_product)
turtle_sales_product

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns
# Create a linear regression model on the original data.
model1 <- lm(total_sales_EU ~ total_sales_NA, data = turtle_sales_product)
summary(model1)

## 2b) Create a plot (simple linear regression)
# Basic visualisation.
plot(model1$residuals)
plot(turtle_sales_product$total_sales_EU, turtle_sales_product$total_sales_NA)
abline(coefficients(model1))

###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
model2 <- lm(total_sales_Global ~ total_sales_EU + total_sales_NA, 
             data = turtle_sales_product)
summary(model2)

# Multiple linear regression model.
plot(model2$residuals)

###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.
sales_turtle_forecast <- data.frame(total_sales_NA = c(34.02, 3.93, 2.73, 
                                                       2.26, 22.08), 
                                    total_sales_EU = c(23.80, 1.56, 0.65, 
                                                       0.97, 0.52))

sales_turtle_forecast$total_sales_Global <- predict(model2, 
                                                    newdata = sales_turtle_forecast)


sales_turtle_forecast

###############################################################################

# 5. Observations and insights
# Your observations and insights here...
## On Model 1 There is a weak positive correlation between NA Sales and 
## EU Sales, with a coefficient of 0.42028 (model1). Although the standard error 
## is low ( 0.27433), the R2 of 38.56% indicated a not very good fit. 

## On Model 2 There is a positive positive correlation between NA Sales and 
## EU Sales with Global Sales. The standard error has low values, the R2 of 
## 96.68% indicated a good fit. By predicting the global sales based on provided 
## values we managed to check that the predicted values are very accurate.


###############################################################################
###############################################################################





# LSE_DA301_Assignment_PythonTurtleGames
LSE Data Analytics Online Career Accelerator Course 3 Data Analytics using Python Assignment: Predicting future outcomes


Course 3: Advanced Analytics for Organisational Impact (April 2023)

Score: 70/90

Turtle Games - Predicting Future Outcomes:

This third assignment provided the opportunity for deeper regression and classification analysis using linear modelling and natural language processing. 
The analysis was conducted using Python and R. 
The two code files are included here, along with a summary of the analysis, insights and recommendations.

Context

Turtle Games (a fictitious company) sell their own and others’ video games, books, board games, and toys. Data provided comprise global, North American and European sales (unknown time frame) for 200 video games and a sample of 2000 customer reviews for 175 products (with demographic information). 

The review and sales analyses identify how customers accumulate loyalty points, how they should be grouped, how their reviews can be used to inform marketing, the impact each product has on sales, and the relationship between regional sales.

The unique product ID is then used to link review analysis with sales analysis findings to predict which products customers will/will not purchase, based on sales and sentiment scores. 

These powerful insights, derived from sophisticated regression and classification analyses will empower Turtle Games to improve their overall sales performance.

Analytical approach

The focus of this analysis is prediction. My approach asks pertinent questions of clean, tidy data, that provide statistically rigorous, meaningful insights to improve sales performance.

1. Data wrangling

Data were imported, cleaned and explored in Python and R using key functions to view tables, check data types, identify duplicates and nulls and remove/change if necessary. Short, descriptive, sequential names and commenting keep the code clear. Exploratory visualisation is used extensively.

2. Rigorous analysis

Single and multiple linear regression was used to predict loyalty (from pay and spend), and global sales (from North American and European sales). Models were tested iteratively, checking the conditions of linearity, and independence (VIF), normality (Shapiro-Wilk, Kolmogorov-Smirnov and qq plots)  and equal variance (Bruesch-Pagan) of residuals. Natural log transformation of the response variable (appropriate for unequal variance) was tested but not found to improve either model (Lesson 9: Data Transformations | STAT 501, n.d.). High R-squared and low MAPE values indicated model robustness and accuracy, but heteroscedasticity was an issue.

K-means, elbow and silhouette analyses identified five clear clusters of customers using pay and spend. Several models were compared, but k=5 minimised the sum of the squared distances between the data points and their assigned cluster mean (Sharma, 2019).

Sentiment analysis using TextBlob and Vader confirms most reviews are positive. Vader was used in further analyses because it accommodates five additional heuristics, including punctuation and capitalisation (TextBlob Vs. VADER for Sentiment Analysis Using Python | by Amy @GrabNGoInfo, n.d.). Both techniques mistakenly score positive comments like ‘Five Stars’ (used 378 times) as neutral.

3. Extension

The sequence of assignment tasks is adhered to, but I have gone well beyond these tasks by linking the cluster analysis, sentiment scoring, and sales data. This allowed identification of:

Most positively and negatively reviewed products by cluster and product
Sentiment scores by age, gender, pay and loyalty
Sentiment scores of best and worst selling products
Sales values of most positively and negatively reviewed products

These insights predict which products Turtle Games should promote or discontinue, to improve overall sales performance.

My coding toolkit has expanded beyond the course content through substantial use of stackoverflow and python/R documentation, enabling in-depth analysis.

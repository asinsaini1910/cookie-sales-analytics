--Sales & Revenue Analytics
  Q1--Total sales by product, region, or store
SELECT 
product,
region,
store,
SUM(Total_sale) AS Total_Sales
FROM cookie_sales
GROUP BY product,region,store
ORDER BY  Total_Sales DESC;

Q2)
--Daily/weekly/monthly revenue trends
--Monthly Revenue
SELECT
SUM(Total_sale) AS Monthly_Revenue,
FORMAT([Date],'yyyy-mm') AS Month
FROM cookie_sales
GROUP BY FORMAT([Date],'yyyy-mm')
ORDER BY Month;

--WEEKLY REVENUE
SELECT
DATEPART(year,Date) AS Year,
DATEPART(WEEK,Date) AS Week,
SUM(Total_sale) AS Weekly_Revenue
FROM cookie_sales
GROUP BY DATEPART(year,Date),
DATEPART(WEEK,Date)
ORDER BY year;

--Daily Revenue
SELECT
Date AS Day,
SUM(Total_sale) AS Daily_Revenue
FROM cookie_sales
GROUP BY Date
ORDER BY Daily_Revenue;

Q3)--Customer Behavior
--Average spend per age group or gender
SELECT 
Customer_Age_Group,
AVG(Total_sale) AS Avg_Spend
FROM cookie_sales
GROUP BY Customer_Age_Group
ORDER BY Avg_Spend;

--Average spend per gender
SELECT 
Customer_Gender,
AVG(Total_sale) AS Avg_Spend
FROM cookie_sales
GROUP BY Customer_Gender
ORDER BY Avg_Spend;

Q4) -Repeat customer patterns (via Customer_ID)

  SELECT
  Customer_ID,
  COUNT(*) AS Total_Orders,
  SUM(Total_Sale) AS Total_Revenue
FROM
  cookie_sales
GROUP BY
  Customer_ID
HAVING
  COUNT(*) > 1
ORDER BY
  Total_Orders DESC;

Q5)--Inventory & Stock
--least sold products
SELECT
product,
SUM(Quantity) AS Least_Qty_Sold
FROM cookie_sales
GROUP BY  product
ORDER BY Least_Qty_Sold;

--Most sold products
SELECT
product,
SUM(Quantity) AS Most_Qty_Sold
FROM cookie_sales
GROUP BY  product
ORDER BY Most_Qty_Sold DESC;

Q6)
--Estimate stock depletion rates 
sales quantity over time
SELECT
product,
COUNT(DISTINCT Date) AS Days_Sold,
SUM(Quantity) AS Total_Qty_Sold,
SUM(Quantity)/COUNT(DISTINCT Date) AS Avg_Daily_Depletion
FROM  cookie_sales
GROUP BY  product
ORDER BY Avg_Daily_Depletion DESC

Q7)--Customer Insights
--Which demographic buys what?
SELECT
  Customer_Age_Group,
  Customer_Gender,
  Product,
  SUM(Quantity) AS Total_Quantity_Sold
FROM
  cookie_sales
GROUP BY
  Customer_Age_Group,
  Customer_Gender,
  Product
ORDER BY
  Customer_Age_Group, Customer_Gender, Total_Quantity_Sold DESC;

Q8)--Marketing impact by customer type

  SELECT
  Marketing_Channel,
  COUNT(*) AS Total_Orders,
  SUM(Total_Sale) AS Total_Revenue
  FROM
  cookie_sales
    cookie_sales
GROUP BY Marketing_Channel;

Q9)
--Region & Store Performance
--Top-performing stores/regions
SELECT TOP 5
  Store,
  Region,
  SUM(Total_Sale) AS Total_Revenue
FROM
  cookie_sales
GROUP BY
  Store,Region
ORDER BY
  Total_Revenue DESC;

Q10)
--Revenue per store over time
SELECT
  Store,
   DATE,
  SUM(Total_Sale) AS Daily_Revenue
FROM
  cookie_sales
GROUP BY
  Store,  DATE
ORDER BY
  Daily_Revenue;

Q11)
--Marketing Channel Impact

--Sales influenced by each channel
SELECT
  Marketing_Channel,
  COUNT(*) AS Total_Orders,
  SUM(Total_Sale) AS Total_Revenue,
  AVG(Total_Sale) AS Avg_Order_Value
FROM
  cookie_sales
GROUP BY
  Marketing_Channel
ORDER BY
  Total_Revenue DESC;

Q12)
--Conversion analysis
  SELECT
  Marketing_Channel,
  COUNT(DISTINCT CASE WHEN Campaign_Exposed = 'Yes' THEN Customer_ID END) AS Total_Exposed,
  COUNT(DISTINCT CASE WHEN Campaign_Exposed = 'Yes' AND Total_Sale > 0 THEN Customer_ID END) AS Conversions,
  CAST(COUNT(DISTINCT CASE WHEN Campaign_Exposed = 'Yes' AND Total_Sale > 0 THEN Customer_ID END) * 100.0 /
       NULLIF(COUNT(DISTINCT CASE WHEN Campaign_Exposed = 'Yes' THEN Customer_ID END), 0) AS DECIMAL(5,2)) AS Conversion_Rate_Percent
FROM
  cookie_sales
GROUP BY
  Marketing_Channel
ORDER BY
  Conversion_Rate_Percent DESC;

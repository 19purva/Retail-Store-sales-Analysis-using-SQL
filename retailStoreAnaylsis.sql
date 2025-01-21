-- create Database 
CREATE DATABASE RetailStoreSales;
USE RetailStoreSales;

-- upload retail-store-sales table
-- Retrieve all records from the dataset.
select *from retail_store_sales;

-- changing columns name 
ALTER TABLE retail_store_sales
CHANGE `Price Per Unit` Price_Per_Unit DECIMAL(10, 2);

ALTER TABLE retail_store_sales
CHANGE `Total Spent` Total_Spent DECIMAL(10, 2);

ALTER TABLE retail_store_sales
CHANGE `Transaction ID` Transaction_ID varchar(40);

ALTER TABLE retail_store_sales
CHANGE `Customer ID` Customer_ID varchar(40);

ALTER TABLE retail_store_sales
CHANGE `Payment Method` Payment_Method varchar(40);

ALTER TABLE retail_store_sales
CHANGE `Transaction Date` Transaction_Date varchar(40);

ALTER TABLE retail_store_sales
CHANGE `Discount Applied` Discount_Applied varchar(40);

-- To delete rows where the Item, Price Per Unit, Quantity, and Total Spent columns are missing (i.e., NULL or None), and the Discount Applied column is also NULL
SELECT *  
FROM retail_store_sales 
WHERE (Item IS NULL OR Item = ' ') 
  AND (Price_Per_Unit IS NULL OR Price_Per_Unit = ' ') 
  AND (Quantity IS NULL OR Quantity = ' ') 
  AND (Total_Spent IS NULL OR Total_Spent = ' ') 
  AND Discount_Applied IS NULL or Discount_Applied=' '
LIMIT 0, 1000;

 -- Count the total number of transactions.
select count(*) as total_transactions
from retail_store_sales;

-- Find all transactions for a specific customer.
SELECT * 
FROM retail_store_sales 
WHERE Customer_ID = 'CUST_01';

-- List distinct payment methods.
select distinct Payment_Method
from retail_store_sales; 

 -- calculate the total revenue generated
 select sum(Total_Spent) as Total_Revenue
 from retail_store_sales;

 -- Find transactions where item details are missing. 
 select * from retail_store_sales
 where Discount_Applied is null or Discount_Applied = ' ';
 

-- identify the most purchased item category
select category , count(*) as Transaction_Count
from retail_Store_sales
group by category
order by Transaction_Count Desc
limit 5;

-- Filter transactions with invalid or missing payment methods.
select * from retail_store_sales 
where Payment_Method is null or Payment_Method = 'None' or Payment_Method not in ('Cash','Credit Card');

-- Detect and correct transaction with mismatched Total spent 
select Transaction_ID, Quantity , Price_Per_Unit , Total_Spent
from retail_store_sales
where Total_Spent <> Quantity * Price_Per_Unit;

-- calculate the average reveenue per transaction by location
select Location, AVG(Total_Spent) as Avg_Revenue
from retail_store_sales
group by Location; 

-- find the top 5 customers with the highest total spending
select Customer_ID, sum(Total_Spent) as Total_Spent
from retail_store_sales
group by Customer_ID
order by Total_Spent DESC
limit 5;

-- Generate the summary of sales by category and month
select Category ,
        date_format(Transaction_Date,'%Y-%m') as Month,
        sum(Total_Spent) as Total_Sales,
        Count(*) as Transaction_Count
from retail_store_sales
group by Category, Month
order by Month, Total_Sales DESC;

-- Rank items by total sales within their category
SELECT Category, 
       Item, 
       SUM(Total_Spent) AS Total_Revenue, 
       RANK() OVER (PARTITION BY Category ORDER BY SUM(Total_Spent) DESC) AS Revenue_Rank 
FROM retail_store_sales 
GROUP BY Category, Item 
ORDER BY Category, Revenue_Rank;

-- Determine discount impact on Revenue
 select Discount_Applied,
 AVG(Total_Spent) as AVG_Revenue
 from retail_store_sales
 group by Discount_Applied;

-- Find the Top 3 Customers by Total Spending
Select Customer_ID, 
sum(Total_Spent) as TotalSpending
From retail_store_sales
group by Customer_ID
order by TotalSpending Desc
limit 3;

-- Find the Most Popular Item in Each Category
WITH ItemCounts AS (
    SELECT Category, 
           Item, 
           COUNT(*) AS PurchaseCount
    FROM retail_store_sales
    GROUP BY Category, Item
)
SELECT Category, Item, PurchaseCount
FROM ItemCounts
WHERE (Category, PurchaseCount) IN (
    SELECT Category, MAX(PurchaseCount)
    FROM ItemCounts
    GROUP BY Category
);

-- calculate Monthly Revenue
select date_format(Transaction_Date, '%Y-%m') as Month,
       SUM(Total_Spent) as TotalRevenue
from retail_store_sales
group by Date_Format(Transaction_Date, '%Y-%m')
Order by Month;

 -- Identify Customers with Multiple Payment Methods
 select Customer_ID,
     group_concat(Distinct Payment_Method) as PaymentMethods,
     Count(Distinct Payment_Method) as MethodCount
From retail_store_sales
Group by Customer_ID
Having MethodCount > 1;

-- Find Customers Who Haven’t Purchased in the Last 6 Months
 SELECT Customer_ID
FROM retail_store_sales
GROUP BY Customer_ID
HAVING MAX(Transaction_Date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Find Categories with Low Average Revenue Per Transaction
 SELECT Category, 
       AVG(Total_Spent) AS AvgRevenue
FROM retail_store_sales
GROUP BY Category
HAVING AvgRevenue < 200;

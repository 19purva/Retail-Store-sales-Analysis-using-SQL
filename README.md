 # Retail Store Sales Analysis

## Overview

The Retail Store Sales Analysis project is focused on cleaning, analyzing, and deriving insights from a synthetic retail dataset. This dataset simulates real-world sales data with intentional inconsistencies and missing values to provide hands-on experience with data preprocessing, exploratory data analysis (EDA), and SQL-based data manipulation. The dataset includes 11,362 rows and represents sales transactions across multiple product categories in a retail store.

## Objective

The primary objectives of this project are:  
1.To clean and preprocess the dataset by addressing missing, inconsistent, and erroneous data.  
2.To perform advanced SQL queries for data analysis and reporting.  
3.To derive actionable insights about customer behavior, product performance, and sales trends.  
4.To identify and resolve issues in the dataset for enhanced data integrity and usability.

## Dataset

<strong>File Name: </strong> retail_store_sales.csv

<strong>The dataset contains 11,362 rows and 11 columns, representing sales transactions. The following attributes are included:</strong>

<strong>Transaction_ID:</strong> A unique identifier for each transaction (e.g., TXN_1234567).  
<strong>Customer_ID:</strong> A unique identifier for each customer (e.g., CUST_01).  
<strong>Category:</strong> The product category (e.g., Food, Furniture).

Item: The name of the purchased item. May contain missing values.

Price_Per_Unit: The price of a single unit. May contain missing or NULL values.

Quantity: The number of units purchased. May contain missing or NULL values.

Total_Spent: The total amount spent, calculated as Price_Per_Unit * Quantity. May contain inconsistencies.

Payment_Method: The payment method used (e.g., Cash, Credit Card). May contain invalid values.

Location: The transaction location (e.g., In-store, Online). May contain missing values.

Transaction_Date: The date of the transaction. Always valid.

Discount_Applied: Indicates if a discount was applied (True, False, or NULL).

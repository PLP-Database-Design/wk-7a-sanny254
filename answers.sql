-- Solution for Question 1: Convert to 1NF by splitting multi-valued Products column
WITH split_products AS (
  SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
  FROM ProductDetail
  CROSS APPLY STRING_SPLIT(Products, ',')
)
SELECT * FROM split_products
ORDER BY OrderID, Product;

-- Solution for Question 2: Convert to 2NF by removing partial dependencies

-- Create Orders table (contains OrderID and CustomerName)
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderItems table (contains OrderID, Product, Quantity)
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- The original table can now be represented through a join:
SELECT o.OrderID, o.CustomerName, oi.Product, oi.Quantity
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
ORDER BY o.OrderID, oi.Product;

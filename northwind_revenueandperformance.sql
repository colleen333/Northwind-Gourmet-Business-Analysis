SELECT * FROM northwind.revenue;
#highest performing employees
WITH topsales AS (
    SELECT 
        o.EmployeeID , 
        SUM(quantity * UnitPrice)  AS sales
FROM orders o
LEFT JOIN northwind.`order details` od
USING (OrderID)
LEFT JOIN customers c
USING (CustomerID)
WHERE
YEAR(OrderDate) = 1997 AND (MONTH(OrderDate) BETWEEN 10 AND 12 ) AND o.ShippedDate IS NOT NULL 
GROUP BY EmployeeID
ORDER BY sales DESC
)
SELECT 
EmployeeID, 
CONCAT(FirstName,' ', LastName) AS EmployeeName,
sales,
DENSE_RANK() OVER (ORDER BY sales DESC) AS EmployeePerformanceRank
FROM employees
JOIN topsales USING (EmployeeID)
LIMIT 3;

#top performing catagories

WITH topcat AS (
SELECT c.CategoryName, SUM(od.UnitPrice*od.Quantity) AS TotalSales
FROM orders o
LEFT JOIN northwind.`order details` od
USING (OrderID)
LEFT JOIN products p
USING (ProductID)
LEFT JOIN categories c
USING (CategoryID)
GROUP BY c.CategoryName
ORDER BY TotalSales DESC)
SELECT 
CategoryName, 
TotalSales,
DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS CategoryRank
FROM topcat #Categories c
LIMIT 3



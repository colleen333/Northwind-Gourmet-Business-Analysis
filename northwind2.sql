#find count of successful and unsuccessful orders in MYSQL (by creating CTE).

SELECT OrderID,OrderDate,RequiredDate,ShippedDate,
      CASE WHEN ShippedDate IS NULL THEN 'Unsuccessful' ELSE 'Successful' END AS ShippedStatus
FROM Orders

with abc as (SELECT OrderID,OrderDate,RequiredDate,ShippedDate,
      CASE WHEN ShippedDate IS NULL THEN 'Unsuccessful' ELSE 'Successful' END AS ShippedStatus
FROM Orders)
select count(OrderId),ShippedStatus
from abc
group by ShippedStatus

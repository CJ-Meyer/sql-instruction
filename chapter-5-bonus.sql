-- Chapter 5 Bonus Questions
-- EX.1
SELECT COUNT(*) OrderCount, SUM(TaxAmount) TotalTaxAmount
FROM Orders;

-- EX.2
SELECT CategoryName, COUNT(*) CategoryCount, MAX(ListPrice) MaxPrice
FROM Categories C JOIN Products P On C.CategoryID = P.CategoryID
GROUP BY CategoryName
ORDER BY MaxPrice DESC;

-- EX.3
SELECT EmailAddress, (ItemPrice * Quantity) TotalPrice, (DiscountAmount * Quantity)TotalDiscount
FROM Customers C JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
ORDER BY TotalPrice DESC;

-- EX.4
SELECT EmailAddress, COUNT(*) OrderCount, SUM((ItemPrice - DiscountAmount)*Quantity) TotalAmount
FROM Customers C JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY EmailAddress
HAVING COUNT(O.OrderID)>1
ORDER BY TotalAmount DESC;

-- EX.5
SELECT EmailAddress, COUNT(*) OrderCount, SUM((ItemPrice - DiscountAmount)*Quantity) TotalAmount
FROM Customers C JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE ItemPrice>400
GROUP BY EmailAddress
HAVING COUNT(ItemPrice)>1
ORDER BY TotalAmount DESC;

-- EX.6
SELECT ProductName, SUM((ItemPrice-DiscountAmount)*Quantity) TotalAmount
FROM Products P JOIN OrderItems O ON O.ProductID = P.ProductID
GROUP BY ROLLUP(ProductName)

-- Total amount of each product ordered??
SELECT ProductName, Quantity
FROM OrderItems O JOIN Products P ON O.ProductID = P.ProductID
GROUP BY  P.ProductName, O.Quantity;


-- EX.7



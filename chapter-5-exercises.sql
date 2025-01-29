-- Chapter 5, Functions: AVG, SUM, MIN, MAX, COUNT, Clauses: GROUP BY, HAVING
-- P.137
SELECT COUNT(*) NumOfInvoices, SUM(InvoiceTotal - PaymentTotal - CreditTotal) TotalDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

-- how many total invoices, avg inv total, total inv amount? for invoices after 7/1/22?

SELECT 'after 7/1/2022' as SelDate,
	COUNT(*) NumOfInv,
	AVG(InvoiceTotal) AVGInvoiceAmount,
	SUM(InvoiceTotal) TotalInvoiceAmount
FROM Invoices
WHERE InvoiceDate > '2022-07-01';

--P.149 MIN and MAX
SELECT 'after 7/1/2022' as SelDate,
	COUNT(*) NumOfInv,
	MAX(InvoiceTotal) HighestInvoiceTotal,
	MIN(InvoiceTotal) LowestInvoiceTotal
FROM Invoices
WHERE InvoiceDate > '2022-07-01';
--P. 139 First or last vendor, alphabetically?
SELECT MIN(VendorName)  FirstVendor,
MAX(VendorName) LastVendor,
COUNT(VendorName) NumOfVendors
FROM Vendors;
-- P.139 using DISTINCT in summary queries - distinct # of vendors
SELECT COUNT(DISTINCT VendorID) NumOfVendors,
	COUNT(*) NumOfInv,
	AVG(InvoiceTotal) AVGInvoiceAmount,
	SUM(InvoiceTotal) TotalInvoiceAmount
FROM Invoices;

-- P.141 Average Inv Amount by vendor - avg over $2000
SELECT VendorID, AVG(InvoiceTotal) 'AVG Invoice Total'
FROM Invoices
GROUP BY VendorID
HAVING AVG(InvoiceTotal) > 2000
ORDER BY [AVG Invoice Total] DESC ;

-- P.143 # of invoices by vendor
SELECT VendorID, COUNT(*) INvoiceQty
FROM Invoices
GROUP BY VendorID;

-- P.143 Vendors by state and city, inv qty and inv avg
SELECT VendorState, VendorCity, COUNT(*) INvQty, AVG(InvoiceTotal) InvAVG
FROM Invoices I
JOIN Vendors V ON I.VendorID = V.VendorID
GROUP BY VendorState, VendorCity
ORDER BY VendorState, VendorCity;

-- Limit the results using having clause
SELECT VendorState, VendorCity, COUNT(*) INvQty, AVG(InvoiceTotal) InvAVG
FROM Invoices I
JOIN Vendors V ON I.VendorID = V.VendorID
GROUP BY VendorState, VendorCity
HAVING COUNT(*) >=2
ORDER BY Vendorstate, VendorCity;

-- P.145 Search condition in having clause
SELECT VendorName, COUNT(*) InvQty,
AVG(InvoiceTotal) InvAVG
From Vendors V
JOIN Invoices I on V.VendorID = I.VendorID
GROUP BY VendorName
HAVING AVG (InvoiceTotal) > 500
ORDER BY InvQty DESC;

-- P.145 Search condition in the WHERE clause
SELECT VendorName, COUNT(*) InvQty,
AVG(InvoiceTotal) InvAVG
From Vendors V
JOIN Invoices I on V.VendorID = I.VendorID
WHERE InvoiceTotal > 500
GROUP BY VendorName
ORDER BY InvQty DESC;

-- P.149 Invoices by vendor, grouped to get inv count and inv total, with summary row
SELECT VendorID, COUNT(*) InvCount, SUM(InvoiceTotal) InvSum
FROM Invoices
GROUP BY ROLLUP(VendorID);

-- ROLLUP multiple columns: Vendors from IA NJ, ROLLUP by Vendor State and City
SELECT VendorState, VendorCity, COUNT(*) QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY ROLLUP(VendorState, VendorCity)
ORDER BY VendorState DESC, VendorCity DESC;

-- P.151 CUBE Summary rows for every combo of groups
SELECT VendorState, VendorCity, COUNT(*) QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY CUBE(VendorState, VendorCity)
ORDER BY VendorState DESC, VendorCity DESC;

--P.153 Grouping Sets 
SELECT VendorState, VendorCity, COUNT(*) QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY GROUPING SETS(VendorState, VendorCity)
ORDER BY VendorState DESC, VendorCity DESC;

-- Composite Grouping
SELECT VendorState, VendorCity, VendorZipCode, COUNT(*) QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY GROUPING SETS((VendorState, VendorCity), VendorZipCode, ())
ORDER BY VendorState DESC, VendorCity DESC;

-- P.155 
SELECT Invoicenumber, InvoiceDate, Invoicetotal,
SUM(InvoiceTotal) OVER (PARTITION BY INVOICEDATE) DateTotal,
COUNT(InvoiceTotal) OVER (PARTITION BY INVOICEDATE) DateCount,
AVG(InvoiceTotal) OVER (PARTITION BY INVOICEDATE) DateAVG
FROM Invoices;

--Chapter 5 Exercises
-- EX.1
SELECT VendorID, SUM(PaymentTotal) PaymentSum
FROM Invoices
GROUP BY VendorID;

-- EX.2
SELECT TOP 10
VendorName, SUM(PaymentTotal) PaymentSum
FROM Vendors V JOIN Invoices I ON V.VendorID = I.VendorID
GROUP BY VendorName
ORDER BY PaymentSum DESC;

-- EX.3
SELECT VendorName, COUNT(*) InvoiceCount, SUM(InvoiceTotal) InvoiceSum
FROM Invoices I JOIN Vendors V ON I.VendorID = V.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount ;

-- EX.4 
SELECT AccountDescription, COUNT(*) LineItemCount, SUM(InvoiceLineItemAmount) LineItemSum
FROM GLAccounts G JOIN InvoiceLineItems I ON G.AccountNo = I.AccountNo
GROUP BY AccountDescription
HAVING COUNT(*)>1
ORDER BY LineItemCount;

-- EX.5
SELECT AccountDescription,
COUNT(*) LineItemCount,
SUM(InvoiceLineItemAmount) LineItemSum,
InvoiceDate
FROM GLAccounts G JOIN InvoiceLineItems I ON G.AccountNo = I.AccountNo
JOIN Invoices Inv ON Inv.InvoiceID = I.InvoiceID
WHERE Inv.InvoiceDate >='10/1/2022' AND Inv.InvoiceDate<'12/31/2022'
GROUP BY AccountDescription, InvoiceDate
ORDER BY LineItemCount;

-- EX.6
SELECT AccountNo, SUM(InvoiceLineItemAmount) InvLineItemSum
FROM InvoiceLineItems
GROUP BY ROLLUP(AccountNo)

--EX.7
SELECT VendorName,
AccountDescription,
COUNT(*) LineItemCount,
SUM(InvoiceLineItemAmount) LineItemSum
FROM Vendors V JOIN Invoices I ON V.VendorID = I.VendorID
JOIN InvoiceLineItems Inv ON Inv.InvoiceID = I.InvoiceID
JOIN GLAccounts G On G.AccountNo = Inv.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName, AccountDescription;

-- EX.8
SELECT COUNT(DISTINCT Inv.AccountNo) NumOfAccounts, V.VendorName
FROM Vendors V JOIN Invoices I On V.VendorID = I.VendorID
JOIN InvoiceLineItems Inv ON I.InvoiceID = Inv.InvoiceID
GROUP BY DefaultAccountNo, VendorName
ORDER BY V.VendorName;

-- EX.9
SELECT VendorID, InvoiceDate, InvoiceTotal,
    SUM(InvoiceTotal) OVER (ORDER BY VendorID) AS VendorTotal,
    COUNT(InvoiceTotal) OVER (ORDER BY VendorID) AS VendorCount,
    AVG(InvoiceTotal) OVER (ORDER BY VendorID) AS VendorAvg
FROM Invoices

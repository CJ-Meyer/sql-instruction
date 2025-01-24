-- Chapter 4 demos 

-- vendors and invoices table 
SELECT *
FROM Vendors;

SELECT *
FROM Invoices
ORDER BY VendorID

-- EX. Questions
-- which vendors have we invoiced and or done business with?
-- which havent?
-- which vendors have spent the most money with us?

-- p. 103 - two table join
SELECT InvoiceNumber, VendorName
FROM Invoices
JOIN Vendors on vendors.VendorID = invoices.VendorID;
-- All vendors who have been invoiced

--p. 105 - aliases in joins w/ AS keyword
SELECT InvoiceNumber, VendorName
FROM Invoices AS I
JOIN Vendors AS V on V.VendorID = I.VendorID;

--simplest form
SELECT InvoiceNumber, VendorName
FROM Invoices  I
JOIN Vendors V on V.VendorID = I.VendorID;

-- add in a calculated column, where, order by
SELECT InvoiceNumber, VendorName, InvoiceDueDate, (InvoiceTotal - PaymentTotal - CreditTotal) BalanceDue
FROM Invoices  I
JOIN Vendors V on V.VendorID = I.VendorID
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0
ORDER BY InvoiceDueDate DESC;

-- p.107 fully qualified object names
SELECT *
FROM AP.dbo.Vendors;

-- p. 109 joining on multiple things 
-- Invoices to InvoiceLineItems AND InvoiceTotal to InvoiceLineItemAmount
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,InvoiceLineItemAmount
FROM Invoices I
JOIN InvoiceLineItems LI ON I.InvoiceID = LI.InvoiceID
AND I.InvoiceTotal > LI.InvoiceLineItemAmount
ORDER BY InvoiceNumber;

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,InvoiceLineItemAmount
FROM Invoices I
JOIN InvoiceLineItems LI ON I.InvoiceID = LI.InvoiceID
WHERE I.InvoiceTotal > LI.InvoiceLineItemAmount
ORDER BY InvoiceNumber;

-- p. 111 Vendors Table - self join
-- Vendors from cities in common with other vendors
SELECT DISTINCT V1.VendorName, V1.VendorCity, V1.VendorState
FROM VENDORS V1
JOIN Vendors V2 ON V1.VendorCity = V2.VendorCity
					AND V1.VendorState = V2.VendorState
					AND V1.VendorID <> V2.VendorID
ORDER BY V1.VendorState, V1.VendorCity;

-- p. 115 implicit join - vendors and invoices
SELECT InvoiceNumber, VendorName
FROM Invoices I, Vendors V
WHERE V.VendorID = I.VendorID

-- which vendors have we invoiced and or done business with?
-- which Vendors havent we invoiced or done business with?
-- which vendors have spent the most money with us?

-- vendors and invoices - left outter join

SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Vendors V
LEFT JOIN Invoices I ON V.VendorID = I.VendorID
ORDER BY VendorName;

-- same thing as right outter join
SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Invoices I
RIGHT JOIN Vendors V ON V.VendorID = I.VendorID
ORDER BY VendorName;

-- vendors and invoices - left outter join where
SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Vendors V
LEFT JOIN Invoices I ON V.VendorID = I.VendorID
WHERE InvoiceNumber IS NULL
ORDER BY VendorName;
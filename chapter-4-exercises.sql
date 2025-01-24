-- EX. 1
SELECT *
FROM Vendors V
JOIN Invoices I on V.VendorID = I.VendorID

-- EX. 2
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal-(PaymentTotal+CreditTotal) Balance 
FROM Vendors V
JOIN Invoices I on V.VendorID = I.VendorID

--EX. 3
SELECT VendorName, DefaultAccountNo, AccountDescription
From Vendors V
Join GLAccounts G on v.DefaultAccountNo = G.AccountNo
ORDER BY AccountDescription, VendorName

-- EX.4 
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal-(PaymentTotal+CreditTotal) Balance 
FROM Vendors V, Invoices I 
WHERE V.VendorID = I.VendorID

--EX. 5
SELECT VendorName as Vendor, InvoiceDate as date, InvoiceNumber as number,InvoiceSequence AS [#],InvoiceLineItemAmount AS LineItem
FROM Vendors V
JOIN Invoices I on V.VendorID = I.VendorID
JOIN InvoiceLineItems L on L.InvoiceID = I.InvoiceID
ORDER BY Vendor, Date, Number, #;

--EX. 6
SELECT DISTINCT V1.VendorID, V1.VendorName, (V1.VendorContactFName + ' ' + V1.VendorContactLName) as Name
FROM Vendors v1 
   JOIN Vendors v2
      ON (v1.VendorID <> v2.VendorID) AND
      (v1.VendorContactFName = v2.VendorContactFName)
ORDER BY Name;

-- EX. 7
SELECT *
FROM GLAccounts G
LEFT JOIN InvoiceLineItems Li on G.AccountNo = li.AccountNo
WHERE LI.AccountNo IS NULL
ORDER BY g.AccountNo;

-- EX. 8

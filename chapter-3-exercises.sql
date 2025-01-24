-- Ex. 1
SELECT VendorContactFName, VendorContactLName, VendorName
	FROM Vendors
Order by VendorContactLName, VendorContactFName;

-- Ex. 2
SELECT InvoiceNumber as Number, InvoiceTotal as Total, (PaymentTotal + CreditTotal) as Credits, InvoiceTotal - (PaymentTotal + CreditTotal) as Balance
 FROM Invoices;

 -- Ex. 3
 SELECT VendorContactLName + ', ' + VendorContactFName as [Full Name]
	FROM Vendors
order by VendorContactLName, VendorContactFName;

-- Ex. 4
SELECT InvoiceTotal, (InvoiceTotal*.10) as [10%], (InvoiceTotal*1.1) as [Plus 10%]
	FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 100
ORDER by Invoicetotal DESC;

-- Ex. 5
SELECT InvoiceNumber as Number, InvoiceTotal as Total, (PaymentTotal + CreditTotal) as Credits, InvoiceTotal - (PaymentTotal + CreditTotal) as Balance
 FROM Invoices
 WHERE InvoiceTotal between 500 and 10000;

 --Ex. 6
SELECT VendorContactLName + ', ' + VendorContactFName as [Full Name]
	FROM Vendors
WHERE VendorContactLName LIKE '[A-C,E]%'
order by VendorContactLName, VendorContactFName;

--Ex. 7
SELECT *
	FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND 
	PaymentDate IS NULL) or 
	((InvoiceTotal - PaymentTotal - CreditTotal >= 0) AND 
	PaymentDate IS NOT NULL);
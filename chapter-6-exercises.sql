-- Chapter 6
-- P.161 SELECT Statement in a WHERE clause
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE InvoiceTotal > (SELECT AVG(InvoiceTotal) FROM Invoices)
ORDER BY InvoiceTotal;

-- P.163
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices I 
JOIN Vendors V
ON I.VendorID = v.VendorID
WHERE VendorState = 'CA'
ORDER BY InvoiceDate

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices I 
WHERE VendorID IN 
(SELECT VendorID 
FROM Vendors 
WHERE Vendorstate = 'CA')
ORDER BY InvoiceDate;

--P.165
SELECT VendorID, VendorName, VendorState
FROM Vendors WHERE VendorID NOT IN (SELECT DISTINCT VendorID FROM Invoices);

SELECT V.VendorID, VendorName, VendorState
FROM Vendors V LEFT JOIN Invoices I ON V.VendorID = I.VendorID
WHERE I.VendorID IS NULL;

--P.167
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal - PaymentTotal - CreditTotal as BalanceDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal -CreditTotal > 0
AND InvoiceTotal - PaymentTotal - CreditTotal < 
(SELECT AVG(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - credittotal > 0)
ORDER BY InvoiceTotal DESC;

--P.169
SELECT I.VendorID, VendorName, InvoiceNumber, InvoiceTotal
FROM Invoices I 
JOIN Vendors V 
ON I.VendorID = V.VendorID
WHERE InvoiceTotal > ALL(SELECT InvoiceTotal FROM Invoices Where VendorID = 34)
ORDER BY VendorName

--P.171
SELECT VendorName, InvoiceNumber, InvoiceTotal 
FROM Vendors V JOIN Invoices I 
ON v.VendorID = I.VendorId
WHERE invoiceTotal < ANY 
(SELECT InvoiceTotal FROM Invoices
WHERE VendorID = 115);

--P.173
SELECT VendorID, InvoiceNumber, InvoiceTotal
FROM Invoices i
WHERE InvoiceTotal >
(SELECT AVG(InvoiceTotal)
FROM Invoices i_sub
WHERE i_sub.VendorID = i.VendorID)
ORDER BY VendorID, InvoiceTotal

--P.175
SELECT VendorID, VendorName, VendorState 
FROM Vendors V 
WHERE NOT EXISTS 
(SELECT *
FROM Invoices I 
WHERE I.VendorID = V.VendorID);

-- Chapter 6
--EX.1
SELECT VendorName
FROM Vendors V
WHERE VendorID IN 
(SELECT VendorID FROM Invoices)
ORDER BY VendorName;

-- EX.2 Which invoices have PaymentTotal Thats Greater than the average PaymentTotal For all paid invoices?
-- Return the InvoiceNumber and INvoiceTotal for each invoice.
SELECT PaymentTotal, InvoiceNumber, InvoiceTotal
FROM Invoices 
WHERE PaymentTotal > 
(SELECT AVG(PaymentTotal) AVGTotal 
FROM Invoices 
WHERE PaymentTotal<>0);

-- EX.3 Which Invoices have a paymentTotal thats greater than the median PaymentTotal for all paid invoices?
SELECT InvoiceNumber, InvoiceTotal
FROM Invoices 
WHERE PaymentTotal > ALL
(SELECT TOP 50 PERCENT PaymentTotal 
FROM Invoices
WHERE PaymentTotal <> 0 
ORDER BY PaymentTotal);

--EX.4
SELECT AccountNo, AccountDescription
FROM GLAccounts G
WHERE NOT EXISTS
(SELECT * FROM InvoiceLineItems
WHERE InvoiceLineItems.AccountNo = G.AccountNo)
ORDER BY AccountNo;

--EX.5 HAD TROUBLE ON THIS ONE
SELECT VendorName, I.InvoiceID, InvoiceSequence, InvoiceLineItemAmount
FROM Vendors V JOIN Invoices I ON V.VendorID = I.VendorID
JOIN InvoiceLineItems IL ON IL.InvoiceID = I.InvoiceID
WHERE I.InvoiceID IN 
(SELECT InvoiceID FROM InvoiceLineItems WHERE InvoiceSequence>1)
ORDER BY VendorName,I.InvoiceID, InvoiceSequence;
--EX.6
--SELECT statement that returns a value representing the sum of the largest unpaid invoices per vendor.
--Use a derived table that returns MAX(InvoiceTotal) GROUPED BY VendorID, FIltering for Invoices with a balance due
SELECT SUM(LI) SumMax
FROM (SELECT VendorID, MAX(InvoiceTotal) LI
FROM Invoices WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
GROUP BY VendorID) MaxInvoice;

--EX.7 With Sean
-- Asking for Unique State and city
-- Understanding what the exercise is asking for 
SELECT V1.VendorID, V1.VendorName, V1.VendorState, V1.VendorCity
FROM Vendors V1
WHERE V1.VendorID NOT IN (SELECT DISTINCT (V2.VendorID) FROM Vendors V2
			JOIN Vendors V3 ON V3.VendorState = V2.VendorState
			AND V3.VendorCity = V2.VendorCity
			AND V3.VendorID <> V2.VendorID
-- subquery listing all vendorIDS from duplicate city vendors
)
ORDER BY v1.VendorState, v1.VendorCity
-- excluded-68,93,96, 51,52, 20,29,64,47-included
SELECT DISTINCT (V2.VendorID) FROM Vendors V2
JOIN Vendors V3 ON V3.VendorState = V2.VendorState
AND V3.VendorCity = V2.VendorCity
AND V3.VendorID <> V2.VendorID
ORDER BY V2.VendorID

--EX.7
SELECT VendorName, VendorCity, VendorState
FROM Vendors V 
WHERE VendorState + VendorCity NOT IN 
(SELECT VendorState + VendorCity 'Vendor Location' FROM Vendors GROUP BY VendorState, VendorCity
HAVING COUNT(*)>1)
ORDER BY VendorState, VendorCity

--EX.8
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Vendors V JOIN Invoices I ON V.VendorID = I.VendorID
WHERE InvoiceDate = (SELECT MIN(InvoiceDate) FROM Invoices i2 WHERE i2.VendorID = I.VendorID)
ORDER BY VendorName;

-- Chapter 6 College questions
-- EX.1
SELECT LastName, FirstName
FROM Instructors I
WHERE I.InstructorID IN 
(SELECT InstructorID FROM Courses C)
ORDER BY LastName, FirstName

-- EX.2 Which inst. has an annual salary thats > than average annual salary for all instructors
SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary >
(SELECT AVG(annualsalary) AVGSalary FROM Instructors WHERE AnnualSalary<>0);

-- EX.3 SELECT that returns first and last name column from instructors 
-- return one row for each instructor who doesnt have any courses (No courseID)
--Sort result by LastName then FirstName
SELECT FirstName, LastName
FROM Instructors I
--JOIN Courses C ON I.InstructorID = C.InstructorID
WHERE Not EXISTS
(SELECT InstructorID FROM Courses C
WHERE C.InstructorID = I.InstructorID)
ORDER BY LastName, Firstname;

--EX.4 SELECT that returns the LastName and FirstName columns from the students table
-- +Count with number of courses each student is taking from StudentsCourses
--Return one row for each student who is taking more than one class, Use subquery W/ IN operator that groups by StudentID
--GROUP and SORT BY LastName, FirstName
SELECT LastName, FirstName
FROM Students
WHERE StudentID IN(
SELECT StudentID
FROM StudentCourses
GROUP BY StudentID
HAVING COUNT(CourseID) > 1)
GROUP BY LastName, FirstName
ORDER BY LastName, FirstName;

--EX.5 SELECT to return LastName, FirstName, AnnualSalary per instructor
--WHERE they have a unique annual salary (GROUP BY annual and count)
--Sort by LastName then FirstName
SELECT  LastName, FirstName, AnnualSalary
FROM Instructors

--MY guitar shop 

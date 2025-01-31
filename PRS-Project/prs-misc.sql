SELECT *
FROM [User] U JOIN Request R ON U.UserID = R.UserID
JOIN LineItem LI ON LI.RequestID = R.RequestID
JOIN [Product] P ON P.ProductID = LI.ProductID
JOIN Vendor V ON V.VendorID = P.VendorID

-- Insert 2 users
SELECT * FROM [User];
INSERT INTO [User](Username, Password, FirstName, LastName, PhoneNumber, Email, Reviewer, Admin) Values 
	('CAP', 'America', 'Steve', 'Rogers', '121-111-1111', 'iluvamerica@gmail.com', 1, 1),
	('Spidey', 'webbed', 'Peter', 'Parker', '111-222-1222', 'spideysense@gmail.com', 0, 0),
	('MFDOOM', 'kookies', 'Victor V.', 'DOOM', '111-222-3334', 'Doomsday@gmail.com', 1, 1),
	('THEBrains', 'smash', 'Bruce', 'Banner', '111-212-3211', 'HulkSmash@gmail.com', 0, 1);

-- Insert 3 Vendors
SELECT * FROM Vendor;
INSERT INTO Vendor(Code, Name, Address, City, State, Zip, PhoneNumber, Email) Values
	('AVNGR', 'Avengers Co.', '1234 Sunset Drive', 'Manhattan', 'NY', '10005', '948-294-3945', 'AvengersOfc@gmail.com'),
	('DOOM', 'Doctor Doom Labs', '1234 Vaudeville Drive', 'Chicago', 'IL', '60018', '321-643-8455', 'DOOMTech@gmail.com'),
	('JSTLG', 'Justice League', '1234 Krillin Ct.', 'Detroit', 'MI', '48201', '543-654-2422', 'JustLeague@gmail.com');
	-- ID'S: 1,2,3,
-- Insert 10 Products
SELECT * FROM Product;
INSERT INTO Product(VendorID, PartNumber, ProductName, Price, Unit, PhotoPath) Values
	(3,'342', 'Fake Kryptonite', '2.99', 'Thing', NULL),
	(1, '654', 'Shield', '299.99', 'Thing', NULL),
	(2, '543', 'DOOM Mask', '5000.01', 'Thing', NULL),
	(1, '111', 'Iron Man Gauntlet', '999.99', 'Thing', NULL),
	(1, '227', 'Mjolnir Replica', '149.99', 'Thing', NULL),
	(2, '781', 'Doom’s Ray Cannon', '4999.00', 'Thing', NULL),
	(2, '999', 'Latverian Armor', '3499.95', 'Thing', NULL),
	(3, '123', 'Batarang Deluxe Set', '79.99', 'Thing', NULL),
	(3, '888', 'Lasso of Truth Replica', '199.95', 'Thing', NULL)
;
-- Insert Request
SELECT * FROM Request
INSERT INTO Request(UserID, RequestNumber, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate, ReasonForRejection) Values
	(2, '22', 'DOOM Mask', 'Looks cool', '2025/2/3', 'pickup', 'New' , '5000.01', GETDATE(), null)
;
-- Insert LineItem
SELECT * FROM LineItem;
INSERT INTO LineItem(RequestID, ProductID, Quantity) VALUES
	(1, 3, 1),
	(2,3,2);
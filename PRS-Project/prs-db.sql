USE MASTER 
GO

DROP DATABASE IF EXISTS PRS

CREATE DATABASE PRS
GO

USE PRS
GO

-- User Table
CREATE Table [User] (
	UserID	INT 	IDENTITY(1,1)	PRIMARY KEY,
	Username	VARCHAR(20)	NOT NULL,
	Password	VARCHAR(10)	NOT NULL,
	FirstName	VARCHAR(20) NOT NULL,
	LastName	VARCHAR(20) NOT NULL,
	PhoneNumber	VARCHAR(12) NOT NULL,
	Email		VARCHAR(75) NOT NULL,
	Reviewer	BIT,
	Admin		BIT
	CONSTRAINT uname UNIQUE (Username)
	);

-- Vendor Table
CREATE Table Vendor (
	VendorID	INT 	IDENTITY(1,1)	PRIMARY KEY,
	Code	VARCHAR(10)	NOT NULL,
	[Name]	VARCHAR(255) NOT NULL,
	[Address]	VARCHAR(255) NOT NULL,
	City	VARCHAR(255) NOT NULL,
	[State]	VARCHAR(2) NOT NULL,
	Zip		VARCHAR(5) NOT NULL,
	PhoneNumber VARCHAR(12) NOT NULL,
	Email	VARCHAR(100) NOT NULL
	CONSTRAINT vcode UNIQUE (Code)
)
-- Product Table
CREATE Table [Product] (
	ProductID	INT 	IDENTITY(1,1)	PRIMARY KEY,
	VendorID	INT		NOT NULL,
	PartNumber	VARCHAR(50) NOT NULL,
	ProductName	VARCHAR(150) NOT NULL,
	Price	DECIMAL(10, 2) NOT NULL,
	Unit	VARCHAR(255),
	PhotoPath	VARCHAR(255),
	CONSTRAINT vendor_part UNIQUE (VendorID, PartNumber),
	CONSTRAINT FK_Product FOREIGN KEY (VendorID) REFERENCES [Vendor](VendorID)
)

-- Request Table 
Create Table Request (
	RequestID INT	IDENTITY(1,1)	PRIMARY KEY,
	UserID INT NOT NULL,
	RequestNumber	VARCHAR(20) NOT NULL,
	Description		VARCHAR(100) NOT NULL,
	Justification	VARCHAR(255) NOT NULL,
	DateNeeded		DATE NOT NULL,
	DeliveryMode	VARCHAR(25) NOT NULL,
	[Status]	VARCHAR(20) default'NEW',
	Total	DECIMAL(10,2) default 0.0,
	SubmittedDate	DATETIME,
	ReasonForRejection	VARCHAR(100)
	CONSTRAINT FK_RequestUser FOREIGN KEY (UserID) REFERENCES [User](UserID)
)

--LineItem Table
Create Table LineItem (
	LineItemID INT	IDENTITY(1,1)	PRIMARY KEY,
	RequestID	INT,
	ProductID INT,
	Quantity INT NOT NULL,
	CONSTRAINT req_pdt UNIQUE (RequestID, ProductID),
	CONSTRAINT FK_LineItemRequest FOREIGN KEY (RequestID) REFERENCES Request(RequestID),
	CONSTRAINT FK_LineItemProduct FOREIGN KEY (ProductID) REFERENCES [Product](ProductID)
)
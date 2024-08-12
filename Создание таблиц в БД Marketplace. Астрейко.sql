
CREATE TABLE Sales.Category
(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR (50) NOT NULL
);


CREATE TABLE Sales.Subcategory
(
SubcategoryID INT PRIMARY KEY,
SubcategoryName VARCHAR (100) NOT NULL,
CategoryID INT FOREIGN KEY (CategoryID) REFERENCES Sales.Category (CategoryID) NOT NULL
);


CREATE TABLE Sales.PickupPoint
(
PickupPointID INT PRIMARY KEY,
PickupPointNumber VARCHAR (25) UNIQUE, 
City VARCHAR (25) NOT NULL,
FullAddress VARCHAR (100) NOT NULL,
);


CREATE TABLE Sales.Customer
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR (25) NOT NULL,
CustomerSurname VARCHAR (25) NOT NULL,
BirthDate DATETIME NOT NULL,
Gender VARCHAR(2),
PhoneNumber VARCHAR(25),
City VARCHAR (25),
Activity BIT NOT NULL,
PickupPointID INT FOREIGN KEY (PickupPointID) REFERENCES Sales.PickupPoint (PickupPointID)
);


CREATE TABLE Sales.Supplier
(
SupplierID INT PRIMARY KEY,
SupplierName VARCHAR (50) NOT NULL,
);


CREATE TABLE Sales.Brand
(
BrandID INT PRIMARY KEY,
BrandName VARCHAR (50),
SupplierID INT FOREIGN KEY (SupplierID) REFERENCES Sales.Supplier (SupplierID)
);


CREATE TABLE Sales.Product
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR (100) NOT NULL,
Price DECIMAL (18,2) DEFAULT 1,
SubcategoryID INT FOREIGN KEY (SubcategoryID) REFERENCES Sales.Subcategory (SubCategoryID) NOT NULL,
SupplierID INT FOREIGN KEY (SupplierID) REFERENCES Sales.Supplier (SupplierID) NOT NULL
);


CREATE TABLE Sales.Revenue
(
ProductID INT FOREIGN KEY (ProductID) REFERENCES Sales.Product (ProductID) NOT NULL,
CustomerID INT FOREIGN KEY (CustomerID) REFERENCES Sales.Customer (CustomerID) NOT NULL,
Revenue DECIMAL (18,2),
Quantity INT CHECK(Quantity>=0) NOT NULL,
RevenueDate DATE NOT NULL,
);


--Как генерировать даты
WITH Dates AS (
    SELECT CAST('2023-01-01' AS DATE) AS Date
    UNION ALL
    SELECT DATEADD(DAY, 1, Date)
    FROM Dates
    WHERE Date < '2023-01-10'
)
SELECT Date FROM Dates
OPTION (MAXRECURSION 0);

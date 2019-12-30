DROP TABLE HasDelivery;
DROP TABLE HasPickUp;
DROP TABLE HasWalkIn;
DROP TABLE includes;
DROP TABLE Supplies;
DROP TABLE IsAPartOf;
DROP TABLE ShopStaffShift;
DROP TABLE StoreStaffPayment;
DROP TABLE DeliveryOrder;
DROP TABLE DeliveryStaffShift;
DROP TABLE DriverStaffPayment;
DROP TABLE PickUpOrder;
DROP TABLE WalkInOrder;
DROP TABLE DriverStaff;
DROP TABLE ShopStaff;
DROP TABLE Bank;
DROP TABLE Customer;
DROP TABLE IngredientOrder;
DROP TABLE Address; 
DROP TABLE Supplier;
DROP TABLE ContactPerson;
DROP TABLE Ingredient;
DROP TABLE Storage;
DROP TABLE MenuItems;

CREATE TABLE MenuItems(
	ItemCode VARCHAR(20) NOT NULL PRIMARY KEY,
	Name CHAR(20) ,
	PizzaSize CHAR(20),
	CurrentSellingPrice FLOAT(5),
	Description CHAR(50),
	CHECK(PizzaSize IN ('Small', 'Medium', 'Large'))
	
);

INSERT INTO MenuItems VALUES (001, 'Spicy Trio' , 'Large', 12, 'Vegetarian Pizza');
INSERT INTO MenuItems VALUES (002, 'Pineapple Crusty' , 'Small', 16, 'Vegetarian Pizza with Pineapple');
INSERT INTO MenuItems VALUES (003, 'Flaming Chillies' , 'Medium', 13, 'Cheese Pizza');
INSERT INTO MenuItems VALUES (004, 'New Yorker' , 'Medium', 13, 'Famous New Yorker Pizza');

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Storage(
	IngredientType CHAR(10) NOT NULL PRIMARY KEY,
	shelfLife INTEGER
);

INSERT INTO Storage VALUES ('Veg', 14);
INSERT INTO Storage VALUES ('Meat', 5);
INSERT INTO Storage VALUES ('Fruit', 7);

CREATE TABLE Ingredient(
	Code VARCHAR(20) NOT NULL PRIMARY KEY,
	Name CHAR(20),
	IngredientType CHAR(10),
	Description CHAR(50),
	StockLevelCurrentPeriod INTEGER,
	StockLevelLastStockTake INTEGER,
	SuggestedStockLevel INTEGER,
	ReorderLevel INTEGER,
	DateLastStocktakeTaken DATE,
	FOREIGN KEY (IngredientType) REFERENCES Storage(IngredientType) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Ingredient VALUES (1, 'Pineapple', 'Fruit', 'Chopped Pineapple', 15, 17, 13, 10, CONVERT(date, 'Oct 12 2019'));
INSERT INTO Ingredient VALUES (2, 'Chicken', 'Meat', 'Fine Chopped Chicken Breast Pieces', 13, 15, 10, 8, CONVERT(date, 'Oct 7 2019'));
INSERT INTO Ingredient VALUES (3, 'Mushrooms', 'Veg', 'Thin slices of Mushroom', 16, 18, 12, 9, CONVERT(date, 'Oct 21 2019'));
INSERT INTO Ingredient VALUES (4, 'Chilly Flakes', 'Veg', 'Finely Chopped Chilly', 16, 18, 12, 9, CONVERT(date, 'Oct 23 2019'));

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE ContactPerson (
	ContactPerson CHAR(20) NOT NULL PRIMARY KEY,
	Phone INTEGER,
	Email CHAR(50), 
);

INSERT INTO ContactPerson VALUES ('James', 0491570156, 'James@gmail.com');
INSERT INTO ContactPerson VALUES ('Kevin', 0491570157, 'Kevin@gmail.com');
INSERT INTO ContactPerson VALUES ('Steve', 0491570158, 'Steve@yahoo.com');

CREATE TABLE Supplier(
	SupplierNo VARCHAR(10) NOT NULL PRIMARY KEY, 
	Name CHAR(20), 
	ContactPerson CHAR(20),
	FOREIGN KEY (ContactPerson) REFERENCES ContactPerson(ContactPerson) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Supplier VALUES (007, 'James Producers', 'James');
INSERT INTO Supplier VALUES (70, 'Big Kevs Veggys', 'Kevin');
INSERT INTO Supplier VALUES (21, 'Steve Productions', 'Steve');

CREATE TABLE Address(
	SupplierNo VARCHAR(10) NOT NULL, 
	Address CHAR(30) NOT NULL, 
	PRIMARY KEY (SupplierNo, Address), 
	FOREIGN KEY (SupplierNo) REFERENCES Supplier(SupplierNo)
);

INSERT INTO Address VALUES (007, '21 Jump Street');
INSERT INTO Address VALUES (007, '23 Jump Street');
INSERT INTO Address VALUES (70, '22 Jump Street');
INSERT INTO Address VALUES (21,'5th Fifth Avenue');

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE IngredientOrder(
	OrderNo VARCHAR(10) NOT NULL PRIMARY KEY, 
	DateOfOrder DATE,
	DateReviecedOrder DATE,
	TotalAmount FLOAT(5),
	OrderStatus VARCHAR(10), 
	Description VARCHAR(50),
	SupplierNo VARCHAR(10),
	FOREIGN KEY (SupplierNo) REFERENCES Supplier(SupplierNo) ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO IngredientOrder VALUES('200',CONVERT(date, 'Oct 8 2019'), CONVERT(date, 'Oct 13 2019'), 300,'Completed', 'ordering chicken', 007 );
INSERT INTO IngredientOrder VALUES('201',CONVERT(date, 'Oct 21 2019'), CONVERT(date, 'Oct 26 2019'), 400, 'Recieved', 'ordering veggies' ,70);
INSERT INTO IngredientOrder VALUES('202',CONVERT(date, 'Oct 25 2019'), CONVERT(date, 'Oct 30 2019'), 600, 'Recieved', 'ordering Mushroom' ,21);
INSERT INTO IngredientOrder VALUES('203',CONVERT(date, 'Oct 27 2019'), CONVERT(date, 'Oct 30 2019'), 500, 'Recieved', 'ordering Chilly Flakes' ,21);

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Customer (
	CusId CHAR(10) NOT NULL PRIMARY KEY, 
	fName CHAR(15), 
	lName CHAR(15), 
	placeOfResident CHAR(50), 
	Phone INTEGER, 
	customerStatus VARCHAR(10) DEFAULT 'Hoax',
	CHECK(customerStatus IN ('Hoax', 'Verified'))
);  

INSERT INTO Customer (CusId, fName,lName,placeOfResident, Phone) VALUES ('901', 'Anastasia', 'Page', '1710 Kelly Drive', 041234567);
INSERT INTO Customer VALUES ('902', 'Ryan', 'Goff', '4762 Coal Road', 047654321, 'Verified');
INSERT INTO Customer VALUES ('903', 'Harrison', 'Hope', '3940 Ashmor Drive', 047654123, 'Verified');

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Bank(
	bankCode INTEGER NOT NULL PRIMARY KEY,
	bankName CHAR(30)
);

INSERT INTO Bank VALUES (123, 'ANZ');
INSERT INTO Bank VALUES (132, 'Commonwealth');
INSERT INTO Bank VALUES (321, 'NAB');

CREATE TABLE ShopStaff (
	EmployeeNumber VARCHAR(10) NOT NULL PRIMARY KEY, 
	FirstName CHAR(10), 
	LastName CHAR(10), 
	PostalAddress CHAR(50), 
	ContactAddress CHAR(50), 
	TaxFileNumber INTEGER, 
	bankCode INTEGER, 
	bankAccountNumber INTEGER, 
	PaymentRate FLOAT(10), 
	workStatus CHAR(20), 
	CHECK(workStatus IN ('Full Time', 'Part Time')),  
	Description CHAR(50), 
	shopRole CHAR(50),
	FOREIGN KEY (bankCode) REFERENCES Bank(bankCode) ON UPDATE CASCADE ON DELETE CASCADE
);  

INSERT INTO ShopStaff VALUES (101, 'Meera', 'Lister', '4421 Pine Tree Lane', '4421 Pine Tree Lane', 123456789, 123, 70, 25.6, 'Full Time', 'Employee for 10 years', 'Cashier');
INSERT INTO ShopStaff VALUES (102, 'Vlad', 'Berry', '657 Half AND Half Drive', '2503 Gerald L. Bates Drive', 123456788, 132, 71, 30, 'Full Time', 'Employee for 4 years', 'Accountant');
INSERT INTO ShopStaff VALUES (103, 'Sadia', 'Deacon', '4572 Bassell Avenue', '4572 Bassell Avenue', 123456787, 321, 50, 35, 'Part Time', 'Employee for 7 years', 'Manager');

CREATE TABLE DriverStaff (
	EmployeeNumber VARCHAR(10) NOT NULL PRIMARY KEY, 
	FirstName CHAR(10), 
	LastName CHAR(10), 
	PostalAddress CHAR(50), 
	ContactAddress CHAR(50), 
	TaxFileNumber INTEGER, 
	bankCode INTEGER, 
	bankAccountNumber INTEGER, 
	PaymentRate FLOAT(10), 
	workStatus CHAR(20), 
	CHECK(workStatus IN ('Full Time', 'Part Time')),  
	Description CHAR(50), 
	LicenseNumber INTEGER,
	FOREIGN KEY (bankCode) REFERENCES Bank(bankCode)
);  

INSERT INTO DriverStaff VALUES (123, 'Codey', 'Price', '2769 Saint Marys Avenue', '2769 Saint Marys Avenue', 123456778, 123, 10, 23, 'Part Time', 'Drives subaru', 789);
INSERT INTO DriverStaff VALUES (124, 'Vlad', 'Berry', '2589 Williams Lane', '4903 Jerry Toth Drive', 123456775, 123, 11, 24, 'Full Time', 'Drives toyota', 987);
INSERT INTO DriverStaff VALUES (125, 'Kevin', 'Deacon', '2832 Murphy Court', '2832 Murphy Court', 123456772, 321, 12, 22, 'Part Time', 'Drives mazda', 897);

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE WalkInOrder(
	OrderNo CHAR(10) NOT NULL PRIMARY KEY, 
	OrderDateTime DATETIME, 
	TotalAmountDue FLOAT,
	PaymentMethod VARCHAR(20), 
	CHECK(PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash')),
	paymentApprovalNo CHAR(10) DEFAULT NULL, 
	OrderStatus VARCHAR(10), 
	Description CHAR(30), 
	CusId CHAR(10), 
	EmployeeNumber VARCHAR(10), 
	TimeWalkedIn TIME,
	FOREIGN KEY (CusID) REFERENCES Customer(CusID),
	FOREIGN Key (EmployeeNumber) references ShopStaff (EmployeeNumber) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO WalkInOrder VALUES (60, CONVERT(datetime, 'Oct 13 2019 10:40:45 AM'), 200, 'Credit Card', '123456789', 'Completed', 'ordered 12 pizzas', '901', 101, CONVERT(time, '10:35:00 AM') );
INSERT INTO WalkInOrder (OrderNo, OrderDateTime, TotalAmountDue, PaymentMethod, OrderStatus, Description, CusId, EmployeeNumber, TimeWalkedIn) VALUES (61, CONVERT(datetime, 'Oct 17 2019 11:25:21 AM'), 300,  'Cash', 'Completed', 'ordered 10 pizzas', '902', 102, CONVERT(time, '11:35:00 AM') );
INSERT INTO WalkInOrder VALUES (62, CONVERT(datetime, 'Oct 20 2019 8:30:15 PM') , 400, 'Credit Card', '123456666', 'Completed', 'ordered 7 pizzas', '903', 103, CONVERT(time, '8:40:32 PM') );

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE PickUpOrder (
	OrderNo CHAR(10) NOT NULL PRIMARY KEY, 
	OrderDateTime DATETIME, 
	TotalAmountDue FLOAT,
	PaymentMethod VARCHAR(20), 
	CHECK(PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash')),
	paymentApprovalNo CHAR(10) DEFAULT NULL, 
	OrderStatus VARCHAR(10), 
	Description CHAR(30), 
	CusId CHAR(10), 
	EmployeeNumber VARCHAR(10),  
	TimeAnsweredCall TIME, 
	TimeTerminatedCall TIME, 
	pickUpTime TIME, 
	FOREIGN KEY (CusID) REFERENCES Customer(CusID),
	FOREIGN Key (EmployeeNumber) references ShopStaff (EmployeeNumber) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO PickUpOrder VALUES (170, CONVERT(datetime, 'Oct 26 2019 4:00:00 PM'), 300, 'Credit Card', '500', 'Completed', 'order 3 pizzas', '901', 101, CONVERT(time, '3:59:00 PM'), CONVERT(time, '4:02:00 PM'), CONVERT(time, '4:30:00 PM'));
INSERT INTO PickUpOrder VALUES (171, CONVERT(datetime, 'Oct 26 2019 6:00:00 PM'), 400, 'Credit Card', '501', 'Completed', 'order 4 pizzas', '903', 101, CONVERT(time, '5:59:00 PM'), CONVERT(time, '6:02:00 PM'), CONVERT(time, '6:30:00 PM'));
INSERT INTO PickUpOrder (OrderNo, OrderDateTime, TotalAmountDue, PaymentMethod, OrderStatus, Description, CusId, EmployeeNumber, TimeAnsweredCall, TimeTerminatedCall, pickUpTime) VALUES (172, CONVERT(datetime, 'Oct 26 2019 8:00:00 PM'), 450, 'Cash', 'Completed', 'order 6 pizzas', '902', 103, CONVERT(time, '7:59:00 PM'), CONVERT(time, '8:02:00 PM'), CONVERT(time, '8:30:00 PM'))

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE DriverStaffPayment(
	PaymentRecordId VARCHAR(10) NOT NULL PRIMARY KEY, 
	PaymentDate DATE, 
	PaymentPeriodStartDate DATE, 
	PaymentPeriodEndDate DATE, 
	PaymentRate FLOAT, 
	TotalNumberOfDeliveries INTEGER
);

ALTER TABLE DriverStaffPayment ADD GrossPayment AS (TotalNumberOfDeliveries * PaymentRate);
ALTER TABLE DriverStaffPayment ADD TaxWitheld AS ((TotalNumberOfDeliveries * PaymentRate) * 0.15); 
ALTER TABLE DriverStaffPayment ADD TotalAmountPaid AS ((TotalNumberOfDeliveries * PaymentRate) - ((TotalNumberOfDeliveries * PaymentRate) * 0.15)); 
GO

INSERT INTO DriverStaffPayment VALUES (1, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 30, 10); 
INSERT INTO DriverStaffPayment VALUES (2, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 40, 5); 
INSERT INTO DriverStaffPayment VALUES (3, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 15, 24);
INSERT INTO DriverStaffPayment VALUES (4, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 18, 10); 

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE DeliveryStaffShift(
	ShiftId INTEGER NOT NULL PRIMARY KEY,
	StartDate DATE, 
	StartTime TIME, 
	EndDate DATE, 
	EndTime TIME, 
	EmployeeNumber VARCHAR(10), 
	NumOfDeliveries INTEGER DEFAULT 1, 
	PaymentRecordId VARCHAR(10),
    FOREIGN Key (EmployeeNumber) references DriverStaff(EmployeeNumber) ON UPDATE CASCADE ON DELETE CASCADE, 
	FOREIGN KEY (PaymentRecordId) REFERENCES DriverStaffPayment(PaymentRecordId) ON UPDATE CASCADE ON DELETE CASCADE
	);
	
INSERT INTO DeliveryStaffShift VALUES (1, CONVERT(date, 'Oct 27 2019'), CONVERT(time, '9:00:00 AM'), CONVERT(date, 'Oct 27 2019'), CONVERT(time, '3:00:00 PM'), 123, 12, 1);
INSERT INTO DeliveryStaffShift VALUES (2, CONVERT(date, 'Oct 27 2019'), CONVERT(time, '10:00:00 AM'), CONVERT(date, 'Oct 27 2019'), CONVERT(time, '5:00:00 PM'), 124, 5, 2);
INSERT INTO DeliveryStaffShift VALUES (3, CONVERT(date, 'Oct 27 2019'), CONVERT(time, '12:00:00 AM'), CONVERT(date, 'Oct 27 2019'), CONVERT(time, '8:00:00 PM'), 125, 24, 3);
INSERT INTO DeliveryStaffShift VALUES (4, CONVERT(date, 'Oct 18 2019'), CONVERT(time, '10:00:00 AM'), CONVERT(date, 'Oct 18 2019'), CONVERT(time, '4:00:00 PM'), 123, 10, 4);

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE DeliveryOrder (
	OrderNo CHAR(10) NOT NULL PRIMARY KEY, 
	OrderDateTime DATETIME, 
	TotalAmountDue FLOAT,
	PaymentMethod VARCHAR(20), 
	CHECK(PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash')),
	paymentApprovalNo CHAR(10) DEFAULT NULL, 
	OrderStatus VARCHAR(10), 
	Description CHAR(30), 
	CusId CHAR(10), 
	EmployeeNumber VARCHAR(10), 
	TimeAnsweredCall TIME, 
	TimeTerminatedCall TIME, 
	deliveryTime TIME, 
	deliveryAddress CHAR(30), 
	DriverStaffInfo CHAR(20), 
	ShiftId INTEGER, 
	FOREIGN KEY (CusID) REFERENCES Customer(CusID)  ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN Key (EmployeeNumber) references ShopStaff (EmployeeNumber) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN Key (ShiftId) references DeliveryStaffShift(ShiftId) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO DeliveryOrder VALUES (1, 
CONVERT(DATETIME, 'Oct 27 2019 11:50:00 AM'), 400, 'Credit Card', '1234567', 'delivered', '12 pizzas', '901', 101, 
CONVERT(TIME, '11:30:00 AM'), CONVERT(TIME, '11:35:00 AM'), CONVERT(TIME, '11:59:00 AM'), '21 Alton Rd', 'Driver 123', 1);

INSERT INTO DeliveryOrder VALUES (2, 
CONVERT(DATETIME, 'Oct 27 2019 11:50:00 AM'), 450, 'Debit Card', '1234567', 'delivered', '12 pizzas', '902', 102, 
CONVERT(TIME, '11:30:00 AM'), CONVERT(TIME, '11:35:00 AM'), CONVERT(TIME, '11:59:00 AM'), '9 Eleven Rd', 'Driver 124', 2);

INSERT INTO DeliveryOrder VALUES (3, 
CONVERT(DATETIME, 'Oct 27 2019 11:50:00 AM'), 525, 'Debit Card', '1234567', 'delivered', '12 pizzas', '903', 103, 
CONVERT(TIME, '11:30:00 AM'), CONVERT(TIME, '11:35:00 AM'), CONVERT(TIME, '11:59:00 AM'), '7 Ring Rd', 'Driver 124', 3);

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE StoreStaffPayment(
	PaymentRecordId VARCHAR(10) NOT NULL PRIMARY KEY, 
	PaymentDate DATE, 
	PaymentPeriodStartDate DATE, 
	PaymentPeriodEndDate DATE, 
	PaymentRate FLOAT, 
	TotalNumberOfHoursWorked INTEGER,
);

ALTER TABLE StoreStaffPayment ADD GrossPayment AS (TotalNumberOfHoursWorked * PaymentRate);
ALTER TABLE StoreStaffPayment ADD TaxWitheld AS ((TotalNumberOfHoursWorked * PaymentRate) * 0.15); 
ALTER TABLE StoreStaffPayment ADD TotalAmountPaid AS ((TotalNumberOfHoursWorked * PaymentRate) - ((TotalNumberOfHoursWorked * PaymentRate) * 0.15)); 
GO

INSERT INTO StoreStaffPayment VALUES (1, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 26.25, 12); 
INSERT INTO StoreStaffPayment VALUES (2, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 25, 9); 
INSERT INTO StoreStaffPayment VALUES (3, CONVERT(date, 'Oct 31 2019'), CONVERT(date, 'Oct 17 2019'), CONVERT(date, 'Oct 31 2019'), 45, 10); 

CREATE TABLE ShopStaffShift(
	ShiftId INTEGER NOT NULL PRIMARY KEY,
	StartDate DATE, 
	StartTime TIME, 
	EndDate DATE, 
	EndTime TIME,
	EmployeeNumber VARCHAR(10), 
	BreakTime CHAR(20), 
	PaymentRecordId VARCHAR(10),
	FOREIGN KEY (EmployeeNumber) REFERENCES ShopStaff(EmployeeNumber)  ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (PaymentRecordId) REFERENCES StoreStaffPayment(PaymentRecordId)  ON UPDATE CASCADE ON DELETE CASCADE
	);

INSERT INTO ShopStaffShift VALUES (1,CONVERT(DATE, 'Oct 26 2019'), CONVERT(TIME, '9:00:00 AM'), CONVERT(DATE, 'Oct 26 2019'), CONVERT(TIME, '10:00:00 PM'), 101, '1 hr break', 1);
INSERT INTO ShopStaffShift VALUES (2,CONVERT(DATE, 'Oct 26 2019'), CONVERT(TIME, '10:00:00 AM'), CONVERT(DATE, 'Oct 26 2019'), CONVERT(TIME, '9:00:00 PM'), 102, '1 hr break', 2);
INSERT INTO ShopStaffShift VALUES (3,CONVERT(DATE, 'Oct 26 2019'), CONVERT(TIME, '11:00:00 AM'), CONVERT(DATE, 'Oct 26 2019'), CONVERT(TIME, '8:00:00 PM'), 103, '2 hr break', 3);

----------------------------------------------------------------------------------------------------------------------

--	Descriptive Attributes
CREATE TABLE IsAPartOf (
	OrderNo VARCHAR(10) NOT NULL, 
	Code VARCHAR(20) NOT NULL, 
	quantity INTEGER DEFAULT 1, 
	price FLOAT, 
	PRIMARY KEY (OrderNo, Code),
	FOREIGN KEY (OrderNo) REFERENCES IngredientOrder(OrderNo),
	FOREIGN KEY (Code) REFERENCES Ingredient(Code),
); 

INSERT INTO IsAPartOf VALUES (200, 2, 3, 51.5);

INSERT INTO IsAPartOf VALUES (201, 1, 3, 30.75);
INSERT INTO IsAPartOf VALUES (201, 3, 4, 15.60);
INSERT INTO IsAPartOf VALUES (201, 4, 3, 10.45);

INSERT INTO IsAPartOf VALUES (202, 3, 3, 13);
INSERT INTO IsAPartOf VALUES (203, 4, 10, 34.85);

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Supplies (
	SupplierNo VARCHAR(10) NOT NULL , 
	Code VARCHAR(20) NOT NULL , 
	PriceOfIngredients FLOAT, 
	QuantityOfIngredients INTEGER DEFAULT 1,
	PRIMARY KEY (SupplierNo, Code), 
	FOREIGN Key (SupplierNo) references Supplier (SupplierNo) ON UPDATE CASCADE ON DELETE CASCADE, 
	FOREIGN Key (Code) references Ingredient (Code) ON UPDATE CASCADE ON DELETE CASCADE
); 
INSERT INTO Supplies VALUES (007, 1, 30, 12); 
INSERT INTO Supplies VALUES (70, 2, 60, 10); 
INSERT INTO Supplies VALUES (21, 3, 25, 10); 
INSERT INTO Supplies VALUES (21, 4, 27.5, 10); 

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE includes (
	Code VARCHAR(20) NOT NULL  , 
	ItemCode VARCHAR(20) NOT NULL , 
	Quantity INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY (Code, ItemCode), 
	FOREIGN Key (Code) references Ingredient (Code) ON UPDATE CASCADE ON DELETE CASCADE, 
	FOREIGN Key (ItemCode) references MenuItems(ItemCode) ON UPDATE CASCADE ON DELETE CASCADE
); 

INSERT INTO includes VALUES (4, 001, 3); 
INSERT INTO includes VALUES (3, 001, 6); 
INSERT INTO includes VALUES (1, 001, 2); 

INSERT INTO includes VALUES (1, 002, 7);
 
INSERT INTO includes VALUES (4, 003, 12); 

INSERT INTO includes VALUES (2, 004, 7); 
INSERT INTO includes VALUES (3, 004, 4); 
INSERT INTO includes VALUES (1, 004, 3); 

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE HasWalkIn(
	OrderNo CHAR(10) NOT NULL , 
	ItemCode VARCHAR(20) NOT NULL , 
	Quantity INTEGER DEFAULT 1, 
	Price FLOAT, 
	PRIMARY KEY (OrderNo , ItemCode), 
	FOREIGN Key (OrderNo) references WalkInOrder (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN Key (ItemCode) references MenuItems (ItemCode) ON UPDATE CASCADE ON DELETE CASCADE
); 

INSERT INTO HasWalkIn VALUES (60, 001, 5, 27); 
INSERT INTO HasWalkIn VALUES (60, 004, 7, 67.84); 

INSERT INTO HasWalkIn VALUES (61, 004, 10, 104.5); 

INSERT INTO HasWalkIn VALUES (62, 002, 7, 92.4); 

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE HasPickUp(
	OrderNo CHAR(10) NOT NULL , 
	ItemCode VARCHAR(20) NOT NULL , 
	Quantity INTEGER DEFAULT 1, 
	Price FLOAT, 
	PRIMARY KEY (OrderNo , ItemCode), 
	FOREIGN Key (OrderNo) references PickupOrder (OrderNo)  ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN Key (ItemCode) references MenuItems (ItemCode) ON UPDATE CASCADE ON DELETE CASCADE
);  

INSERT INTO HasPickUp VALUES (170, 003, 3, 21.3);

INSERT INTO HasPickUp VALUES (171, 001, 4, 26.7);

INSERT INTO HasPickUp VALUES (172, 004, 6, 45.9);

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE HasDelivery(
	OrderNo CHAR(10) NOT NULL , 
	ItemCode VARCHAR(20) NOT NULL , 
	Quantity INTEGER DEFAULT 1, 
	Price FLOAT, 
	PRIMARY KEY (OrderNo , ItemCode), 
	FOREIGN Key (OrderNo) references DeliveryOrder (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN Key (ItemCode) references MenuItems (ItemCode) ON UPDATE CASCADE ON DELETE CASCADE
);  


INSERT INTO HasDelivery VALUES (1, 004, 12, 135.5);

INSERT INTO HasDelivery VALUES (2, 002, 6, 33);
INSERT INTO HasDelivery VALUES (2, 003, 7, 27);

INSERT INTO HasDelivery VALUES (3, 004, 12, 122.4);

----------------------------------------------------------------------------------------------------------------------

-- Assignment Questions: 

-- Q.1  For  an  in-office  staff  with  id  number  xxx,  print  his/her  1stname,  lname,  AND  hourly payment rate. 
SELECT EmployeeNumber, FirstName, LastName, PaymentRate
FROM ShopStaff
WHERE EmployeeNumber = 102; 

-- -- Q.2  List all  the  shift  details  of  a  delivery  staff  with  first  name  xxx  AND  last  name  ttt  BETWEEN date yyy AND zzz. 
SELECT s.*
FROM DeliveryStaffShift s, DriverStaff d
WHERE s.EmployeeNumber = d.EmployeeNumber AND
s.EmployeeNumber = (SELECT EmployeeNumber FROM DriverStaff WHERE FirstName = 'Codey' AND LastName = 'Price')
AND s.StartDate BETWEEN CONVERT(DATE, 'Oct 1 2019') AND CONVERT(DATE, 'Oct 31 2019') AND 
s.EndDate BETWEEN CONVERT(DATE, 'Oct 1 2019') AND CONVERT(DATE, 'Oct 31 2019'); 

-- -- Q.3 List  all  the  order  details  of  the  orders  that  are  made  by  a  walk-in  customer  with  first name xxx AND last name ttt BETWEEN date yyy AND zzz.
SELECT w.*
FROM WalkInOrder w, Customer c 
WHERE w.CusID = c.CusID AND w.CusID = (SELECT CusID FROM Customer WHERE fName = 'Ryan' AND lName ='Goff') AND 
w.OrderDateTime BETWEEN CONVERT(DATE, 'Oct 1 2019') AND CONVERT(DATE, 'Oct 31 2019');

-- -- Q.4  Print  the  salary  paid  to  a  delivery  staff  with  first  name  xxx  AND  last  name  ttt  in current  month.  
-- -- Note  the  current  month  is  the  current  month  that  is  decided  by  the  system.

SELECT d.EmployeeNumber, SUM(GrossPayment) AS GrossPayment, SUM(p.TotalAmountPaid) AS TotalAmountPaid
FROM DeliveryStaffShift s, DriverStaff d, DriverStaffPayment p
WHERE d.EmployeeNumber = s.EmployeeNumber 
	AND s.PaymentRecordId = p.PaymentRecordId 
	AND s.EmployeeNumber = (SELECT EmployeeNumber FROM DriverStaff WHERE FirstName = 'Codey' AND LastName = 'Price')
	AND DATEPART(MONTH, p.PaymentDate) = MONTH(GETDATE())
GROUP BY d.EmployeeNumber

-- -- Q.5 List the name of the menu item that is mostly ordered in current year

CREATE TABLE #MenuOrderTimes
(
	Name CHAR(20),
	Quantity INTEGER
); 

INSERT into #MenuOrderTimes
SELECT DISTINCT s.Name, Quantity
FROM HasPickUp h, MenuItems s, PickUpOrder p
WHERE h.ItemCode = s.ItemCode AND DATEPART(YEAR, (p.OrderDateTime)) = YEAR(getdate());

INSERT into #MenuOrderTimes
SELECT DISTINCT s.Name, Quantity
FROM HasWalkIn h, MenuItems s, WalkInOrder w
WHERE h.ItemCode = s.ItemCode AND DATEPART(YEAR, (w.OrderDateTime)) = YEAR(getdate());

INSERT into #MenuOrderTimes
SELECT DISTINCT s.Name, Quantity
FROM HasDelivery h, MenuItems s, DeliveryOrder d
WHERE h.ItemCode = s.ItemCode AND DATEPART(YEAR, (d.OrderDateTime)) = YEAR(getdate());

CREATE TABLE #TotalMenuItemsOrder
(
	Name CHAR(20),
	Quantity INTEGER
); 
INSERT into #TotalMenuItemsOrder SELECT Name, SUM(Quantity) FROM #MenuOrderTimes GROUP BY Name; 

SELECT Name, Quantity FROM #TotalMenuItemsOrder WHERE Quantity >= ALL (SELECT Quantity FROM #TotalMenuItemsOrder) GROUP BY Name, Quantity;

DROP TABLE #MenuOrderTimes;
DROP TABLE #TotalMenuItemsOrder;

-- -- Q.6  List the name(s) of the  ingredient(s) that was/were supplied by the supplier with supplier ID xxx on date yyy.

SELECT Distinct i.Name
FROM IngredientOrder io, IsAPartOf p, Ingredient i  
WHERE io.SupplierNo = 70 AND io.OrderNo = p.OrderNo AND i.Code = p.Code AND io.DateReviecedOrder = CONVERT(date, 'Oct 26 2019'); 
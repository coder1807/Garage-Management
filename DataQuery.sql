﻿

USE QLGarage
GO

-- Car
-- CarCategory
-- Suplier
-- Customer
-- Staff
-- Account
-- Inventory
-- Bill
-- BillInfo (id car, id category ...)
-- ReportExcel

CREATE TABLE Car (
	idCar NVARCHAR(10) PRIMARY KEY,
	nameCar NVARCHAR(100) NOT NULL,
--	imageCar IMAGE DEFAULT NULL,
	idSup int Default null,
	ngayNhap datetime,
	price FLOAT NOT NULL DEFAULT 0,
	idDatHang INT default NULL	
)
GO
drop table Car;
Insert into dbo.Car (idCar, nameCar, idSup, ngayNhap, price, idDatHang)
values('car01', 'C200', 1, '2023-03-03', 1000000, 1),
		('car02', '911 Turbo', 2,'2023-04-03', 8888888, null),
		('car03', 'CamryHyrid', 3, '2023-05-03', 2000000, null),
		('car04', 'Civic', 4, '2023-06-03', 800000, null),
		('car05', 'CX5', 5, '2023-07-03', 750000, 2);

insert into dbo.Suplier(idSup, nameSup)
values(1,'Mercedes'),(2, 'Porsche'),(3,'Toyota'),(4, 'Honda'),(5, 'Mazda');

insert into dbo.DaDatHang(idDat, info)
values(1, 'Nguyen Van A 0987654321'),(2, 'Nguyen Van B 0123456789');

ALTER TABLE dbo.Car ADD CONSTRAINT FK_idDatHang FOREIGN KEY(idDatHang) REFERENCES dbo.DaDatHang(idDat)
ALTER TABLE dbo.Car ADD CONSTRAINT FK_idSup FOREIGN KEY(idSup) REFERENCES dbo.Suplier(idSup)

CREATE TABLE DaDatHang(
	idDat INT PRIMARY KEY,
	info NVARCHAR(100) DEFAULT NULL
)
GO

CREATE TABLE Suplier(
	idSup INT PRIMARY KEY,
	nameSup NVARCHAR(100) NOT NULL DEFAULT N'CHƯA CÓ TÊN',
)
GO

CREATE TABLE Customer (
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'CHƯA CÓ TÊN',
	sex BIT NOT NULL DEFAULT 0, -- 0: MALE, 1: FEMALE 
	DateOfBirth DATETIME NOT NULL,
	Address NVARCHAR(100) NOT NULL,
	Phone NVARCHAR(11) NOT NULL -- RÀNG BUỘC,
)
GO

CREATE TABLE Account (
	UserName NVARCHAR(100) NOT NULL PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'VIỆT',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0, -- PASSWORD && MÃ HÓA PASS
	Type INT NOT NULL DEFAULT 1 -- DEFAULT ADMIN
)
GO

CREATE TABLE Inventory (
	id INT IDENTITY PRIMARY KEY NOT NULL,

)
GO

CREATE TABLE Bill(
	id INT IDENTITY PRIMARY KEY,
	DataCheckIn DATE NOT NULL DEFAULT GETDATE(),
	idCar INT NOT NULL,
	status INT NOT NULL DEFAULT 0, -- 1: ĐÃ THANH TOÁN && 0: CHƯA THANH TOÁN
	-- TOTAL PRICE 

	FOREIGN KEY (idCar) REFERENCES Car(idCar)
)
GO

CREATE TABLE BillInfo (
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idCarCategory INT NOT NULL,
	count INT NOT NULL DEFAULT 0,

	FOREIGN KEY (idBill) REFERENCES Bill(id),
	FOREIGN KEY (idCarCategory) REFERENCES CarCategory(id)
)
GO

CREATE TABLE Staff (
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	age INT NOT NULL,
	sex BIT NOT NULL DEFAULT 0, -- 0: MALE, -- 1: FEMALE
	phone CHAR(11) NOT NULL, -- RÀNG BUỘC
	position NVARCHAR(100) NOT NULL DEFAULT N'NHÂN VIÊN',
)
GO

INSERT INTO Account(
	UserName,
	DisplayName,
	PassWord,
	Type
)

VALUES (
	N'viet' , -- UserName - nvarchar(100)
	N'Việt', -- DisplayName - nvarchar(100)
	N'1', -- PassWord - nvarchar(1000)
	1 -- Type - int
)

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM Account WHERE UserName = @userName
END
GO

select * from Account where UserName = N'viet' and PassWord = N'1'

EXEC USP_GetAccountByUserName @userName = N'viet'
GO

CREATE PROC USP_Login
@userName nvarchar(100) , @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

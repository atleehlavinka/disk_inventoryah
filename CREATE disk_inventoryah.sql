USE MASTER;
GO

DROP DATABASE IF EXISTS [disk_inventoryah];
GO

-- =======================================================================
-- Author: Atlee Hlavinka
-- Create Date: 03/04/2022
-- Description: Create Disk Database

/* Update Log
DATE		DEVELOPER		DESCRIPTION
03/04/2022	Atlee Hlavinka	Initial Implementation - Project02.
03/11/2022	Atlee Hlavinka	Inserted data into tables.
*/
-- =======================================================================
CREATE DATABASE disk_inventoryah;
GO

--Create Login
IF SUSER_ID('diskUserah') IS NULL
	CREATE LOGIN diskUserah
	WITH PASSWORD = 'MSPress#1'
	, DEFAULT_DATABASE = disk_inventoryah;

USE disk_inventoryah;
GO

-- Create User and assign SELECT permission
CREATE USER diskUserah;
ALTER ROLE db_datareader
	ADD MEMBER diskUserah;
GO

--Drop Tables
IF OBJECT_ID('[dbo].[disk_has_borrower]') IS NOT NULL DROP TABLE [dbo].[disk_has_borrower]
IF OBJECT_ID('[dbo].[disk]') IS NOT NULL DROP TABLE [dbo].[disk]
IF OBJECT_ID('[dbo].[disk_type]') IS NOT NULL DROP TABLE [dbo].[disk_type]
IF OBJECT_ID('[dbo].[disk_genre]') IS NOT NULL DROP TABLE [dbo].[disk_genre]
IF OBJECT_ID('[dbo].[disk_status]') IS NOT NULL DROP TABLE [dbo].[disk_status]
IF OBJECT_ID('[dbo].[disk_borrower]') IS NOT NULL DROP TABLE [dbo].[disk_borrower]
IF OBJECT_ID('[dbo].[disk]') IS NOT NULL DROP TABLE [dbo].[disk]

--Create Tables
CREATE TABLE disk_type (
	disk_type_id	INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
	, description	VARCHAR(50) NOT NULL
);

CREATE TABLE disk_genre (
	genre_id		INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
	, description	VARCHAR(20) NOT NULL
);

CREATE TABLE disk_status (
	status_id		INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
	, description	VARCHAR(20) NOT NULL
);

CREATE TABLE disk_borrower (
	borrower_id		INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
	, fname			NVARCHAR(50) NOT NULL
	, lname			NVARCHAR(50) NOT NULL
	, phone_num		VARCHAR(15) NOT NULL
);

CREATE TABLE disk (
	disk_id			INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
	, disk_name		NVARCHAR(40) NOT NULL
	, disk_artist		NVARCHAR(20) NOT NULL
	, release_date	DATE NOT NULL
	, status_id		INT FOREIGN KEY REFERENCES disk_status(status_id) NOT NULL
	, disk_type_id	INT FOREIGN KEY REFERENCES disk_type(disk_type_id) NOT NULL
	, genre_id		INT FOREIGN KEY REFERENCES disk_genre(genre_id) NOT NULL
);

CREATE TABLE disk_has_borrower (
	disk_has_borrower_id	INT IDENTITY(1,1) PRIMARY KEY
	, borrower_id			INT FOREIGN KEY REFERENCES disk_borrower(borrower_id) NOT NULL
	, disk_id				INT FOREIGN KEY REFERENCES disk(disk_id) NOT NULL
	, borrowed_date			DATE NOT NULL -- AH 03/11/2022 updated to DATE from DATETIME2
	, returned_date			DATE NULL -- AH 03/11/2022 updated to DATE from DATETIME2
);

--Insert data -- AH 03/11/2022
INSERT INTO disk_type (description)
VALUES 
	('CD')
	, ('Vinyl')
	, ('Cassette')
	, ('DVD')
	, ('8-track')

INSERT INTO disk_genre (description)
VALUES 
	('Alternative')
	, ('Indie Folk')
	, ('Indie Rock')
	, ('Indie Pop')
	, ('Rock')

INSERT INTO disk_status (description)
VALUES 
	('Available')
	, ('On Loan')
	, ('Damaged')
	, ('Missing')
	, ('Unavailable')

INSERT INTO disk_borrower (fname, lname, phone_num)
VALUES
	('Mickey', 'Mouse' , '543-264-6723')
	, ('Donald', 'Duck',  '245-554-7665')
	, ('Greg', 'Thomas',  '745-754-7235')
	, ('Randy', 'Harold',  '875-544-7565')
	, ('Mandy', 'Smith',  '712-875-4535')
	, ('John', 'Apple',  '875-984-7735')
	, ('Jake', 'State',  '276-787-9935')
	, ('Hannah', 'Pearson',  '745-654-8956')
	, ('Harold', 'Nelly',  '215-754-6235')
	, ('Neil', 'Armstrong',  '945-754-0235')
	, ('Gale', 'Fern',  '545-754-6535')
	, ('George', 'Foreman',  '215-754-3435')
	, ('Ray', 'Ren',  '945-754-0935')
	, ('Cher', 'Mick',  '345-754-2345')
	, ('Kristen', 'Smith',  '655-743-2346')
	, ('Krissy', 'Springer',  '332-214-8935')
	, ('Jerry', 'Seinfield',  '745-935-0935')
	, ('Jessica', 'Bone',  '745-026-6735')
	, ('Jessy', 'Springer',  '745-765-7542')
	, ('Jeffrey', 'White',  '745-045-9476')
	, ('Katie', 'Rice',  '745-856-3783');

DELETE disk_borrower
WHERE borrower_id = 21;

INSERT INTO disk (disk_name, disk_artist, release_date, status_id, disk_type_id, genre_id)
VALUES 
	('El Camino', 'The Black Keys', '12/06/2011', 2, 1, 3)
	, ('AM', 'Arctic Monkeys', '09/09/2013', 5, 1, 3)
	, ('The Empty Northern Hemisphere', 'Gregory Alan Isakov', '09/03/2009', 1, 1, 2)
	, ('Evening Machines', 'Gergory Alan Isakov', '03/04/2018', 4, 1, 2)
	, ('The Attractions of Youth', 'Barns Courtney', '05/31/2017', 1, 1, 5)
	, ('Woodland - EP', 'The Paper Kites', '06/13/2013', 1, 4, 2)
	, ('Young the Giant', 'Young the Giant', '04/23/2011', 2, 1, 1)
	, ('Home of the Strange', 'Young the Giant', '08/13/2019', 2, 2, 1)
	, ('Ashlyn', 'Ashe', '01/08/2021', 2, 4, 4)
	, ('Busyhead', 'Noah Kahan', '07/07/2019', 3, 1, 3)
	, ('This is All Yours', 'alt-J', '02/09/2014',  1, 2, 1)
	, ('An Awesome Wave', 'alt-J', '06/02/2012', 2, 2, 1)
	, ('Wanderlust', 'Hollow Coves', '12/14/2017', 2, 1, 2)
	, ('Moments', 'Hollow Coves', '10/12/2019', 1, 1, 2)
	, ('Blessings', 'Hollow Coves', '10/12/2019', 1, 1, 2)
	, ('Walk The Moon', 'Walk The Moon', '01/12/2012', 1, 1, 2)
	, ('When It Was Now', 'Atlas Genius', '09/08/2013', 4, 2, 4)
	, ('Wasteland, Baby!', 'Hozier', '11/25/2019', 1, 1, 2)
	, ('Hozier', 'Hozier', '08/08/2014', 4, 2, 4)
	, ('Cleopatra', 'The Lumineers', '04/03/2016', 1, 2, 2);

UPDATE disk
SET release_date = '01/01/2008'
WHERE disk_name = 'Young the Giant';

INSERT disk_has_borrower
	(borrower_id, disk_id, borrowed_date, returned_date)
VALUES
	(1, 1, '01/01/2020', '01/12/2020')
	, (4, 10, '02/03/2020', '02/09/2020')
	, (4, 12, '03/02/2020', '03/13/2020')
	, (5, 18, '04/07/2020', '04/15/2020')
	, (7, 11, '05/05/2020', '05/12/2020')
	, (2, 9, '06/04/2020', '06/19/2020')
	, (8, 6, '07/03/2020', NULL)
	, (4, 4, '08/09/2020', '08/11/2020')
	, (1, 1, '09/07/2020', '09/12/2020')
	, (10, 9, '10/06/2020', '10/14/2020')
	, (1, 15, '11/05/2020', '11/15/2020')
	, (16, 19, '12/08/2020', '12/18/2020')
	, (12, 13, '01/02/2021', '01/13/2021')
	, (11, 12, '02/05/2021', '02/10/2021')
	, (12, 7, '03/04/2021', '03/19/2021')
	, (1, 1, '04/09/2021', '04/21/2021')
	, (2, 2, '05/07/2021', '05/22/2021')
	, (9, 9, '06/06/2021', NULL)
	, (5, 8, '07/09/2021', '07/13/2021')
	, (13, 18, '08/03/2021', '08/11/2021')


--Disks not returned
SELECT 
	disk_has_borrower_id AS Borrower_id
	, disk_id AS Disk_id
	, borrowed_date AS Borrowed_date
	, returned_date AS Return_date
FROM disk_has_borrower 
WHERE returned_date IS NULL

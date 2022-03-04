USE MASTER;
GO

DROP DATABASE IF EXISTS disk_inventoryah;
GO

-- =======================================================================
-- Author: Atlee Hlavinka
-- Create Date: 03/04/2022
-- Description: Create Disk Database

/* Update Log
DATE		DEVELOPER		DESCRIPTION
03/04/2022	Atlee Hlavinka	Initial Implementation - Project02

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
	, disk_name		NVARCHAR(20) NOT NULL
	, release_date	DATE NOT NULL
	, status_id		INT FOREIGN KEY REFERENCES disk_status(status_id) NOT NULL
	, disk_type_id	INT FOREIGN KEY REFERENCES disk_type(disk_type_id) NOT NULL
	, genre_id		INT FOREIGN KEY REFERENCES disk_genre(genre_id) NOT NULL
);

CREATE TABLE disk_has_borrower (
	disk_has_borrower_id	INT IDENTITY(1,1) PRIMARY KEY
	, borrower_id			INT FOREIGN KEY REFERENCES disk_borrower(borrower_id) NOT NULL
	, disk_id				INT FOREIGN KEY REFERENCES disk(disk_id) NOT NULL
	, borrowed_date			DATETIME2 NOT NULL
	, returned_date			DATETIME2 NULL
);
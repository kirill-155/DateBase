USE [Library]
GO

CREATE TABLE ������(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	��������� nvarchar(50),
	������� nvarchar(50),
	��� nvarchar(50),
	�������� nvarchar(50)
);

CREATE TABLE ����(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	�������� nvarchar(50) NOT NULL
);

CREATE TABLE ������������(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	�������� nvarchar(50) NOT NULL
);

CREATE TABLE ������(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	�������� nvarchar(50) NOT NULL
);

CREATE TABLE ��������(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	������� nvarchar(50) NOT NULL,
	��� nvarchar(50) NOT NULL,
	�������� nvarchar(50),
	������������� money CHECK (������������� >= 0),
	Id_������ int NOT NULL FOREIGN KEY REFERENCES ������(Id)
);

CREATE TABLE �����(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	�������� nvarchar(50) NOT NULL,
	���� money CHECK (���� >= 0) NOT NULL,
	���_������� date NOT NULL,
	�����_����������� int CHECK (�����_����������� >= 0) NOT NULL,
	Id_������������ int NOT NULL FOREIGN KEY REFERENCES ������������(Id)
);

CREATE TABLE ������_���(
	Id_���� int NOT NULL FOREIGN KEY REFERENCES ����(Id),
	Id_����� int NOT NULL FOREIGN KEY REFERENCES �����(Id),
	PRIMARY KEY (Id_����, Id_�����)
);

CREATE TABLE ������_�������(
	Id_������ int NOT NULL FOREIGN KEY REFERENCES ������(Id),
	Id_����� int NOT NULL FOREIGN KEY REFERENCES �����(Id),
	PRIMARY KEY (Id_������, Id_�����)
);

CREATE TABLE ������_����(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_�������� int NOT NULL FOREIGN KEY REFERENCES ��������(Id),
	Id_����� int NOT NULL FOREIGN KEY REFERENCES �����(Id),
	���������� int CHECK (���������� >= 0) NOT NULL,
	����_������ date NOT NULL,
	����_��������������_����� date NOT NULL,
	����_�����������_����� date,
	����� money CHECK (����� >= 0)
);
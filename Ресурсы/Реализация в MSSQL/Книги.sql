USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[�����]
GO

CREATE TABLE �����(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	�������� nvarchar(50) NOT NULL,
	���� int NOT NULL,
	���_������� date NOT NULL,
	�����_����������� int NOT NULL,
	Id_������������ int NOT NULL FOREIGN KEY REFERENCES ������������(Id)
)
GO

SET IDENTITY_INSERT ����� ON
GO

INSERT INTO ����� (Id, ��������, ����, ���_�������, �����_�����������, Id_������������) VALUES
(2, N'���������� ���������', 10000, CAST(N'2025-09-20' AS Date), 100, 1),
(4, N'�����, �������� ���', 200, CAST(N'2025-08-10' AS Date), 100, 2),
(7, N'���������� �������', 200, CAST(N'2025-06-30' AS Date), 100, 3),
(8, N'����������', 200, CAST(N'2024-10-27' AS Date), 100, 4),
(9, N'�������� �����', 200, CAST(N'2024-09-16' AS Date), 100, 5),
(10, N'�������� �����', 200, CAST(N'2024-08-06' AS Date), 100, 6),
(11, N'������� �����������', 200, CAST(N'2024-06-26' AS Date), 100, 7),
(12, N'�����', 200, CAST(N'2025-04-09' AS Date), 100, 8),
(13, N'�����', 200, CAST(N'2025-02-27' AS Date), 100, 9),
(14, N'�������� ���', 200, CAST(N'2025-05-20' AS Date), 100, 10),
(15, N'���� ����� ����', 200, CAST(N'2024-05-16' AS Date), 100, 1),
(16, N'�������.1807', 200, CAST(N'2025-01-17' AS Date), 100, 2),
(17, N'������ � ����', 200, CAST(N'2024-12-07' AS Date), 100, 3)

GO

SET IDENTITY_INSERT ����� OFF
GO
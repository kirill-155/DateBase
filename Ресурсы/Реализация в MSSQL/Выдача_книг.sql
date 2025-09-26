USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[������ ����]
GO

CREATE TABLE ������_����(
	Id_�������� int NOT NULL FOREIGN KEY REFERENCES ��������(Id),
	Id_����� int NOT NULL FOREIGN KEY REFERENCES �����(Id),
	���������� int NOT NULL,
	����_������ date NOT NULL,
	����_��������������_����� date NOT NULL,
	����_�����������_����� date,
	����� int,
	PRIMARY KEY (Id_��������, Id_�����)
)
GO

INSERT INTO ������_���� (Id_��������, Id_�����, ����������, ����_������, ����_��������������_�����, ����_�����������_�����, �����) VALUES
(1, 2, 1, CAST(N'2025-10-10' AS Date), CAST(N'2025-10-11' AS Date), NULL, NULL),
(15, 4, 1, CAST(N'2025-01-09' AS Date), CAST(N'2025-01-10' AS Date), NULL, NULL),
(16, 7, 1, CAST(N'2025-09-09' AS Date), CAST(N'2025-10-09' AS Date), NULL, NULL),
(23, 14, 1, CAST(N'2025-09-16' AS Date), CAST(N'2025-10-16' AS Date), NULL, NULL),
(27, 9, 1, CAST(N'2025-09-11' AS Date), CAST(N'2025-10-11' AS Date), NULL, NULL),
(44, 13, 1, CAST(N'2025-09-15' AS Date), CAST(N'2025-10-15' AS Date), NULL, NULL),
(45, 8, 1, CAST(N'2025-09-10' AS Date), CAST(N'2025-10-10' AS Date), NULL, NULL),
(45, 16, 1, CAST(N'2025-09-18' AS Date), CAST(N'2025-10-18' AS Date), NULL, NULL),
(55, 15, 1, CAST(N'2025-09-17' AS Date), CAST(N'2025-10-17' AS Date), NULL, NULL),
(59, 10, 1, CAST(N'2025-09-12' AS Date), CAST(N'2025-10-12' AS Date), NULL, NULL),
(60, 11, 1, CAST(N'2025-09-13' AS Date), CAST(N'2025-10-13' AS Date), NULL, NULL),
(73, 12, 1, CAST(N'2025-09-14' AS Date), CAST(N'2025-10-14' AS Date), NULL, NULL)

GO
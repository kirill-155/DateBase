USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[������ �������]
GO

CREATE TABLE ������_�������(
	Id_������ int NOT NULL FOREIGN KEY REFERENCES ������(Id),
	Id_����� int NOT NULL FOREIGN KEY REFERENCES �����(Id),
	PRIMARY KEY (Id_������, Id_�����)
)
GO

INSERT INTO ������_������� (Id_������, Id_�����) VALUES
(1, 7),
(2, 8),
(3, 9),
(4, 10),
(5, 11),
(6, 12),
(7, 13),
(8, 14),
(9, 15),
(10, 2),
(10, 16),
(11, 4),
(11, 17)

GO
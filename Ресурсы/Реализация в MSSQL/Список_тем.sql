USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[������ ���]
GO

CREATE TABLE ������_���(
	Id_���� int NOT NULL FOREIGN KEY REFERENCES ����(Id),
	Id_����� int NOT NULL FOREIGN KEY REFERENCES �����(Id),
	PRIMARY KEY (Id_����, Id_�����)
)
GO

INSERT INTO ������_��� (Id_����, Id_�����) VALUES
(1, 2),
(1, 4),
(1, 8),
(1, 12),
(1, 15),
(1, 16),
(1, 17),
(4, 7),
(4, 10),
(5, 9),
(5, 13),
(10, 2),
(10, 4),
(13, 10),
(13, 13),
(15, 14),
(17, 2),
(18, 11)

GO
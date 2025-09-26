USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[Книги]
GO

CREATE TABLE Книги(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Название nvarchar(50) NOT NULL,
	Цена int NOT NULL,
	Год_издания date NOT NULL,
	Число_экземпляров int NOT NULL,
	Id_издательства int NOT NULL FOREIGN KEY REFERENCES Издательства(Id)
)
GO

SET IDENTITY_INSERT Книги ON
GO

INSERT INTO Книги (Id, Название, Цена, Год_издания, Число_экземпляров, Id_издательства) VALUES
(2, N'Бескрайний архипелаг', 10000, CAST(N'2025-09-20' AS Date), 100, 1),
(4, N'Город, которого нет', 200, CAST(N'2025-08-10' AS Date), 100, 2),
(7, N'Неучтенный элемент', 200, CAST(N'2025-06-30' AS Date), 100, 3),
(8, N'Миротворец', 200, CAST(N'2024-10-27' AS Date), 100, 4),
(9, N'Странные земли', 200, CAST(N'2024-09-16' AS Date), 100, 5),
(10, N'Звездный поток', 200, CAST(N'2024-08-06' AS Date), 100, 6),
(11, N'Человек государства', 200, CAST(N'2024-06-26' AS Date), 100, 7),
(12, N'Бобер', 200, CAST(N'2025-04-09' AS Date), 100, 8),
(13, N'Егерь', 200, CAST(N'2025-02-27' AS Date), 100, 9),
(14, N'Крысиный бег', 200, CAST(N'2025-05-20' AS Date), 100, 10),
(15, N'Гего звали Тони', 200, CAST(N'2024-05-16' AS Date), 100, 1),
(16, N'Ювелиръ.1807', 200, CAST(N'2025-01-17' AS Date), 100, 2),
(17, N'Танцуя в огне', 200, CAST(N'2024-12-07' AS Date), 100, 3)

GO

SET IDENTITY_INSERT Книги OFF
GO
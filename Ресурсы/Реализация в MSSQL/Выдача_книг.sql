USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[Выдача книг]
GO

CREATE TABLE Выдача_книг(
	Id_читателя int NOT NULL FOREIGN KEY REFERENCES Читатели(Id),
	Id_книги int NOT NULL FOREIGN KEY REFERENCES Книги(Id),
	Количество int NOT NULL,
	Дата_выдачи date NOT NULL,
	Дата_предполагаемой_сдачи date NOT NULL,
	Дата_фактической_сдачи date,
	Штраф int,
	PRIMARY KEY (Id_читателя, Id_книги)
)
GO

INSERT INTO Выдача_книг (Id_читателя, Id_книги, Количество, Дата_выдачи, Дата_предполагаемой_сдачи, Дата_фактической_сдачи, Штраф) VALUES
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
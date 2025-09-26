USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[Список тем]
GO

CREATE TABLE Список_тем(
	Id_темы int NOT NULL FOREIGN KEY REFERENCES Темы(Id),
	Id_книги int NOT NULL FOREIGN KEY REFERENCES Книги(Id),
	PRIMARY KEY (Id_темы, Id_книги)
)
GO

INSERT INTO Список_тем (Id_темы, Id_книги) VALUES
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
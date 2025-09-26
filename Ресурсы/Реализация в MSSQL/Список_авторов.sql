USE [Library]
GO

DROP TABLE IF EXISTS [dbo].[Список авторов]
GO

CREATE TABLE Список_авторов(
	Id_автора int NOT NULL FOREIGN KEY REFERENCES Авторы(Id),
	Id_книги int NOT NULL FOREIGN KEY REFERENCES Книги(Id),
	PRIMARY KEY (Id_автора, Id_книги)
)
GO

INSERT INTO Список_авторов (Id_автора, Id_книги) VALUES
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
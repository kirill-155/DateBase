USE [Library]
GO

CREATE TABLE Авторы(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Псевдоним nvarchar(50),
	Фамилия nvarchar(50),
	Имя nvarchar(50),
	Отчество nvarchar(50)
);

CREATE TABLE Темы(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Название nvarchar(50) NOT NULL
);

CREATE TABLE Издательства(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Название nvarchar(50) NOT NULL
);

CREATE TABLE Группы(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Название nvarchar(50) NOT NULL
);

CREATE TABLE Читатели(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Фамилия nvarchar(50) NOT NULL,
	Имя nvarchar(50) NOT NULL,
	Отчество nvarchar(50),
	Задолженность money CHECK (Задолженность >= 0),
	Id_группы int NOT NULL FOREIGN KEY REFERENCES Группы(Id)
);

CREATE TABLE Книги(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Название nvarchar(50) NOT NULL,
	Цена money CHECK (Цена >= 0) NOT NULL,
	Год_издания date NOT NULL,
	Число_экземпляров int CHECK (Число_экземпляров >= 0) NOT NULL,
	Id_издательства int NOT NULL FOREIGN KEY REFERENCES Издательства(Id)
);

CREATE TABLE Список_тем(
	Id_темы int NOT NULL FOREIGN KEY REFERENCES Темы(Id),
	Id_книги int NOT NULL FOREIGN KEY REFERENCES Книги(Id),
	PRIMARY KEY (Id_темы, Id_книги)
);

CREATE TABLE Список_авторов(
	Id_автора int NOT NULL FOREIGN KEY REFERENCES Авторы(Id),
	Id_книги int NOT NULL FOREIGN KEY REFERENCES Книги(Id),
	PRIMARY KEY (Id_автора, Id_книги)
);

CREATE TABLE Выдача_книг(
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_читателя int NOT NULL FOREIGN KEY REFERENCES Читатели(Id),
	Id_книги int NOT NULL FOREIGN KEY REFERENCES Книги(Id),
	Количество int CHECK (Количество >= 0) NOT NULL,
	Дата_выдачи date NOT NULL,
	Дата_предполагаемой_сдачи date NOT NULL,
	Дата_фактической_сдачи date,
	Штраф money CHECK (Штраф >= 0)
);
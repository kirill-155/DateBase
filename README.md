<h1 name="content" align="center"><a href=""><img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/></a> MSSQL</h1>
<p align="center">
  <a href="#-lab1"><img alt="lab1" src="https://img.shields.io/badge/Lab1-blue"></a> 
  <a href="#-lab2"><img alt="lab2" src="https://img.shields.io/badge/Lab2-red"></a>
  <a href="#-lab3"><img alt="lab3" src="https://img.shields.io/badge/Lab3-green"></a>
  <a href="#-lab4"><img alt="lab4" src="https://img.shields.io/badge/Lab4-yellow"></a>
  <a href="#-lab5"><img alt="lab5" src="https://img.shields.io/badge/Lab5-gray"></a>
  <a href="#-lab6"><img alt="lab6" src="https://img.shields.io/badge/Lab6-orange"></a> 
  <a href="#-lab7"><img alt="lab7" src="https://img.shields.io/badge/Lab7-brown"></a>
  <a href="#-lab8"><img alt="lab8" src="https://img.shields.io/badge/Lab8-purple"></a>
  <a href="#-lab9"><img alt="lab9" src="https://img.shields.io/badge/Lab9-violet"></a> 
</p>

Вихарев Кирилл, ПМИ-32БО, вариант №1
<h2 align="center">Предметная область: Библиотека</h2>

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab1
[Назад](#content)
<h3>
  <a href="#client"></a>
  1.1 Разработать ER-модель данной предметной области
  <img alt="ERD" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/ERD.png">
  <p></p>
  1.2 По имеющейся ER-модели создать реляционную модель данных
  <img alt="Реляционная модель" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Реляционная%20модель.png">
</h3>


# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab2
[Назад](#content)
<h3>
  <a href="#client"></a>
  2 Создать реляционную БД на учебном сервере БД
</h3>

2.1 создать таблицы, определить первичные ключи и иные ограничения
```USE [Library]
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
```
2.2 создать диаграмму

<img alt="Реализация в MSSQL Диаграмма" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Реализация в MSSQL/Диаграмма.png">

2.3 заполнить все таблицы адекватной информацией
```
SET IDENTITY_INSERT Авторы ON
GO

INSERT INTO Авторы (Id, Псевдоним, Фамилия, Имя, Отчество) VALUES
(1, N'Ascold Flow', N'Мельник', N'Андрей', NULL),
(2, NULL, N'Крынов', N'Максим', NULL),
(3, NULL, N'Красавин', N'Никита', NULL),
(4, NULL, N'Сластин', N'Артем', NULL),
(5, NULL, N'Свиридов', N'Олег', NULL),
(6, NULL, N'Смирнов', N'Арсений', NULL),
(7, NULL, N'Тарасов', N'Ник', NULL),
(8, NULL, N'Жгулев', N'Петр', NULL),
(9, NULL, N'Рымин', N'Андрей', NULL),
(10, N'Морфиус', NULL, NULL, NULL),
(11, N'Грильяж', NULL, NULL, NULL)

GO

SET IDENTITY_INSERT Авторы OFF
GO
```
```
SET IDENTITY_INSERT Темы ON
GO

INSERT INTO Темы (Id, Название) VALUES
(1, N'Фэнтези'),
(2, N'Мистика'),
(3, N'Современная проза'),
(4, N'Фантастика'),
(5, N'Приключения'),
(6, N'Поэзия'),
(7, N'Юмор'),
(8, N'Фанфик'),
(9, N'Ужасы'),
(10, N'Попаданцы'),
(11, N'Триллер'),
(12, N'Боевик'),
(13, N'ЛитРПГ'),
(14, N'Подростковая проза'),
(15, N'Детектив'),
(16, N'Либовный роман'),
(17, N'РеалРПГ'),
(18, N'Историческая проза')

GO

SET IDENTITY_INSERT Темы OFF
GO
```
```
SET IDENTITY_INSERT Издательства ON
GO

INSERT INTO Издательства (Id, Название) VALUES
(1, N'Литрес: Самиздат'),
(2, N'Книга по Требованию'),
(3, N'Эксмо'),
(4, N'АCТ'),
(5, N'LAP LAMBERT Academic Publishing'),
(6, N'HarperCollins Publishers'),
(7, N'Просвещение'),
(8, N'Феникс'),
(9, N'ЛитРес: чтец'),
(10, N'Детская литература'),
(11, N'Юрайт'),
(12, N'Наука'),
(13, N'Художественная литература'),
(14, N'Проспект'),
(15, N'Вече'),
(16, N'Центрполиграф'),
(17, N'Рипол Классик'),
(18, N'КноРус'),
(19, N'Директ-Медиа'),
(20, N'Азбука'),
(21, N'Питер'),
(22, N'Penguin Books'),
(23, N'Дрофа'),
(24, N'Харвест')

GO

SET IDENTITY_INSERT Издательства OFF
GO
```
```
SET IDENTITY_INSERT Группы ON
GO

INSERT INTO Группы (Id, Название) VALUES
(1, N'ПМИ-32'),
(2, N'ПМИ-33'),
(3, N'ПМИ-31'),
(4, N'МКН-11'),
(5, N'МКН-21'),
(6, N'КБ-11'),
(7, N'ПМИ-22'),
(8, N'ПМИ-13'),
(9, N'МКН-31'),
(10, N'КБ-31')

GO

SET IDENTITY_INSERT Группы OFF
GO
```
```
SET IDENTITY_INSERT Читатели ON
GO

INSERT INTO Читатели (Id, Фамилия, Имя, Отчество, Задолженность, Id_группы) VALUES
(1, N'Вихарев', N'Кирилл', NULL, NULL, 1),
(15, N'Кудрявцев', N'Матвей', N'Владимирович', NULL, 1),
(16, N'Кудряшов', N'Никита', N'Романович', NULL, 1),
(17, N'Лопаткин', N'Даниил', N'Евгеньевич', NULL, 1),
(18, N'Мерзун', N'Иван', N'Романович', NULL, 1),
(19, N'Минаева', N'Ксения', N'Аркадьевна', NULL, 1),
(20, N'Немтинов', N'Никита', N'Сергеевич', NULL, 1),
(21, N'Петроченков', N'Михаил', N'Денисович', NULL, 1),
(22, N'Пляскин', N'Дмитрий', N'Ефимович', NULL, 1),
(23, N'Рахимова', N'Регина', N'Ильдаровна', NULL, 1),
(24, N'Рачинский', N'Михаил', N'Сергеевич', NULL, 1),
(25, N'Родин', N'Илья', N'Алексеевич', NULL, 1),
(26, N'Родионов', N'Никита', N'Алексеевич', NULL, 1),
(27, N'Семенов', N'Евгений', N'Николаевич', NULL, 1),
(44, N'Воронцов', N'Илья', N'Александрович', NULL, 3),
(45, N'Демидюк', N'Артем', N'Михайлович', NULL, 3),
(46, N'Державин', N'Владимир', N'Михайлович', NULL, 3),
(47, N'Дмитриев', N'Григорий', N'Сергеевич', NULL, 3),
(48, N'Довгань', N'Мария', N'Дмитриевна', NULL, 3),
(49, N'Жевакин', N'Кирилл', N'Александрович', NULL, 3),
(50, N'Зеленина', N'Юлия', N'Алексеевна', NULL, 3),
(51, N'Капустина', N'Елизавета', N'Юрьевна', NULL, 3),
(52, N'Корнева', N'Татьяна', N'Сергеевна', NULL, 3),
(53, N'Лаврентьева', N'Ксения', N'Дмитриевна', NULL, 3),
(54, N'Локтева', N'Ирина', N'Александровна', NULL, 3),
(55, N'Мартынов', N'Владислав', N'Юрьевич', NULL, 3),
(56, N'Медков', N'Александр', N'Николаевич', NULL, 3),
(57, N'Мешкова', N'Мария', N'Андреевна', NULL, 3),
(58, N'Невзорова', N'Ангелина', N'Романовна', NULL, 3),
(59, N'Никрашевич', N'Егор', N'Витальевич', NULL, 3),
(60, N'Базанова', N'Анастасия', N'Сергеевна', NULL, 2),
(61, N'Величко', N'Глеб', N'Сергеевич', NULL, 2),
(62, N'Голяков', N'Макар', N'Дмитриевич', NULL, 2),
(63, N'Грибанов', N'Никита', N'Романович', NULL, 2),
(64, N'Казакова', N'Анна', N'Игоревна', NULL, 2),
(65, N'Колодочка', N'Денис', N'Евгеньевич', NULL, 2),
(66, N'Кротов', N'Павел', N'Сергеевич', NULL, 2),
(67, N'Круглышев', N'Антон', N'Владимирович', NULL, 2),
(68, N'Лукоянов', N'Кирилл', N'Анатольевич', NULL, 2),
(69, N'Рубанов', N'Никита', N'Денисович', NULL, 2),
(70, N'Сафонов', N'Владислав', N'Дмитриевич', NULL, 2),
(71, N'Седов', N'Константин', N'Евгеньевич', NULL, 2),
(72, N'Сейферман', N'Владислав', N'Борисович', NULL, 2),
(73, N'Скидоненко', N'Ярослав', N'Дмитриевич', NULL, 2)

GO

SET IDENTITY_INSERT Читатели OFF
GO
```
```
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
```
```
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
```
```
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
```
```
SET IDENTITY_INSERT Выдача_книг ON
GO

INSERT INTO Выдача_книг (Id, Id_читателя, Id_книги, Количество, Дата_выдачи, Дата_предполагаемой_сдачи, Дата_фактической_сдачи, Штраф) VALUES
(1, 1, 2, 1, CAST(N'2025-10-10' AS Date), CAST(N'2025-10-11' AS Date), NULL, NULL),
(2, 15, 4, 1, CAST(N'2025-01-09' AS Date), CAST(N'2025-01-10' AS Date), NULL, NULL),
(3, 16, 7, 1, CAST(N'2025-09-09' AS Date), CAST(N'2025-10-09' AS Date), NULL, NULL),
(4, 23, 14, 1, CAST(N'2025-09-16' AS Date), CAST(N'2025-10-16' AS Date), NULL, NULL),
(5, 27, 9, 1, CAST(N'2025-09-11' AS Date), CAST(N'2025-10-11' AS Date), NULL, NULL),
(6, 44, 13, 1, CAST(N'2025-09-15' AS Date), CAST(N'2025-10-15' AS Date), NULL, NULL),
(7, 45, 8, 1, CAST(N'2025-09-10' AS Date), CAST(N'2025-10-10' AS Date), NULL, NULL),
(8, 45, 16, 1, CAST(N'2025-09-18' AS Date), CAST(N'2025-10-18' AS Date), NULL, NULL),
(9, 55, 15, 1, CAST(N'2025-09-17' AS Date), CAST(N'2025-10-17' AS Date), NULL, NULL),
(10, 59, 10, 1, CAST(N'2025-09-12' AS Date), CAST(N'2025-10-12' AS Date), NULL, NULL),
(11, 60, 11, 1, CAST(N'2025-09-13' AS Date), CAST(N'2025-10-13' AS Date), NULL, NULL),
(12, 73, 12, 1, CAST(N'2025-09-14' AS Date), CAST(N'2025-10-14' AS Date), NULL, NULL)

GO

SET IDENTITY_INSERT Выдача_книг OFF
GO
```
# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab3
[Назад](#content)
<h3>
  <a href="#client"></a>
  3
</h3>


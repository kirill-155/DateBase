--USE [Library]
USE [2025_PMI_32]
GO

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
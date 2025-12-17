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

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab1
[Назад](#content)
## Лабораторная №1
### Предметная область: Библиотека
Информация о книгах:

<ul> 
	<li>Шифр</li> 
	<li>Список авторов</li> 
	<li>Название</li> 
	<li>Издательство</li> 
	<li>Год издания</li> 
	<li>Цена</li> 
	<li>Число экземпляров</li> 
	<li>Тема</li> 
</ul>
Информация о читателях:

<ul> 
	<li>ФИО</li> 
	<li>Группа</li> 
	<li>Список взятых книг с указанием даты выдачи/сдачи</li> 
</ul>

### Задачи лабораторной работы:
<ol type="1"> 
	<li><strong>Разработать ER-модель предметной области:</strong> 
		<ol type="a"> 
			<li>Выделить сущности, их атрибуты, связи между сущностями</li> 
			<li>Для каждой сущности указать: 
				<ul> 
					<li>Имя сущности</li> 
					<li>Атрибут (или набор атрибутов), являющийся первичным ключом</li> 
					<li>Список остальных атрибутов</li> 
				</ul> 
			</li>
			<li>Для каждого атрибута указать: 
				<ul> 
					<li>Тип атрибута</li> 
					<li>Ограничения</li> 
					<li>Может ли быть пустым (NULL)</li> 
					<li>Является ли первичным ключом</li> 
				</ul> 
			</li> 
			<li>Для каждой связи между сущностями указать: 
				<ul> 
					<li>Тип связи (1:1, 1:M, M:N)</li> 
					<li>Обязательность связи</li> 
				</ul> 
			</li> 
		</ol> 
	</li> 
	<li><strong>Создать реляционную модель данных на основе ER-модели:</strong> 
		<ol type="a"> 
			<li>Представить модель в виде списка сущностей с их атрибутами и типами атрибутов</li> 
			<li>Для атрибутов указать, является ли он первичным или внешним ключом</li> 
		</ol> 
	</li> 
</ol>

### Результаты выполнения:
<ol type="1"> 
	<li><details><summary><strong>Разработать ER-модель данной предметной области</strong></summary><img alt="ERD" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/ERD.png"></details></li>
	<li><details><summary><strong>По имеющейся ER-модели создать реляционную модель данных</strong></summary><img alt="Реляционная модель" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Реляционная%20модель.png"></details></li>
</ol>

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab2
[Назад](#content)
## Лабораторная №2
### В соответствии с реляционной моделью данных, разработанной в Лаб.№1, создать реляционную БД на учебном сервере БД:

Создать реляционную БД на учебном сервере БД
<ol type="1"> 
	<li>
		<details>
			<summary>Создать таблицы, определить первичные ключи и иные ограничения (Код)</summary> 
<pre><code>USE [Library]
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
);</code></pre>
	</details>
	</li>
	<li><strong></strong> 
		<details>
			<summary>Создать диаграмму</summary> 
			<img alt="Реализация в MSSQL Диаграмма" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Реализация в MSSQL/Диаграмма.png">
		</details>
	</li>
	<li><strong></strong> 
		<details>
			<summary>Заполнить все таблицы адекватной информацией (не меньше 10 записей в таблицах, наличие примеров для связей типа 1:M )</summary> 
<pre><code>SET IDENTITY_INSERT Авторы ON
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
GO</code></pre>
<pre><code>SET IDENTITY_INSERT Темы ON
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
GO</code></pre>
<pre><code>SET IDENTITY_INSERT Издательства ON
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
GO</code></pre>
<pre><code>SET IDENTITY_INSERT Группы ON
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
GO</code></pre>
<pre><code>SET IDENTITY_INSERT Читатели ON
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
GO</code></pre>
<pre><code>INSERT INTO Список_тем (Id_темы, Id_книги) VALUES
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

GO</code></pre>
<pre><code>INSERT INTO Список_авторов (Id_автора, Id_книги) VALUES
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

GO</code></pre>
<pre><code>SET IDENTITY_INSERT Книги ON
GO

INSERT INTO Книги (Id, Название, Цена, Год_издания, Число_экземпляров, Id_издательства) VALUES
(2, N'Бескрайний архипелаг', 10000.0000, CAST(N'2025-09-20' AS Date), 10, 1),
(4, N'Город, которого нет', 200.0000, CAST(N'2025-08-10' AS Date), 100, 2),
(7, N'Неучтенный элемент', 200.0000, CAST(N'2025-06-30' AS Date), 20, 3),
(8, N'Миротворец', 200.0000, CAST(N'2024-10-27' AS Date), 100, 4),
(9, N'Странные земли', 400.0000, CAST(N'2024-09-16' AS Date), 33, 5),
(10, N'Звездный поток', 200.0000, CAST(N'2024-08-06' AS Date), 100, 6),
(11, N'Человек государства', 150.0000, CAST(N'2024-06-26' AS Date), 100, 7),
(12, N'Бобер', 200.0000, CAST(N'2025-04-09' AS Date), 40, 8),
(13, N'Егерь', 199.0000, CAST(N'2025-02-27' AS Date), 100, 9),
(14, N'Крысиный бег', 200.0000, CAST(N'2025-05-20' AS Date), 38, 10),
(15, N'Гего звали Тони', 300.0000, CAST(N'2024-05-16' AS Date), 100, 1),
(16, N'Ювелиръ.1807', 200.0000, CAST(N'2025-01-17' AS Date), 60, 2),
(17, N'Танцуя в огне', 200.0000, CAST(N'2024-12-07' AS Date), 400, 3)

GO

SET IDENTITY_INSERT Книги OFF
GO</code></pre>
<pre><code>SET IDENTITY_INSERT Выдача_книг ON
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
GO</code></pre>
		</details>
	</li>
</ol>

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab3
[Назад](#content)
## Лабораторная №3

### Часть 1

**Цель:** изучить конструкции языка SQL для манипулирования данными в СУБД MSSQL.

**Задания и краткое описание работы:**

<ol type="1">
  <li><strong>Выборка из одной таблицы</strong>
    <ol type="1">
      <li>Выбрать из произвольной таблицы данные и отсортировать их по двум произвольным имеющимся в таблице признакам (разные направления сортировки).</li>
      <li>Выбрать из произвольной таблицы те записи, которые удовлетворяют условию отбора (<code>WHERE</code>). Привести 2-3 запроса.</li>
      <li>Привести примеры 2-3 запросов с использованием агрегатных функций (<code>COUNT</code>, <code>MAX</code>, <code>SUM</code> и др.) с группировкой и без группировки.</li>
      <li>Привести примеры подведения подытога с использованием <code>GROUP BY [ALL] [ CUBE | ROLLUP]</code> (2-3 запроса). В <code>ROLLUP</code> и <code>CUBE</code> использовать не менее 2-х столбцов.</li>
      <li>Выбрать из таблиц информацию об объектах, в названиях которых нет заданной последовательности букв (<code>LIKE</code>).</li>
    </ol>
  </li>
  <li><strong>Выборка из нескольких таблиц</strong>
    <ol type="1">
      <li>Вывести информацию подчиненной (дочерней) таблицы, заменяя коды (значения внешних ключей) соответствующими символьными значениями из родительских таблиц. Привести 2-3 запроса с использованием классического подхода соединения таблиц (<code>WHERE</code>).</li>
      <li>Реализовать запросы пункта 2.1 через внутреннее соединение <code>INNER JOIN</code>.</li>
      <li>Левое внешнее соединение <code>LEFT JOIN</code>. Привести 2-3 запроса.</li>
      <li>Правое внешнее соединение <code>RIGHT JOIN</code>. Привести 2-3 запроса.</li>
      <li>Привести примеры 2-3 запросов с использованием агрегатных функций и группировки.</li>
      <li>Привести примеры 2-3 запросов с использованием группировки и условия отбора групп (<code>HAVING</code>).</li>
      <li>Привести примеры 3-4 вложенных (соотнесенных, c использованием <code>IN</code>, <code>EXISTS</code>) запросов.</li>
    </ol>
  </li>
  <li><strong>Представления</strong>
    <ol type="1">
      <li>На основе любых запросов из п. 2 создать два представления (<code>VIEW</code>).</li>
      <li>Привести примеры использования общетабличных выражений (СТЕ) (2-3 запроса).</li>
    </ol>
  </li>
  <li><strong>Функции ранжирования</strong>
    <ol type="1">
      <li>Привести примеры 3-4 запросов с использованием <code>ROW_NUMBER</code>, <code>RANK</code>, <code>DENSE_RANK</code> (c <code>PARTITION BY</code> и без).</li>
    </ol>
  </li>
  <li><strong>Объединение, пересечение, разность</strong>
    <ol type="1">
      <li>Привести примеры 3-4 запросов с использованием <code>UNION</code> / <code>UNION ALL</code>, <code>EXCEPT</code>, <code>INTERSECT</code>. Данные в одном из запросов отсортируйте по произвольному признаку.</li>
    </ol>
  </li>
  <li><strong>Использование CASE, PIVOT и UNPIVOT</strong>
    <ol type="1">
      <li>Привести примеры получения сводных (итоговых) таблиц с использованием <code>CASE</code>.</li>
      <li>Привести примеры получения сводных (итоговых) таблиц с использованием <code>PIVOT</code> и <code>UNPIVOT</code>.</li>
    </ol>
  </li>
</ol>

<blockquote>
  <p><strong>Обязательными к выполнению являются запросы, приведенные ниже (смотри свой вариант).</strong></p>
  <p><strong>Отчет по лабораторной работе предоставляется в виде документа (Фамилия_Группа.docx).</strong></p>
  <p>В этом документе по каждому заданию необходимо представить: условие запроса, текст SQL-запроса, скрин-копию результата выполнения запроса.</p>
</blockquote>

### Часть 2

Составить следующие запросы:

<ol type="a">
  <li>Найти самые популярные издания</li>
  <li>Найти темы, по которым все экземпляры книг находятся на руках</li>
  <li>Составить список книг по указанной теме</li>
  <li>Составить список должников, у которых срок долга > 1 месяца (ФИО, шифр, автор, название, дата сдачи), отсортировать по убыванию срока долга (т.е., в начале – самые злостные должники)</li>
  <li>Для каждой учебной группы выдать количество книг, взятых с начала текущего года, количество должников</li>
</ol>

<h3>
  <a href="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Лабораторная%203.docx" target="_blank">Запросы лабораторной 3</a>
</h3>

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab4
[Назад](#content)

## Лабораторная №4
### Хранимые процедуры
Создать 4 различных хранимых процедуры:

<ol type="a"> 
	<li>
		<details>
			<summary><strong>Процедура без параметров</strong>, возвращающая список должников по годам</summary> 
<pre><code>CREATE PROCEDURE ДолжникиПоГодам
AS
BEGIN
    SELECT 
        YEAR(VK.Дата_предполагаемой_сдачи) AS Год,
        COUNT(DISTINCT VK.Id_читателя) AS Количество_должников,
        STRING_AGG(CONCAT(H.Фамилия, ' ', H.Имя), ', ') WITHIN GROUP (ORDER BY H.Фамилия) AS Должники
    FROM 
        Выдача_книг VK
        JOIN Читатели H ON VK.Id_читателя = H.Id
    WHERE 
        VK.Дата_фактической_сдачи IS NULL
        AND VK.Дата_предполагаемой_сдачи < GETDATE()
    GROUP BY 
        YEAR(VK.Дата_предполагаемой_сдачи)
    ORDER BY 
        Год DESC
END</code></pre>
		</details>
	</li> 
	<li>
		<details>
			<summary><strong>Процедура</strong>, на входе получающая шифр книги и формирующая список читателей, у кого эта книга на руках (отдельно - должники)</summary> 
<pre><code>CREATE PROCEDURE ЧитателиКниги
    @Id_книги INT
AS
BEGIN
    SELECT 
        H.Id,
        H.Фамилия,
        H.Имя,
        H.Отчество,
        G.Название AS Группа,
        VK.Дата_выдачи,
        VK.Дата_предполагаемой_сдачи,
        CASE 
            WHEN VK.Дата_предполагаемой_сдачи < GETDATE() AND VK.Дата_фактической_сдачи IS NULL 
            THEN 'Должник'
            ELSE 'Не должник'
        END AS Статус
    FROM 
        Выдача_книг VK
        JOIN Читатели H ON VK.Id_читателя = H.Id
        JOIN Группы G ON H.Id_группы = G.Id
    WHERE 
        VK.Id_книги = @Id_книги
        AND VK.Дата_фактической_сдачи IS NULL
    SELECT 
        H.Id,
        H.Фамилия,
        H.Имя,
        H.Отчество,
        G.Название AS Группа,
        VK.Дата_выдачи,
        VK.Дата_предполагаемой_сдачи,
        DATEDIFF(DAY, VK.Дата_предполагаемой_сдачи, GETDATE()) AS Дней_просрочки
    FROM 
        Выдача_книг VK
        JOIN Читатели H ON VK.Id_читателя = H.Id
        JOIN Группы G ON H.Id_группы = G.Id
    WHERE 
        VK.Id_книги = @Id_книги
        AND VK.Дата_фактической_сдачи IS NULL
        AND VK.Дата_предполагаемой_сдачи < GETDATE()
END</code></pre>
		</details>
	</li> 
	<li>
		<details>
			<summary><strong>Процедура</strong>, получающая дату как входной параметр, выходной параметр – фамилия читателя, взявшего наибольшее количество книг в этот день</summary> 
<pre><code>CREATE PROCEDURE ЧитательМаксКнигЗаДень
    @Дата DATE,
    @Фамилия_читателя NVARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1
        @Фамилия_читателя = H.Фамилия
    FROM 
        Выдача_книг VK
        JOIN Читатели H ON VK.Id_читателя = H.Id
    WHERE 
        CONVERT(DATE, VK.Дата_выдачи) = @Дата
    GROUP BY 
        H.Id, H.Фамилия
    ORDER BY 
        SUM(VK.Количество) DESC
END</code></pre></details>
</li>
	<li>
		<details>
			<summary><strong>Процедура</strong>, которая ищет день с наибольшим количеством взятых книг и выдает фамилию читателя, взявшего наибольшее количество книг в этот день (с использованием вызова предыдущей процедуры)</summary> 
<pre><code>CREATE PROCEDURE ДеньМаксКнигИЧитатель
AS
BEGIN
    DECLARE @Дата_макс DATE
    DECLARE @Фамилия NVARCHAR(50)
    SELECT TOP 1
        @Дата_макс = VK.Дата_выдачи
    FROM 
        Выдача_книг VK
    GROUP BY 
        VK.Дата_выдачи
    ORDER BY 
        SUM(VK.Количество) DESC
    EXEC ЧитательМаксКнигЗаДень 
        @Дата = @Дата_макс,
        @Фамилия_читателя = @Фамилия OUTPUT
    SELECT 
        @Дата_макс AS Дата_максимальной_выдачи,
        @Фамилия AS Фамилия_читателя,
        (SELECT SUM(Количество) 
         FROM Выдача_книг 
         WHERE Дата_выдачи = @Дата_макс) AS Всего_книг_взято
END</code></pre></details>
</li>
</ol>

### Пользовательские функции
Создать 3 пользовательских функции:

<ol type="a"> 
	<li>
		<details>
			<summary><strong>Скалярная функция</strong>, возвращающая рейтинг книги с заданным шифром</summary> 
<pre><code>CREATE OR ALTER FUNCTION РейтингКниги(@Id_книги INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @Рейтинг DECIMAL(5,2)
    -- Рейтинг = (количество выдач книги / количество выдач всех книг) / наивысшее значение отношения количества выдач книги к количеству выдач всех книг * 100
    SELECT @Рейтинг = 
        CASE 
            WHEN К.Число_экземпляров > 0 
            THEN (CAST(COUNT(VK.Id) AS DECIMAL(10,2)) / (SELECT COUNT(Id) FROM Выдача_книг))
                / (SELECT TOP 1 
                    CAST(COUNT(VK.Id) AS DECIMAL(10,2)) / (SELECT COUNT(Id) FROM Выдача_книг) AS CNT 
                FROM 
                    Книги К
                    LEFT JOIN Выдача_книг VK ON К.Id = VK.Id_книги
                GROUP BY 
                    К.Id
                ORDER BY CNT DESC) * 100
            ELSE 0
        END
    FROM 
        Книги К
        LEFT JOIN Выдача_книг VK ON К.Id = VK.Id_книги
    WHERE 
        К.Id = @Id_книги
    GROUP BY 
        К.Id, К.Число_экземпляров
    RETURN ISNULL(@Рейтинг, 0)
END</code></pre>
		</details>
	</li> 
	<li>
		<details>
			<summary><strong>Inline-функция</strong>, возвращающая список литературы по заданным разделу, теме и автору</summary> 
<pre><code>CREATE FUNCTION СписокЛитературы
(
    @Id_темы INT = NULL,
    @Id_автора INT = NULL
)
RETURNS TABLE
AS
RETURN
    SELECT DISTINCT
        К.Id,
        К.Название,
        К.Цена,
        К.Год_издания,
        I.Название AS Издательство,
        CASE 
            WHEN A.Псевдоним IS NOT NULL THEN A.Псевдоним
            ELSE CONCAT(A.Фамилия, ' ', LEFT(A.Имя, 1), '.', 
                   CASE WHEN A.Отчество IS NOT NULL THEN LEFT(A.Отчество, 1) + '.' ELSE '' END)
        END AS Автор,
        Т.Название AS Тема
    FROM 
        Книги К
        JOIN Издательства I ON К.Id_издательства = I.Id
        LEFT JOIN Список_авторов SA ON К.Id = SA.Id_книги
        LEFT JOIN Авторы А ON SA.Id_автора = A.Id
        LEFT JOIN Список_тем ST ON К.Id = ST.Id_книги
        LEFT JOIN Темы Т ON ST.Id_темы = Т.Id
    WHERE 
        (@Id_темы IS NULL OR ST.Id_темы = @Id_темы)
        AND (@Id_автора IS NULL OR SA.Id_автора = @Id_автора)
GO</code></pre></details>
</li> 
	<li>
		<details>
			<summary><strong>Multi-statement-функция</strong>, возвращающая список должников по группам с упорядочением по количеству несданных вовремя книг</summary> 
<pre><code>CREATE FUNCTION ДолжникиПоГруппам()
RETURNS @Должники TABLE
(
    Id_группы INT,
    Название_группы NVARCHAR(50),
    Id_читателя INT,
    Фамилия NVARCHAR(50),
    Имя NVARCHAR(50),
    Количество_несданных_книг INT,
    Общая_просрочка_дней INT
)
AS
BEGIN
    INSERT INTO @Должники
    SELECT 
        G.Id,
        G.Название,
        H.Id,
        H.Фамилия,
        H.Имя,
        COUNT(VK.Id) AS Количество_несданных_книг,
        SUM(DATEDIFF(DAY, VK.Дата_предполагаемой_сдачи, GETDATE())) AS Общая_просрочка_дней
    FROM 
        Выдача_книг VK
        JOIN Читатели H ON VK.Id_читателя = H.Id
        JOIN Группы G ON H.Id_группы = G.Id
    WHERE 
        VK.Дата_фактической_сдачи IS NULL
        AND VK.Дата_предполагаемой_сдачи < GETDATE()
    GROUP BY 
        G.Id, G.Название, H.Id, H.Фамилия, H.Имя
    ORDER BY 
        Количество_несданных_книг DESC,
        Общая_просрочка_дней DESC
    RETURN
END</code></pre></details>
</li> 
</ol>

### Триггеры
Создать 3 триггера:

<ol type="a"> 
	<li>
		<details>
			<summary><strong>Триггер любого типа</strong> на добавление новой книги к списку взятых книг – если читатель является должником, то книга не добавляется (т.е., не выдается этому читателю)</summary> 
<pre><code>CREATE OR ALTER TRIGGER ПроверкаДолжникаНаВыдачу
ON Выдача_книг
INSTEAD OF INSERT
AS
BEGIN 
    IF EXISTS (-- является ли читатель должником
        SELECT 1 
        FROM Читатели H
        JOIN inserted I ON H.Id = I.Id_читателя
        WHERE Задолженность > 0
    ) OR EXISTS (-- есть ли у читателя просроченные книги
        SELECT 1 
        FROM Выдача_книг VK
        JOIN inserted I ON VK.Id_читателя = I.Id_читателя
        WHERE VK.Дата_фактической_сдачи IS NULL
        AND VK.Дата_предполагаемой_сдачи < GETDATE()
    )
    BEGIN
        DECLARE @Должники TABLE (
            Id_читателя INT,
            Причина NVARCHAR(100)
        );
        INSERT INTO @Должники
        SELECT DISTINCT
            I.Id_читателя,
            CASE 
                WHEN H.Задолженность > 0 THEN 'Имеет задолженность'
                ELSE 'Имеет просроченные книги'
            END
        FROM inserted I
        JOIN Читатели H ON I.Id_читателя = H.Id
        WHERE H.Задолженность > 0 
            OR EXISTS (
                SELECT 1 
                FROM Выдача_книг VK
                WHERE VK.Id_читателя = I.Id_читателя
                AND VK.Дата_фактической_сдачи IS NULL
                AND VK.Дата_предполагаемой_сдачи < GETDATE()
            );
        DECLARE @Сообщение NVARCHAR(MAX) = 'Книги не выданы' + CHAR(13) + CHAR(10);
        SELECT @Сообщение = @Сообщение + 
            'Читатель ID ' + CAST(D.Id_читателя AS NVARCHAR) + ': ' + D.Причина + CHAR(13) + CHAR(10)
        FROM @Должники D;
        RAISERROR(@Сообщение, 16, 1);
        RETURN;
    END
    INSERT INTO Выдача_книг 
    (Id_читателя, Id_книги, Количество, Дата_выдачи, 
     Дата_предполагаемой_сдачи, Дата_фактической_сдачи, Штраф)
    SELECT 
        Id_читателя,
        Id_книги,
        Количество,
        Дата_выдачи,
        Дата_предполагаемой_сдачи,
        Дата_фактической_сдачи,
        Штраф
    FROM inserted;
END
GO</code></pre>
		</details>
	</li> 
	<li>
		<details>
			<summary><strong>Последующий триггер</strong> на изменение информации о книге, который следит за изменением шифра: если была попытка изменить шифр книги, то такое изменение отменяется</summary> 
<pre><code>CREATE TRIGGER ЗапретИзмененияШифраКниги
ON Книги
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Id)
    BEGIN
        RAISERROR('Изменение шифра (Id) книги запрещено!', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO</code></pre></details>
</li> 
	<li>
		<details>
			<summary><strong>Замещающий триггер</strong> на операцию удаления читателя – если у него на руках находятся несданные книги, то выдается соответствующее сообщение, и читатель не удаляется</summary> 
<pre><code>CREATE OR ALTER TRIGGER ПроверкаКнигПередУдалениемЧитателя
ON Читатели
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @ЧитателиСКнигами TABLE (
        Id_читателя INT,
        Фамилия NVARCHAR(50),
        Имя NVARCHAR(50),
        КоличествоНесданныхКниг INT,
        СписокКниг NVARCHAR(MAX)
    );
    INSERT INTO @ЧитателиСКнигами
    SELECT 
        D.Id,
        D.Фамилия,
        D.Имя,
        COUNT(VK.Id) AS КоличествоНесданныхКниг,
        STRING_AGG(K.Название, ', ') WITHIN GROUP (ORDER BY K.Название) AS СписокКниг
    FROM deleted D
    LEFT JOIN Выдача_книг VK ON D.Id = VK.Id_читателя
    LEFT JOIN Книги K ON VK.Id_книги = K.Id
    WHERE VK.Дата_фактической_сдачи IS NULL
    GROUP BY D.Id, D.Фамилия, D.Имя
    HAVING COUNT(VK.Id) > 0;
    IF EXISTS (SELECT 1 FROM @ЧитателиСКнигами)
    BEGIN
        DECLARE @Сообщение NVARCHAR(MAX) = 'Не удалось удалить следующих читателей:' + CHAR(13) + CHAR(10);
        SELECT @Сообщение = @Сообщение + 
            'Читатель: ' + Фамилия + ' ' + Имя + 
            ' (ID: ' + CAST(Id_читателя AS NVARCHAR) + ')' +
            ', Несданных книг: ' + CAST(КоличествоНесданныхКниг AS NVARCHAR) +
            ISNULL(', Книги: ' + СписокКниг, '') + CHAR(13) + CHAR(10)
        FROM @ЧитателиСКнигами;
        SET @Сообщение = @Сообщение + 'Удаление невозможно.';
        RAISERROR(@Сообщение, 16, 1);
    END
    DECLARE @УдаляемыеЧитатели TABLE (Id INT);
    INSERT INTO @УдаляемыеЧитатели
    SELECT D.Id
    FROM deleted D
    WHERE NOT EXISTS (
        SELECT 1 
        FROM @ЧитателиСКнигами C 
        WHERE C.Id_читателя = D.Id
    );
    DELETE FROM Выдача_книг 
    WHERE Id_читателя IN (SELECT Id FROM @УдаляемыеЧитатели);
    DELETE FROM Читатели 
    WHERE Id IN (SELECT Id FROM @УдаляемыеЧитатели);
    DECLARE @Удалено INT;
    SELECT @Удалено = COUNT(*) FROM @УдаляемыеЧитатели;
    IF @Удалено > 0
    BEGIN
        PRINT 'Успешно удалено: ' + CAST(@Удалено AS NVARCHAR);
    END
END
GO</code></pre></details>
</li> 
</ol>
<blockquote> 
	<p><strong>Обязательно предусмотреть обработку НЕСКОЛЬКИХ записей!</strong> (там, где необходимо, использовать КУРСОР!)</p> 
</blockquote>

<h3>
  <a href="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Лабораторная%204.docx" target="_blank">Запросы лабораторной 4 (со скринами)</a>
</h3>

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab5
[Назад](#content)

## Лабораторная №5

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab6
[Назад](#content)

## Лабораторная №6
### Создание графовых таблиц и работа с ними.
Используйте реляционную БД из лабораторной работы №2.
Продумайте и создайте графовые таблицы по реляционной БД, заполните графовые таблицы используя данные в реляционных таблицах.
Напишите запросы из задания 3.2 используя паттерн <code>MATCH</code>.
Сравните полученные результаты  с  результатами запросов к реляционной модели. 

Отчет предоставить в виде:
<ol type="1"> 
	<li>
		<details>
			<summary>Схема узлов и ребер</summary><img alt="Схема узлов и ребер" src="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Схема узлов и ребер.png">
		</details>
	</li>
	<li>
		<details>
			<summary>Скрипт для создания и заполнения графовых таблиц</summary> 
<pre><code>USE [Library]
GO
--
CREATE TABLE Авторы_Node(
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Псевдоним nvarchar(50),
    Фамилия nvarchar(50),
    Имя nvarchar(50),
    Отчество nvarchar(50)
) AS NODE;
--
CREATE TABLE Темы_Node(
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Название nvarchar(50) NOT NULL
) AS NODE;
--
CREATE TABLE Издательства_Node(
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Название nvarchar(50) NOT NULL
) AS NODE;
--
CREATE TABLE Группы_Node(
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Название nvarchar(50) NOT NULL
) AS NODE;
--
CREATE TABLE Читатели_Node(
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Фамилия nvarchar(50) NOT NULL,
    Имя nvarchar(50) NOT NULL,
    Отчество nvarchar(50),
    Задолженность money CHECK (Задолженность >= 0)
) AS NODE;
--
CREATE TABLE Книги_Node(
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Название nvarchar(50) NOT NULL,
    Цена money CHECK (Цена >= 0) NOT NULL,
    Год_издания date NOT NULL,
    Число_экземпляров int CHECK (Число_экземпляров >= 0) NOT NULL
) AS NODE;
--
CREATE TABLE Книга_Тема_Edge AS EDGE;
CREATE TABLE Книга_Автор_Edge AS EDGE;
CREATE TABLE Выдача_Книги_Edge (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Количество int CHECK (Количество >= 0) NOT NULL,
    Дата_выдачи date NOT NULL,
    Дата_предполагаемой_сдачи date NOT NULL,
    Дата_фактической_сдачи date,
    Штраф money CHECK (Штраф >= 0)
) AS EDGE;
CREATE TABLE Читатель_в_Группе_Edge AS EDGE;
CREATE TABLE Книга_Издательство_Edge AS EDGE;
--Заполнение вершин
SET IDENTITY_INSERT Авторы_Node ON
GO
INSERT INTO Авторы_Node (Id, Псевдоним, Фамилия, Имя, Отчество)
SELECT Id, Псевдоним, Фамилия, Имя, Отчество FROM [Library].dbo.Авторы;
SET IDENTITY_INSERT Авторы_Node OFF
GO
--
SET IDENTITY_INSERT Издательства_Node ON
GO
INSERT INTO Издательства_Node (Id, Название)
SELECT Id, Название FROM [Library].dbo.Издательства;
SET IDENTITY_INSERT Издательства_Node OFF
GO
--
SET IDENTITY_INSERT Книги_Node ON
GO
INSERT INTO Книги_Node (Id, Название, Цена, Год_издания, Число_экземпляров)
SELECT Id, Название, Цена, Год_издания, Число_экземпляров FROM [Library].dbo.Книги;
SET IDENTITY_INSERT Книги_Node OFF
GO
--
SET IDENTITY_INSERT Темы_Node ON
GO
INSERT INTO Темы_Node (Id, Название)
SELECT Id, Название FROM [Library].dbo.Темы;
SET IDENTITY_INSERT Темы_Node OFF
GO
--
SET IDENTITY_INSERT Группы_Node ON
GO
INSERT INTO Группы_Node (Id, Название)
SELECT Id, Название FROM [Library].dbo.Группы;
SET IDENTITY_INSERT Группы_Node OFF
GO
--
SET IDENTITY_INSERT Читатели_Node ON
GO
INSERT INTO Читатели_Node (Id, Фамилия, Имя, Отчество, Задолженность)
SELECT Id, Фамилия, Имя, Отчество, Задолженность FROM [Library].dbo.Читатели;
SET IDENTITY_INSERT Читатели_Node OFF
GO
--Заполнение рёбер
INSERT INTO Книга_Тема_Edge ($from_id, $to_id)
SELECT 
    (SELECT $node_id FROM Книги_Node WHERE Id = st.Id_книги),
    (SELECT $node_id FROM Темы_Node WHERE Id = st.Id_темы)
FROM [Library].dbo.Список_тем AS st;
--
INSERT INTO Книга_Автор_Edge ($from_id, $to_id)
SELECT 
    (SELECT $node_id FROM Книги_Node WHERE Id = sa.Id_книги),
    (SELECT $node_id FROM Авторы_Node WHERE Id = sa.Id_автора)
FROM [Library].dbo.Список_авторов AS sa;
--
INSERT INTO Книга_Издательство_Edge ($from_id, $to_id)
SELECT 
    (SELECT $node_id FROM Книги_Node WHERE Id = k.Id),
    (SELECT $node_id FROM Издательства_Node WHERE Id = k.Id_издательства)
FROM [Library].dbo.Книги AS k;
--
INSERT INTO Читатель_в_Группе_Edge ($from_id, $to_id)
SELECT 
    (SELECT $node_id FROM Читатели_Node WHERE Id = c.Id),
    (SELECT $node_id FROM Группы_Node WHERE Id = c.Id_группы)
FROM [Library].dbo.Читатели AS c;
--
SET IDENTITY_INSERT Выдача_Книги_Edge ON
GO
INSERT INTO Выдача_Книги_Edge ($from_id, $to_id, Id, Количество, Дата_выдачи, Дата_предполагаемой_сдачи, Дата_фактической_сдачи, Штраф)
SELECT 
    (SELECT $node_id FROM Читатели_Node WHERE Id = vk.Id_читателя),
    (SELECT $node_id FROM Книги_Node WHERE Id = vk.Id_книги),
    vk.Id,
    vk.Количество,
    vk.Дата_выдачи,
    vk.Дата_предполагаемой_сдачи,
    vk.Дата_фактической_сдачи,
    vk.Штраф
FROM [Library].dbo.Выдача_книг AS vk;
SET IDENTITY_INSERT Выдача_Книги_Edge OFF
GO</code></pre>
		</details>
	</li>
	<li>
		<details>
			<summary>Запросы из задания 3.2 к двум моделям(реляционная, графовая.)</summary> 
			<ol type="a">
				<li>Найти самые популярные издания
<pre><code>SELECT TOP 10 WITH TIES
    kn.Название AS Книга,
    iz.Название AS Издательство,
    COUNT(vk.Id) AS Количество_выдач,
    SUM(vk.Количество) AS Всего_экземпляров_выдано
FROM 
    Книги_Node kn,
    Издательства_Node iz,
    Книга_Издательство_Edge ki,
    Выдача_Книги_Edge vk,
    Читатели_Node h
WHERE 
    MATCH(kn-(ki)->iz AND kn<-(vk)-h)
GROUP BY 
    kn.Id, kn.Название, iz.Название
ORDER BY 
    Всего_экземпляров_выдано DESC, Количество_выдач DESC;</code></pre>
				</li>
				<li>Найти темы, по которым все экземпляры книг находятся на руках
<pre><code>SELECT DISTINCT
    t.Название
FROM 
    Темы_Node t,
    Книги_Node k,
    Книга_Тема_Edge kt
WHERE 
    MATCH(t<-(kt)-k)
    AND EXISTS (
        SELECT 1
        FROM (
            SELECT 
                k2.Id,
                k2.Число_экземпляров,
                ISNULL(SUM(vk2.Количество), 0) AS Всего_выдано
            FROM 
                Книги_Node k2
            LEFT JOIN 
                Выдача_Книги_Edge vk2 ON vk2.$to_id = k2.$node_id AND vk2.Дата_фактической_сдачи IS NULL
            WHERE 
                k2.Id = k.Id
            GROUP BY 
                k2.Id, k2.Число_экземпляров
            HAVING 
                ISNULL(SUM(vk2.Количество), 0) = k2.Число_экземпляров
        ) AS subq
    );</code></pre>
				</li>
				<li>Составить список книг по указанной теме
<pre><code>SELECT DISTINCT
    kn.Название
FROM 
    Темы_Node t,
    Книги_Node kn,
    Книга_Тема_Edge kt
WHERE 
    t.Название LIKE 'Детектив' AND
    MATCH(t<-(kt)-kn);</code></pre>
				</li>
				<li>Составить список должников, у которых срок долга > 1 месяца (ФИО, шифр, автор, название, дата сдачи), отсортировать по убыванию срока долга (т.е., в начале – самые злостные должники)
<pre><code>SELECT 
    h.Id,
    CONCAT(h.Фамилия, ' ', h.Имя, ' ', ISNULL(h.Отчество, '')) AS ФИО,
    STRING_AGG(CONCAT(a.Фамилия, ' ', a.Имя, ' ', ISNULL(a.Отчество, '')), ', ') AS Автор,
    kn.Название,
    vk.Дата_предполагаемой_сдачи
FROM 
    Авторы_Node a,
    Книги_Node kn,
    Читатели_Node h,
    Книга_Автор_Edge ka,
    Выдача_Книги_Edge vk
WHERE 
    MATCH(a<-(ka)-kn<-(vk)-h) AND
    vk.Дата_фактической_сдачи IS NULL AND
    DATEDIFF(MONTH, vk.Дата_предполагаемой_сдачи, GETDATE()) > 1
GROUP BY 
    h.Id, h.Фамилия, h.Имя, h.Отчество, kn.Название, vk.Дата_предполагаемой_сдачи
ORDER BY 
    DATEDIFF(DAY, vk.Дата_предполагаемой_сдачи, GETDATE()) DESC;</code></pre>
				</li>
				<li>Для каждой учебной группы выдать количество книг, взятых с начала текущего года, количество должников
<pre><code>SELECT 
    g.Название,
    ISNULL(SUM(vk.Количество), 0) + ISNULL(SUM(s.Количество_книг), 0) AS Количество_книг,
    ISNULL(COUNT(DISTINCT CASE WHEN vk.Дата_фактической_сдачи IS NULL AND vk.Дата_предполагаемой_сдачи < GETDATE() THEN h.Id END) + SUM(s.Количество_должников), 0) AS Количество_должников
FROM 
    Группы_Node g
LEFT JOIN 
    Читатель_в_Группе_Edge cg ON cg.$from_id = g.$node_id
LEFT JOIN 
    Читатели_Node h ON cg.$to_id = h.$node_id
LEFT JOIN 
    Выдача_Книги_Edge vk ON vk.$from_id = h.$node_id AND vk.Дата_выдачи > '2025-09-01'
LEFT JOIN
    (SELECT 
        g.Название,
        ISNULL(SUM(vk.Количество), 0) AS Количество_книг,
        COUNT(DISTINCT CASE WHEN vk.Дата_фактической_сдачи IS NULL AND vk.Дата_предполагаемой_сдачи < GETDATE() THEN h.Id END) AS Количество_должников
    FROM 
        Группы_Node g,
        Читатели_Node h,
        Выдача_Книги_Edge vk,
        Читатель_в_Группе_Edge cg,
        Книги_Node k
    WHERE 
        MATCH(g<-(cg)-h-(vk)->k) AND
        vk.Дата_выдачи > '2025-09-01'
    GROUP BY 
    g.Id, g.Название) AS s ON g.Название = s.Название
GROUP BY 
    g.Id, g.Название;</code></pre>
				</li>
			</ol>
		</details>
	</li>
</ol>

<h3>
  <a href="https://github.com/kirill-155/DateBase/blob/main/Ресурсы/Лабораторная%206.docx" target="_blank">Запросы лабораторной 6 (со скринами)</a>
</h3>

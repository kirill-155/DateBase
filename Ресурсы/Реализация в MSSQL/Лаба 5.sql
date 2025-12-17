USE [master]
GO

-- Создание логинов
CREATE LOGIN [User_k.viharev] WITH PASSWORD = '1234567', DEFAULT_DATABASE = [Library], CHECK_EXPIRATION = OFF
CREATE LOGIN [User1_k.viharev] WITH PASSWORD = '1234567', DEFAULT_DATABASE = [Library], CHECK_EXPIRATION = OFF
GO

USE [Library]
GO

-- Создание пользователей в базе данных
CREATE USER [User_k.viharev] FOR LOGIN [User_k.viharev]
CREATE USER [User1_k.viharev] FOR LOGIN [User1_k.viharev]
GO

-- Создание ролей
CREATE ROLE [Director] -- Роль руководителя
CREATE ROLE [Employee] -- Роль сотрудника
GO

-- Предоставление прав на таблицы
GRANT SELECT, INSERT, UPDATE ON [dbo].[Авторы] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON [dbo].[Издательства] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Книги] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Список_авторов] TO [Director] WITH GRANT OPTION
GRANT SELECT, UPDATE ON [dbo].[Выдача_книг] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON [dbo].[Группы] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Список_тем] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON [dbo].[Темы] TO [Director] WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON [dbo].[Читатели] TO [Director] WITH GRANT OPTION

-- Права на представления
GRANT SELECT ON [dbo].[Стоимость_книг_каждого_автора] TO [Director] WITH GRANT OPTION
GRANT SELECT ON [dbo].[Автор_книги_дороже_200] TO [Director] WITH GRANT OPTION

-- Право создавать процедуры и функции
-- GRANT CREATE PROCEDURE TO [Director]
-- GRANT CREATE FUNCTION TO [Director]

-- Право на выполнение всех хранимых процедур (если они будут созданы)
GRANT EXECUTE TO [Director]

-- Ограниченные права на просмотр
GRANT SELECT ON [dbo].[Книги] TO [Employee]
GRANT SELECT ON [dbo].[Авторы] TO [Employee]
GRANT SELECT ON [dbo].[Издательства] TO [Employee]
GRANT SELECT ON [dbo].[Темы] TO [Employee]
GRANT SELECT ON [dbo].[Список_авторов] TO [Employee]
GRANT SELECT ON [dbo].[Список_тем] TO [Employee]
GRANT SELECT ON [dbo].[Читатели] TO [Employee]

-- Права на выданные книги (полный доступ для работы)
GRANT SELECT, INSERT, UPDATE ON [dbo].[Выдача_книг] TO [Employee]

-- Права на представления
GRANT SELECT ON [dbo].[Стоимость_книг_каждого_автора] TO [Employee]
GRANT SELECT ON [dbo].[Автор_книги_дороже_200] TO [Employee]

-- [User_k.viharev] получает роль руководителя
ALTER ROLE [Director] ADD MEMBER [User_k.viharev]

-- [User1_k.viharev] получает роль сотрудника
ALTER ROLE [Employee] ADD MEMBER [User1_k.viharev]
GO


-- Отзыв права DELETE на таблицу Книги у сотрудника
-- REVOKE DELETE ON [dbo].[Книги] FROM [Employee]

-- Отзыв права UPDATE на все таблицы у сотрудника
-- REVOKE UPDATE FROM [Employee]

-- Полный запрет на доступ к таблице Читатели для сотрудника
-- DENY SELECT ON [dbo].[Читатели] TO [Employee]

-- Запрет на изменение схемы для сотрудника
-- DENY ALTER ON SCHEMA::[dbo] TO [Employee]

-- Просмотр назначенных прав
SELECT 
    r.name AS RoleName,
    u.name AS UserName
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals u ON rm.member_principal_id = u.principal_id
WHERE r.name IN ('Director', 'Employee')

-- Просмотр разрешений для ролей
SELECT 
    class_desc,
    OBJECT_NAME(major_id) AS ObjectName,
    permission_name,
    state_desc,
    grantor_principal_id,
    grantee_principal_id
FROM sys.database_permissions
WHERE grantee_principal_id IN (
    SELECT principal_id FROM sys.database_principals 
    WHERE name IN ('Director', 'Employee')
)
ORDER BY grantee_principal_id, ObjectName


-- Маскируем
ALTER TABLE [dbo].[Читатели]
ALTER COLUMN [Имя] ADD MASKED WITH (FUNCTION = 'partial(1,"XXX",0)')

ALTER TABLE [dbo].[Читатели]
ALTER COLUMN [Отчество] ADD MASKED WITH (FUNCTION = 'default()')

GRANT UNMASK TO [Director]
GO


-- Функция для генерации фейковых фамилий
CREATE OR ALTER FUNCTION [dbo].[Фейковые_фамилии](@real VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FakeNamesTable TABLE (id INT IDENTITY(1,1), fake VARCHAR(100))
    
    INSERT INTO @FakeNamesTable
    VALUES
    ('Иванов'), ('Петров'), ('Сидоров'), ('Кузнецов'), ('Попов'),
    ('Соколов'), ('Лебедев'), ('Козлов'), ('Новиков'), ('Морозов'),
    ('Волков'), ('Соловьев'), ('Васильев'), ('Зайцев'), ('Павлов'),
    ('Семенов'), ('Голубев'), ('Виноградов'), ('Богданов'), ('Воробьев'),
    ('Федоров'), ('Михайлов'), ('Беляев'), ('Тарасов'), ('Белов'),
    ('Комаров'), ('Орлов'), ('Киселев'), ('Макаров'), ('Андреев')
    
    RETURN (SELECT fake FROM @FakeNamesTable 
           WHERE id = ABS(CHECKSUM(@real)) % (SELECT COUNT(*) FROM @FakeNamesTable) + 1)
END
GO

CREATE VIEW [dbo].[Маска_Читатели] 
AS
SELECT
    [Id],
	[dbo].[Фейковые_фамилии]([Фамилия]) AS [Фамилия],
	[Имя],
	[Отчество],
	[Задолженность],
	[Id_группы]
FROM [dbo].[Читатели]
GO

GRANT SELECT ON [dbo].[Маска_Читатели] TO [Employee]
DENY SELECT ON [dbo].[Читатели] TO [Employee]

EXECUTE AS USER = 'User_k.viharev'
SELECT * FROM [dbo].[Читатели]
REVERT

EXECUTE AS USER = 'User1_k.viharev'
SELECT * FROM [dbo].[Маска_Читатели]
REVERT

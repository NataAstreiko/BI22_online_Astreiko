5.	В базе данных AdventureWorks2017 создать таблицу Patients для ведения наблюдений за температурой пациентов больницы. Таблица должна содержать поля:
ID – числовое поле. Авто заполняется.
FirstName – имя пациента, может быть пустым.
LastName – фамилия пациента,  не может быть пустым.
SSN – уникальный идентификатор пациента.
Email – электронная почта пациента. Формируется по следующему правилу: первая большая буква FirstName + маленькие 3 буквы LastName + @mail.com (например, Akli@mail.com). Полезная ссылка здесь.
Temp – температура пациента, значения не должны превышать 45. 
CreatedDate — дата измерений.


CREATE TABLE Patients
(
ID INT IDENTITY (1,1),
FirstName VARCHAR(50) NULL,
LastName VARCHAR(50) NOT NULL,
SSN UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
Email AS CONCAT((UPPER(LEFT(FirstName,1))), (LOWER(LEFT(LastName,3)))+'@mail.com'),
Temp DECIMAL(4,1) CHECK (Temp <= 45) NOT NULL,
CreatedDate DATETIME NOT NULL
)

DROP TABLE Patients

SELECT *
FROM Patients


6.	Добавить в таблицу несколько произвольных записей. Убедиться, что ограничения действуют. Посмотрите на ошибки, если вставка противоречит ограничениям.

INSERT INTO Patients (FirstName, LastName, Temp, CreatedDate)
VALUES 
('Natalya', 'Astreika', CAST(36.6 AS DECIMAL(4,1)), '09/07/2024'),
('Alanya', 'Turkey', CAST (36.9 AS DECIMAL(4,1)), '08/07/2024')


7.	Добавить поле TempType со следующими значениями ‘< 0°C’,  ‘> 0°C’ на основе значений из поля Temp ( используйте ALTER TABLE
ADD column AS ). Посмотрите на данные, которые получились.

ALTER TABLE Patients
ADD TempType AS 
CASE
WHEN Temp<=0 THEN '< 0°C'
WHEN Temp>=0 THEN '> 0°C'
END
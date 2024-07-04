Теорию почитала

1) При каких значениях оконные функции ROW_NUMBER, RANK и DENSE_RANK вернут одинаковый результат?

--Не понимаю как ответить на этот вопрос. Должна быть одинаковая партиция для всех, чтобы все вывели "1", например.


2а)
SELECT *--DISTINCT UnitMeasureCode
FROM Production.UnitMeasure

INSERT INTO Production.UnitMeasure (UnitMeasureCode, Name, ModifiedDate)
VALUES 
('TT1', 'Test1', CONVERT(DATETIME,'09.09.2020')),
('TT2', 'Test2', getdate())


2b)

SELECT *
INTO Production.UnitMeasureTest
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'

INSERT INTO Production.UnitMeasureTest
SELECT * FROM Production.UnitMeasure
WHERE UnitMeasureCode='CAN'

SELECT * FROM Production.UnitMeasureTest -- для проверки

2с)

UPDATE Production.UnitMeasureTest
SET UnitMeasureCode ='TTT'

2d) DELETE UnitMeasureTest

2e)	

SELECT DISTINCT SalesOrderID, 
MAX(LineTotal) OVER (PARTITION BY SalesOrderID)	as max,
MIN(LineTotal) OVER (PARTITION BY SalesOrderID)	as min,
AVG(LineTotal) OVER (PARTITION BY SalesOrderID)	as avg
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN ('43659', '43664')


2f) 

SELECT *
FROM Sales.vSalesPerson

SELECT 
	Login, 
	CASE
	WHEN current_sales=1 then 'Winner of the current year'
	WHEN lastyear_sales=1 then 'Winner of the previous year'
	END as rating
FROM (
	SELECT UPPER (LEFT(LastName,3)) + 'login'+ ISNULL (TerritoryGroup,' ') as Login,
		RANK () OVER (ORDER BY SalesYTD DESC) as current_sales,
		RANK () OVER (ORDER BY SalesLastYear DESC) as lastyear_sales
	FROM Sales.vSalesPerson
	) as Results
WHERE Results.current_sales=1 OR Results.lastyear_sales=1

--подскажи, почему если убрать DESC из оконных функций, то выводит 4 варианта ответа? Оно же с фильтром на "1" по ранжированию продаж, то есть только 1 вариант в current_sales и 1 вариант в lastyear_sales

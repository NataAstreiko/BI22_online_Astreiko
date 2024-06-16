
/*1) Решите на базе данных AdventureWorks2017 следующую задачу.
Вывести список цен в виде текстового комментария, основанного на диапазоне цен для продукта:
a) StandardCost равен 0 или не обозначен – ‘Not for sale’
b) StandardCost больше 0, но меньше 100 -‘<$100’
c) StandardCost больше 100 (вкл), но меньше 500 -‘<$500
d) StandardCost больше 500 (вкл) -‘>=$500*/


SELECT StandardCost,
CASE
WHEN StandardCost=0 or StandardCost IS NULL THEN 'Not for sale'
WHEN StandardCost>0 AND StandardCost<100 THEN '<$100'
WHEN StandardCost>=100 AND StandardCost<500 THEN '<$500'
WHEN StandardCost>=500 THEN '>=$500'
ELSE 'ERROR'
END as price_category
FROM Production.Product
GROUP BY StandardCost
ORDER BY StandardCost

--2) Попробовать написать это же задание с использованием IIF

SELECT StandardCost,
IIF (StandardCost=0 or StandardCost IS NULL,'Not for sale',
	IIF (StandardCost>0 AND StandardCost<100,'<$100',
		IIF (StandardCost>=100 AND StandardCost<500,'<$500',
			IIF (StandardCost>=500, '>=$500', 'Error')
			)
		)
	)
FROM Production.Product
GROUP BY StandardCost
ORDER BY StandardCost


/*3) Таблица Purchasing.ProductVendor, поле LastReceiptDate для работы с датой. 
Вывести 4 сезона (лето, осень, зима, весна) и суммарную прибыль (LastReceiptCost). 
Если сумма меньше 2000 – вывести «Do not include». В подсчетах учитывать только тех, у кого AverageLeadTime больше 15.*/

SELECT SUM(LastReceiptCost) as total_income,
CASE
WHEN DATENAME(mm,LastReceiptDate)='March' OR DATENAME(mm,LastReceiptDate)='April' OR DATENAME(mm,LastReceiptDate)='May' THEN 'Spring'
WHEN DATENAME(mm, LastReceiptDate)='June' OR DATENAME(mm,LastReceiptDate)='July' OR DATENAME(mm,LastReceiptDate)='August' THEN 'Summer'
WHEN DATENAME(mm, LastReceiptDate)='September' OR DATENAME(mm,LastReceiptDate)='October' OR DATENAME(mm,LastReceiptDate)='November' THEN 'Autumn'
WHEN DATENAME(mm,LastReceiptDate)='December' OR DATENAME(mm,LastReceiptDate)='January' OR DATENAME(mm,LastReceiptDate)='February' THEN 'Winter'
ELSE 'N/a'
END as seasons,

CASE
WHEN SUM(LastReceiptCost)<2000 THEN 'Do not include'
ELSE 'Include'
END as condition

FROM Purchasing.ProductVendor
WHERE AverageLeadTime>15
GROUP BY DATENAME(mm,LastReceiptDate)



--4) Таблица Purchasing.ProductVendor. Вывести все записи для AverageLeadTime = 15.
Просчитать для каждой строки суммарную прибыль по BusinessEntityID и максимальную
прибыль по категориям UnitMeasureCode. Прибыль – колонка LastReceiptCost.

SELECT SUM(LastReceiptCost) as sum_lrc, MAX(LastReceiptCost) as max_lrc
FROM Purchasing.ProductVendor
WHERE AverageLeadTime=15
GROUP BY BusinessEntityID, UnitMeasureCode
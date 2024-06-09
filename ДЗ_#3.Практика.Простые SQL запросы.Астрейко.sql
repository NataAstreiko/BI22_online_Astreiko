--a) Найти самый минимальный вес и самый максимальный размер продукта из Production.Product.
SELECT MIN(Weight) as min_weight, MAX(Size) as max_size
FROM Production.Product

--У меня вопрос: тут выводится буквенное значение XL,а не 62, потому что XL закодировано на большее значение, чем максимальное 62 в этой колонке?


--b) Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product.
SELECT ProductSubcategoryID, MIN(Weight) as min_weight, MAX(Size) as max_size
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING MIN(Weight) IS NOT NULL AND MAX(Size) IS NOT NULL
ORDER BY MIN(Weight)


--c) Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product,
--где продукты должны иметь конкретный цвет (Color).
SELECT ProductSubcategoryID, Color, MIN(Weight) as min_weight, MAX(Size) as max_size
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID, Color
HAVING MIN(Weight) IS NOT NULL AND MAX(Size) IS NOT NULL
ORDER BY MIN(Weight)


--d)Найти все подкатегории продуктов ProductSubcategoryID из Production.Product, где самый минимальный вес продукта больше 50.
SELECT ProductSubcategoryID, MIN(Weight) as min_weight
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING MIN(Weight)>50


--e) Найти все подкатегории продуктов ProductSubcategoryID из Production.Product, где самый минимальный вес продукта с цветом Black 
----больше 50.
SELECT ProductSubcategoryID, Color, MIN(Weight) as min_weight
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID,Color
HAVING MIN(Weight)>50 AND Color='Black'

--У меня вопрос: тут должно вывестись одно значение, т.к. самый минимальный вес с таким условием 575. Почему выводятся все? Если убрать группировку по цвету - тоже самое.


--f) Вывести TaxType из Sales.SalesTaxRate, где минимальный TaxRate меньше 7.
SELECT TaxType, MIN(TaxRate) as min_taxrate
FROM Sales.SalesTaxRate
GROUP BY TaxType
HAVING MIN(TaxRate)<7


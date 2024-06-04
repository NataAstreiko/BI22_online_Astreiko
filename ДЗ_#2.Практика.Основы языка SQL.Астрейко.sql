/*a) Вывести только BusinessEntityID и LoginID из таблицы HumanResources.Employee для людей женского пола 
и младше 1969-01-29 (BirthDate)*/

SELECT BusinessEntityID, LoginID
FROM HumanResources.Employee
WHERE GENDER='F'
AND BirthDate > '1969-01-29'


/*b) Вывести уникальные PersonType для людей из Person.Person, где LastName начинается с буквы М или с буквы N и обязательно
заполнено поле MiddleName*/

SELECT DISTINCT PersonType
FROM Person.Person
WHERE MiddleName IS NOT NULL
AND (LastName LIKE 'M%' OR LastName LIKE 'N%')


/*c) Вывести данные из Sales.SpecialOffer начиная с наибольшего DiscountPct, которые начинали действовать 
с 2013-01-01 по 2014-01-01 (поле StartDate)*/

SELECT *
FROM Sales.SpecialOffer
WHERE StartDate BETWEEN '2013-01-01' AND '2014-01-01'
ORDER BY DiscountPct DESC


/*d) Найти ProductID и Name из Production.Product, где в имени ProductNumber вторая буква “B” и последняя заканчивается на
цифру, а ProductID упорядочивается в порядке убывания*/

SELECT ProductID, Name
FROM Production.Product
WHERE ProductNumber LIKE '_B%[0-9]'
ORDER BY ProductID DESC


/*e) Вывести ProductID, Name из таблицы Production.Product где цвет либо Red, либо Silver или Black и Size имеет какое-либо значение*/

SELECT ProductID, Name
FROM Production.Product
WHERE Color IN ('Red', 'Silver', 'Black')
AND Size IS NOT NULL


/*f) Вывести уникальные JobTitle из HumanResources.Employee, где SickLeaveHours меньше или равно 15 или VacationHours не
больше 20,но также необходимо исключить все JobTitle y которых есть слово ‘Vice President’ или ‘Manager’*/

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
WHERE JobTitle NOT IN ('Vice President', 'Manager')
AND (SickLeaveHours <=15 OR VacationHours <=20)


/*g) Опишите задачу, которая решается следующим выражением:*/

SELECT LastName, FirstName
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC

/*Вывести LastName и FirstName из таблицы Person.Person, где в LastName первая буква “R”, FirstName упорядочивается по алфавиту,
а LastName в обратном алфавитном порядке*/
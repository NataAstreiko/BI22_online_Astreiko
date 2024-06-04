/*a) ������� ������ BusinessEntityID � LoginID �� ������� HumanResources.Employee ��� ����� �������� ���� 
� ������ 1969-01-29 (BirthDate)*/

SELECT BusinessEntityID, LoginID
FROM HumanResources.Employee
WHERE GENDER='F'
AND BirthDate > '1969-01-29'


/*b) ������� ���������� PersonType ��� ����� �� Person.Person, ��� LastName ���������� � ����� � ��� � ����� N � �����������
��������� ���� MiddleName*/

SELECT DISTINCT PersonType
FROM Person.Person
WHERE MiddleName IS NOT NULL
AND (LastName LIKE 'M%' OR LastName LIKE 'N%')


/*c) ������� ������ �� Sales.SpecialOffer ������� � ����������� DiscountPct, ������� �������� ����������� 
� 2013-01-01 �� 2014-01-01 (���� StartDate)*/

SELECT *
FROM Sales.SpecialOffer
WHERE StartDate BETWEEN '2013-01-01' AND '2014-01-01'
ORDER BY DiscountPct DESC


/*d) ����� ProductID � Name �� Production.Product, ��� � ����� ProductNumber ������ ����� �B� � ��������� ������������� ��
�����, � ProductID ��������������� � ������� ��������*/

SELECT ProductID, Name
FROM Production.Product
WHERE ProductNumber LIKE '_B%[0-9]'
ORDER BY ProductID DESC


/*e) ������� ProductID, Name �� ������� Production.Product ��� ���� ���� Red, ���� Silver ��� Black � Size ����� �����-���� ��������*/

SELECT ProductID, Name
FROM Production.Product
WHERE Color IN ('Red', 'Silver', 'Black')
AND Size IS NOT NULL


/*f) ������� ���������� JobTitle �� HumanResources.Employee, ��� SickLeaveHours ������ ��� ����� 15 ��� VacationHours ��
������ 20,�� ����� ���������� ��������� ��� JobTitle y ������� ���� ����� �Vice President� ��� �Manager�*/

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
WHERE JobTitle NOT IN ('Vice President', 'Manager')
AND (SickLeaveHours <=15 OR VacationHours <=20)


/*g) ������� ������, ������� �������� ��������� ����������:*/

SELECT LastName, FirstName
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC

/*������� LastName � FirstName �� ������� Person.Person, ��� � LastName ������ ����� �R�, FirstName ��������������� �� ��������,
� LastName � �������� ���������� �������*/
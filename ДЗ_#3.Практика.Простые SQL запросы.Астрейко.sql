--a) ����� ����� ����������� ��� � ����� ������������ ������ �������� �� Production.Product.
SELECT MIN(Weight) as min_weight, MAX(Size) as max_size
FROM Production.Product

--� ���� ������: ��� ��������� ��������� �������� XL,� �� 62, ������ ��� XL ������������ �� ������� ��������, ��� ������������ 62 � ���� �������?


--b) ����� ����� ����������� ��� � ����� ������������ ������ �������� ��� ������ ������������ ProductSubcategoryID �� Production.Product.
SELECT ProductSubcategoryID, MIN(Weight) as min_weight, MAX(Size) as max_size
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING MIN(Weight) IS NOT NULL AND MAX(Size) IS NOT NULL
ORDER BY MIN(Weight)


--c) ����� ����� ����������� ��� � ����� ������������ ������ �������� ��� ������ ������������ ProductSubcategoryID �� Production.Product,
--��� �������� ������ ����� ���������� ���� (Color).
SELECT ProductSubcategoryID, Color, MIN(Weight) as min_weight, MAX(Size) as max_size
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID, Color
HAVING MIN(Weight) IS NOT NULL AND MAX(Size) IS NOT NULL
ORDER BY MIN(Weight)


--d)����� ��� ������������ ��������� ProductSubcategoryID �� Production.Product, ��� ����� ����������� ��� �������� ������ 50.
SELECT ProductSubcategoryID, MIN(Weight) as min_weight
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING MIN(Weight)>50


--e) ����� ��� ������������ ��������� ProductSubcategoryID �� Production.Product, ��� ����� ����������� ��� �������� � ������ Black 
----������ 50.
SELECT ProductSubcategoryID, Color, MIN(Weight) as min_weight
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID,Color
HAVING MIN(Weight)>50 AND Color='Black'

--� ���� ������: ��� ������ ��������� ���� ��������, �.�. ����� ����������� ��� � ����� �������� 575. ������ ��������� ���? ���� ������ ����������� �� ����� - ���� �����.


--f) ������� TaxType �� Sales.SalesTaxRate, ��� ����������� TaxRate ������ 7.
SELECT TaxType, MIN(TaxRate) as min_taxrate
FROM Sales.SalesTaxRate
GROUP BY TaxType
HAVING MIN(TaxRate)<7


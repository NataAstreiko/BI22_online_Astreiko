3�) ����� ����� �� ������� Person.Person (������� ������ �� ����� � 1 �������:������ ��� � �������), 
� ������� �����, ��� 1 ������� (�������������� ����� �������, ������� ������ �������� ����� � ��������� � ���)

SELECT CONCAT (FirstName,' ',LastName) as full_name
FROM Person.Person as pp
JOIN Person.PersonPhone ppp
ON pp.BusinessEntityID=ppp.BusinessEntityID
GROUP BY CONCAT (FirstName,' ',LastName)
HAVING COUNT(PhoneNumber)>1


3�) ����� �������� (������� ��������), � ������� ������ (������ ������� ����������� ����� Purchasing) �������� ������� ���� �� ��������
������ 10. ����� � ����� ������� ������ �������������� ����� � ��� ����� �������� ������� ������ ���������� �� �.

SELECT /*pv.Name as vendor_name,*/ pp.Name as product_name/*, AVG(ppv.StandardPrice) as avg_price ,AccountNumber*/
FROM Purchasing.Vendor as pv
JOIN Purchasing.ProductVendor as ppv
ON pv.BusinessEntityID=ppv.BusinessEntityID
JOIN Production.Product as pp
ON pp.ProductID=ppv.ProductID
WHERE pv.Name LIKE '%a%' OR AccountNumber LIKE 'A%'
GROUP BY /*pv.Name,*/ pp.Name /*, AccountNumber*/
HAVING AVG(ppv.StandardPrice)>10


3c) ����� ����� ���� ��������, ��������� ������� �� ����������� ������� (��� ������� � ������� Purchasing.ProductVendor). ��� ������� ���� ������ ������������ LEFT JOINSELECT pv.Name as vendor_name
FROM Purchasing.Vendor as pv
LEFT JOIN Purchasing.ProductVendor as ppv
ON pv.BusinessEntityID=ppv.BusinessEntityID
Where ppv.BusinessEntityID IS NULL

4a) ������� ����� ���� ����������� � ������������, � ������� ��� ��������

SELECT emp_name, dep_name
FROM Employees as emp
LEFT JOIN Departments as dep
ON emp.dep_id=dep.dep_id


4b) ������� ������������ � ���-�� �����������, ���������� � ���

SELECT dep_name, COUNT(emp_name) as amount_of_emp
FROM Departments as dep
JOIN Employees as emp
ON dep.dep_id=emp.dep_id


4c) ������� �� ����� ���������� �����, ����� �� �Maryia Paulava� ����������
�maryia_paulava@gmail.com�

SELECT 
LOWER(CONCAT ('Maryia','_','Paulava','@gmail.com'))


4d) ����� ����������� � ����� ������� ��������, ������� ��� � ��������� ������� ������
1�� (�������) ������������. NULL � ����������� �����������, ��� ����������� ���������!
���� ����� � �������� �� �N.D.�

SELECT TOP 1 SUM(revenue) as sum_rev, dep_name
FROM employees as emp
JOIN revenue as rev
ON emp.emp_id=rev.emp_id
RIGHT JOIN departments as dep
ON dep.dep_id=emp.dep_id
GROUP BY SUM(revenue) as sum_rev, dep_name


5a) ������� ������ �� ��������� 10 ���. (��������� DATEDIFF � CURRENT_TIMESTAMP)

SELECT *
FROM Purchasing.ProductVendor
WHERE DATEDIFF(yy,LastReceiptDate,CURRENT_TIMESTAMP)<=10


5b) ������� ������ � ��������, ������� ��������� � ����� �� ����� ��� �������.

SELECT *
FROM Purchasing.ProductVendor
WHERE MONTH(LastReceiptDate)=MONTH(CURRENT_TIMESTAMP)


5c) ������� ��� ������ (�������) � ���������� ������� � ���. (��������� � �������� 7 ����� �� ������ ���� ������).

SELECT DATENAME(dw,LastReceiptDate) as dw, COUNT(LastReceiptDate) as amt
FROM Purchasing.ProductVendor
GROUP BY DATENAME(dw,LastReceiptDate)


5d) ������� � ��������� �������: ����, �����, ��� � ������������� 3 �������:
������� ������� ���� � ����� �����, � ����� �����, � ����� ��� (����� ������������ ���������� ���)

SELECT 
DAY(LastReceiptDate) as dn,
MONTH(LastReceiptDate) as mn, 
YEAR(LastReceiptDate) as yn, 
COUNT(DAY(LastReceiptDate)) as amt_d,
COUNT(MONTH(LastReceiptDate)) as amt_m,
COUNT(YEAR(LastReceiptDate)) as amt_y,
LastReceiptDate
FROM Purchasing.ProductVendor
GROUP BY DAY(LastReceiptDate), MONTH(LastReceiptDate), YEAR(LastReceiptDate), LastReceiptDate
ORDER BY yn

--�� ������� ������ �������: "������� ������� ���� � ����� �����, � ����� �����, � ����� ���" - �.�. 3 ��������� �������.
--� ������ ���������� ������� � ���������� ����. �������� � ������� "�����" �� ����� ����������� �� ���� ������� � � ������� "���" ���� �����. 
--����)
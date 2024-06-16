3а) Найти людей из таблицы Person.Person (вывести только их имена в 1 колонку:вместе Имя и Фамилию), 
у которых более, чем 1 телефон (самостоятельно найти таблицу, которая хранит телефоны людей и связаться с ней)

SELECT CONCAT (FirstName,' ',LastName) as full_name
FROM Person.Person as pp
JOIN Person.PersonPhone ppp
ON pp.BusinessEntityID=ppp.BusinessEntityID
GROUP BY CONCAT (FirstName,' ',LastName)
HAVING COUNT(PhoneNumber)>1


3б) Найти продукты (вывести названия), у которых Вендор (нужная таблица находитсяна схеме Purchasing) выставил среднюю цену по продукту
больше 10. Также в имени вендора должна присутствовать буква А или номер аккаунта вендора должен начинаться на А.

SELECT /*pv.Name as vendor_name,*/ pp.Name as product_name/*, AVG(ppv.StandardPrice) as avg_price ,AccountNumber*/
FROM Purchasing.Vendor as pv
JOIN Purchasing.ProductVendor as ppv
ON pv.BusinessEntityID=ppv.BusinessEntityID
JOIN Production.Product as pp
ON pp.ProductID=ppv.ProductID
WHERE pv.Name LIKE '%a%' OR AccountNumber LIKE 'A%'
GROUP BY /*pv.Name,*/ pp.Name /*, AccountNumber*/
HAVING AVG(ppv.StandardPrice)>10


3c) Найти имена всех вендоров, продукция которых не продавалась никогда (нет записей в таблице Purchasing.ProductVendor). Для решения этой задачи использовать LEFT JOINSELECT pv.Name as vendor_name
FROM Purchasing.Vendor as pv
LEFT JOIN Purchasing.ProductVendor as ppv
ON pv.BusinessEntityID=ppv.BusinessEntityID
Where ppv.BusinessEntityID IS NULL

4a) Вывести имена всех сотрудников и департаменты, в которых они работают

SELECT emp_name, dep_name
FROM Employees as emp
LEFT JOIN Departments as dep
ON emp.dep_id=dep.dep_id


4b) Вывести департаменты и кол-во сотрудников, работающих в них

SELECT dep_name, COUNT(emp_name) as amount_of_emp
FROM Departments as dep
JOIN Employees as emp
ON dep.dep_id=emp.dep_id


4c) Сделать из имени сотрудника емейл, чтобы из «Maryia Paulava» получилось
«maryia_paulava@gmail.com»

SELECT 
LOWER(CONCAT ('Maryia','_','Paulava','@gmail.com'))


4d) Найти департамент с самой большой прибылью, вывести имя и суммарную прибыль только
1го (лучшего) департамента. NULL – неизвестный департамент, его ОБЯЗАТЕЛЬНО учитываем!
Если нужно – заменяем на «N.D.»

SELECT TOP 1 SUM(revenue) as sum_rev, dep_name
FROM employees as emp
JOIN revenue as rev
ON emp.emp_id=rev.emp_id
RIGHT JOIN departments as dep
ON dep.dep_id=emp.dep_id
GROUP BY SUM(revenue) as sum_rev, dep_name


5a) Вывести данные за последние 10 лет. (используй DATEDIFF и CURRENT_TIMESTAMP)

SELECT *
FROM Purchasing.ProductVendor
WHERE DATEDIFF(yy,LastReceiptDate,CURRENT_TIMESTAMP)<=10


5b) Вывести данные о событиях, которые произошли в такой же месяц как сегодня.

SELECT *
FROM Purchasing.ProductVendor
WHERE MONTH(LastReceiptDate)=MONTH(CURRENT_TIMESTAMP)


5c) Вывести дни недели (словами) и количество событий в них. (Результат – максимум 7 строк на каждый день недели).

SELECT DATENAME(dw,LastReceiptDate) as dw, COUNT(LastReceiptDate) as amt
FROM Purchasing.ProductVendor
GROUP BY DATENAME(dw,LastReceiptDate)


5d) Вывести в отдельные колонки: день, месяц, год и дополнительно 3 колонки:
сколько событий было в такое число, в такой месяц, в такой год (можно использовать подзапросы тут)

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

--Не понимаю смысла условия: "сколько событий было в такое число, в такой месяц, в такой год" - т.е. 3 отдельные колонки.
--Я вывела количество событий в выведенную дату. Значения в колонке "месяц" же будут аналогичные по всей выборке и в колонке "год" тоже самое. 
--Хелп)
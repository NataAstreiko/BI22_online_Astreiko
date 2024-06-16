3à) Íàéòè ëþäåé èç òàáëèöû Person.Person (âûâåñòè òîëüêî èõ èìåíà â 1 êîëîíêó:âìåñòå Èìÿ è Ôàìèëèþ), 
ó êîòîðûõ áîëåå, ÷åì 1 òåëåôîí (ñàìîñòîÿòåëüíî íàéòè òàáëèöó, êîòîðàÿ õðàíèò òåëåôîíû ëþäåé è ñâÿçàòüñÿ ñ íåé)

SELECT CONCAT (FirstName,' ',LastName) as full_name
FROM Person.Person as pp
JOIN Person.PersonPhone ppp
ON pp.BusinessEntityID=ppp.BusinessEntityID
GROUP BY CONCAT (FirstName,' ',LastName)
HAVING COUNT(PhoneNumber)>1


3á) Íàéòè ïðîäóêòû (âûâåñòè íàçâàíèÿ), ó êîòîðûõ Âåíäîð (íóæíàÿ òàáëèöà íàõîäèòñÿíà ñõåìå Purchasing) âûñòàâèë ñðåäíþþ öåíó ïî ïðîäóêòó
áîëüøå 10. Òàêæå â èìåíè âåíäîðà äîëæíà ïðèñóòñòâîâàòü áóêâà À èëè íîìåð àêêàóíòà âåíäîðà äîëæåí íà÷èíàòüñÿ íà À.

SELECT /*pv.Name as vendor_name,*/ pp.Name as product_name/*, AVG(ppv.StandardPrice) as avg_price ,AccountNumber*/
FROM Purchasing.Vendor as pv
JOIN Purchasing.ProductVendor as ppv
ON pv.BusinessEntityID=ppv.BusinessEntityID
JOIN Production.Product as pp
ON pp.ProductID=ppv.ProductID
WHERE pv.Name LIKE '%a%' OR AccountNumber LIKE 'A%'
GROUP BY /*pv.Name,*/ pp.Name /*, AccountNumber*/
HAVING AVG(ppv.StandardPrice)>10


3c) Íàéòè èìåíà âñåõ âåíäîðîâ, ïðîäóêöèÿ êîòîðûõ íå ïðîäàâàëàñü íèêîãäà (íåò çàïèñåé â òàáëèöå Purchasing.ProductVendor). 
Äëÿ ðåøåíèÿ ýòîé çàäà÷è èñïîëüçîâàòü LEFT JOIN

SELECT pv.Name as vendor_name
FROM Purchasing.Vendor as pv
LEFT JOIN Purchasing.ProductVendor as ppv
ON pv.BusinessEntityID=ppv.BusinessEntityID
Where ppv.BusinessEntityID IS NULL


4a) Âûâåñòè èìåíà âñåõ ñîòðóäíèêîâ è äåïàðòàìåíòû, â êîòîðûõ îíè ðàáîòàþò

SELECT emp_name, dep_name
FROM Employees as emp
LEFT JOIN Departments as dep
ON emp.dep_id=dep.dep_id


4b) Âûâåñòè äåïàðòàìåíòû è êîë-âî ñîòðóäíèêîâ, ðàáîòàþùèõ â íèõ

SELECT dep_name, COUNT(emp_name) as amount_of_emp
FROM Departments as dep
JOIN Employees as emp
ON dep.dep_id=emp.dep_id


4c) Ñäåëàòü èç èìåíè ñîòðóäíèêà åìåéë, ÷òîáû èç «Maryia Paulava» ïîëó÷èëîñü
«maryia_paulava@gmail.com»

SELECT 
LOWER(CONCAT ('Maryia','_','Paulava','@gmail.com'))


4d) Íàéòè äåïàðòàìåíò ñ ñàìîé áîëüøîé ïðèáûëüþ, âûâåñòè èìÿ è ñóììàðíóþ ïðèáûëü òîëüêî
1ãî (ëó÷øåãî) äåïàðòàìåíòà. NULL – íåèçâåñòíûé äåïàðòàìåíò, åãî ÎÁßÇÀÒÅËÜÍÎ ó÷èòûâàåì!
Åñëè íóæíî – çàìåíÿåì íà «N.D.»

SELECT TOP 1 SUM(revenue) as sum_rev, dep_name
FROM employees as emp
JOIN revenue as rev
ON emp.emp_id=rev.emp_id
RIGHT JOIN departments as dep
ON dep.dep_id=emp.dep_id
GROUP BY SUM(revenue) as sum_rev, dep_name


5a) Âûâåñòè äàííûå çà ïîñëåäíèå 10 ëåò. (èñïîëüçóé DATEDIFF è CURRENT_TIMESTAMP)

SELECT *
FROM Purchasing.ProductVendor
WHERE DATEDIFF(yy,LastReceiptDate,CURRENT_TIMESTAMP)<=10


5b) Âûâåñòè äàííûå î ñîáûòèÿõ, êîòîðûå ïðîèçîøëè â òàêîé æå ìåñÿö êàê ñåãîäíÿ.

SELECT *
FROM Purchasing.ProductVendor
WHERE MONTH(LastReceiptDate)=MONTH(CURRENT_TIMESTAMP)


5c) Âûâåñòè äíè íåäåëè (ñëîâàìè) è êîëè÷åñòâî ñîáûòèé â íèõ. (Ðåçóëüòàò – ìàêñèìóì 7 ñòðîê íà êàæäûé äåíü íåäåëè).

SELECT DATENAME(dw,LastReceiptDate) as dw, COUNT(LastReceiptDate) as amt
FROM Purchasing.ProductVendor
GROUP BY DATENAME(dw,LastReceiptDate)


5d) Âûâåñòè â îòäåëüíûå êîëîíêè: äåíü, ìåñÿö, ãîä è äîïîëíèòåëüíî 3 êîëîíêè:
ñêîëüêî ñîáûòèé áûëî â òàêîå ÷èñëî, â òàêîé ìåñÿö, â òàêîé ãîä (ìîæíî èñïîëüçîâàòü ïîäçàïðîñû òóò)

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

--Íå ïîíèìàþ ñìûñëà óñëîâèÿ: "ñêîëüêî ñîáûòèé áûëî â òàêîå ÷èñëî, â òàêîé ìåñÿö, â òàêîé ãîä" - ò.å. 3 îòäåëüíûå êîëîíêè.
--ß âûâåëà êîëè÷åñòâî ñîáûòèé â âûâåäåííóþ äàòó. Çíà÷åíèÿ â êîëîíêå "ìåñÿö" æå áóäóò àíàëîãè÷íûå ïî âñåé âûáîðêå è â êîëîíêå "ãîä" òîæå ñàìîå. 
--Õåëï)

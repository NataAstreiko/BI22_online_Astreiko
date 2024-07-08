
SELECT DISTINCT pp.Name as ProductName, pp.ProductNumber,coalesce(pp.Class,'n/d') as Class,
CASE
WHEN pp.Size LIKE '%[a-z]%' THEN 'Lateral'
WHEN pp.Size LIKE '%[0-9]%' THEN 'Numeric'
WHEN pp.Size IS NULL THEN 'Unknown' --или ELSE (на случай, если кто-то поставил прочерк, а не ничего)
END as Product_size,
coalesce(first_value(pv.Name) over (partition by pp.Name order by ppv.lastReceiptDate), 'n/d') as VendorName,
coalesce(ppm.Name , 'n/d') as ModelName,
coalesce(pod.AvgUnitPrice, 0) as AvgUnitPrice
FROM Production.Product as pp
left join Production.ProductModel ppm
on ppm.ProductModelID=pp.ProductModelID
left join Purchasing.ProductVendor as ppv
on pp.ProductID =ppv.ProductID
left join Purchasing.Vendor pv
on pv.BusinessEntityID=ppv.BusinessEntityID
and pv.CreditRating = 1
and pv.ActiveFlag = 1

left join (select  pod.ProductID, avg(pod.UnitPrice) as AvgUnitPrice ---как исполняется "запрос должен выполняться не более 10 секунд"?
			from Purchasing.PurchaseOrderHeader as poh
			join Purchasing.PurchaseOrderDetail as pod
			on poh.PurchaseOrderID = pod.PurchaseOrderID
			where poh.Status = 4
			group by pod.ProductID) as pod
on pod.ProductID = pp.ProductID

order by 1

SELECT *
FROM Purchasing.ProductVendor

SELECT *
FROM Production.ProductModel

SELECT *
FROM Production.Product


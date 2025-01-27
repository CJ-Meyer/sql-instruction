--prdctname,lstprice,dscntprcnt,dscntamount,dscntprice

SELECT ProductName, ListPrice,DiscountPercent,
	(ListPrice*(DiscountPercent/100)) as DiscountAmount,
	(ListPrice - (ListPrice*(DiscountPercent/100))) as DiscountPrice
	FROM products
ORDER BY DiscountPrice DESC;
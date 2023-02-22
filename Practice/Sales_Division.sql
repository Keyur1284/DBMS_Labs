SET SEARCH_PATH TO sales;

SELECT * FROM customer;
SELECT * FROM items;
SELECT * FROM invoice;
SELECT * FROM invoicedetails;

SELECT * FROM customer
WHERE custid NOT IN 
(
	SELECT custid FROM 
	(
		SELECT custid, code FROM customer CROSS JOIN invoice CROSS JOIN invoicedetails CROSS JOIN items WHERE category = 3
		
		EXCEPT
		
		SELECT custid, code FROM customer JOIN invoice ON custid = customerid
		NATURAL JOIN invoicedetails JOIN items ON code = itemcode
		
	) AS temp
);

SELECT * FROM customer AS cust
WHERE NOT EXISTS
(
	SELECT code FROM customer JOIN invoice ON custid = customerid
	NATURAL JOIN invoicedetails JOIN items ON code = itemcode WHERE category = 3
	
	EXCEPT
		
	SELECT code FROM customer JOIN invoice ON custid = customerid
	NATURAL JOIN invoicedetails JOIN items ON code = itemcode WHERE cust.custid = customer.custid
);
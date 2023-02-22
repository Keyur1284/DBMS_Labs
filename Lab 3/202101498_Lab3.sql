SET SEARCH_PATH TO sales;

-- 1
SELECT * FROM items WHERE saleprice > 1000;

-- 2
SELECT * FROM items WHERE saleprice > 1000 AND category = 5;

-- 3
SELECT invno, invdate FROM invoice WHERE customerid = 'C05';

-- 4
SELECT itemcode, qty, rate FROM invoicedetails WHERE invno = 1;

-- 5
SELECT invno, invdate FROM invoice
JOIN customer ON custid = customerid
WHERE name = 'Harsh';

-- 6
SELECT inv.invno, inv.invdate, inv.customerid FROM invoice AS inv
JOIN invoicedetails AS invd ON invd.invno = inv.invno
WHERE invd.itemcode = 1103;

-- 7
SELECT invd.invno, invd.itemcode, invd.qty FROM invoicedetails AS invd
JOIN invoice AS inv ON invd.invno = inv.invno
WHERE inv.customerid = 'C05';

-- 8
SELECT DISTINCT cust.custid, cust.name, cust.city FROM customer AS cust
JOIN invoice AS inv ON inv.customerid = cust.custid
JOIN invoicedetails AS invd ON invd.invno = inv.invno
WHERE itemcode = 1101;

-- 9
SELECT it.code, it.name FROM items AS it
JOIN invoicedetails AS invd ON it.code = invd.itemcode
JOIN invoice AS inv ON invd.invno = inv.invno
WHERE inv.invdate = '2011-08-23';

-- 10
-- Method 1
SELECT DISTINCT it.name, it.code FROM items AS it
JOIN invoicedetails AS invd ON invd.itemcode = it.code
JOIN invoice AS inv ON inv.invno = invd.invno
WHERE EXTRACT (YEAR FROM inv.invdate) = '2011' AND
EXTRACT (MONTH FROM inv.invdate) = '07' AND it.category = 3;
-- Method 2
SELECT DISTINCT it.name, it.code FROM items AS it
JOIN invoicedetails AS invd ON invd.itemcode = it.code
JOIN invoice AS inv ON inv.invno = invd.invno
WHERE inv.invdate >= '2011-07-01' AND inv.invdate <= '2011-07-31'
AND it.category = 3;

-- 11
SELECT cust.custid, cust.name, cust.city FROM customer AS cust
JOIN invoice AS inv ON inv.customerid = cust.custid
JOIN invoicedetails AS invd ON invd.invno = inv.invno
JOIN items AS it ON it.code = invd.itemcode
WHERE it.category = 3 AND cust.state = 'GJ';

-- 12
SELECT it.code, it.name FROM items AS it
JOIN invoicedetails AS invd ON invd.itemcode = it.code
JOIN invoice AS inv ON inv.invno = invd.invno
JOIN customer AS cust ON inv.customerid = cust.custid
WHERE inv.invdate = '2011-08-23' AND cust.name = 'Dev';
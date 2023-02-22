SET SEARCH_PATH TO sales;

-- 1
SELECT SUM (qty * rate) FROM invoicedetails WHERE itemcode = 1103;

-- 2
SELECT invdate, SUM (qty * rate) FROM invoicedetails NATURAL JOIN invoice
GROUP BY invdate;

-- 3
SELECT itemcode, SUM (qty) AS total FROM invoicedetails
GROUP BY itemcode
ORDER BY total DESC
LIMIT 3;

-- 4
SELECT code, name, category FROM items JOIN
(
    SELECT itemcode, SUM (qty) AS total FROM invoicedetails
    GROUP BY itemcode
    ORDER BY total DESC
    LIMIT 3
) AS temp ON temp.itemcode = code;

-- 5
SELECT custid FROM customer JOIN invoice ON custid = customerid
NATURAL JOIN
(
    SELECT invno, SUM (qty * rate) AS total FROM invoicedetails
    GROUP BY invno
    ORDER BY total DESC
    LIMIT 1
) AS temp;

-- 6
SELECT custid FROM customer JOIN invoice ON custid = customerid
NATURAL JOIN
(
    SELECT invno, SUM (rate - averagepurchaseprice) AS total FROM invoicedetails 
    JOIN items ON code = itemcode
    GROUP BY invno
    ORDER BY total DESC
    LIMIT 1
) AS temp;

SELECT * FROM items;
SELECT * FROM invoicedetails NATURAL JOIN invoice WHERE itemcode = 1103;
SELECT * FROM invoice;
SELECT * FROM customer;

-- 7
SELECT year, MAX(total) AS max_qty FROM
(
	SELECT EXTRACT (YEAR FROM invdate) AS year, itemcode, SUM (qty) AS total
	FROM invoicedetails NATURAL JOIN invoice
	GROUP BY  year, itemcode
	
) AS temp GROUP BY year;


SET SEARCH_PATH TO acad;

SELECT * FROM instructor;
SELECT * FROM student;
SELECT * FROM registers;
SELECT * FROM offers;
SELECT * FROM course;

-- 8
SELECT instructorid, acadyear, semester FROM instructor NATURAL JOIN offers
GROUP BY acadyear, semester, instructorid
HAVING COUNT(courseno) > 1;

-- 9
SELECT instructor.instructorid, instructorname, COUNT(courseno) AS course_count FROM instructor 
LEFT JOIN offers ON offers.instructorid = instructor.instructorid
GROUP BY instructor.instructorid, instructorname;

-- 10
SELECT studentid, name, SUM(credit) AS total_credits FROM student 
NATURAL JOIN registers NATURAL JOIN course
WHERE progid = '02' AND batch = 2007 AND semester = 'Autumn' AND acadyear = '2008'
GROUP BY studentid, name;

-- 11
SELECT studentid, name FROM student NATURAL JOIN registers
WHERE semester = 'Autumn' AND acadyear = '2008' AND grade = 'F'
GROUP BY studentid, name
HAVING COUNT(grade) > 2;

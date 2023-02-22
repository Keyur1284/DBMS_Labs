SET SEARCH_PATH TO acad;

SELECT * FROM offers;
SELECT * FROM instructor;
SELECT * FROM registers;

SELECT * FROM student
WHERE studentid NOT IN
(
	SELECT studentid FROM
	(
		SELECT studentid, acadyear, semester, courseno FROM
	
		(SELECT acadyear, semester, courseno FROM offers 
		WHERE instructorid = 'PMJ' AND acadyear >= 2007 AND acadyear <= 2011) AS ofr
		CROSS JOIN
		(SELECT studentid FROM registers) AS reg

		EXCEPT

		SELECT studentid, acadyear, semester, courseno FROM registers
		WHERE acadyear >= 2007 AND acadyear <= 2011
		
	) AS temp
);

SELECT * FROM student AS st
WHERE NOT EXISTS
(
	SELECT acadyear, semester, courseno FROM offers 
	WHERE instructorid = 'PMJ' AND acadyear >= 2007 AND acadyear <= 2011
	
	EXCEPT
	
	SELECT acadyear, semester, courseno FROM registers
	WHERE acadyear >= 2007 AND acadyear <= 2011	AND registers.studentid = st.studentid
);

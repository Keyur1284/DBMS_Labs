SET SEARCH_PATH TO company3;

SELECT * FROM employee NATURAL JOIN works_on ORDER BY eno, pno;
SELECT * FROM works_on;
SELECT * FROM project;

SELECT * FROM employee
WHERE eno NOT IN
(
	SELECT eno FROM
	(
		SELECT eno, pno FROM
		(SELECT eno FROM employee) AS emp CROSS JOIN (SELECT pno FROM project WHERE dno = 4) AS pro
		
		EXCEPT
		
		SELECT eno, pno FROM works_on
		
	) AS temp
);

SELECT * FROM employee AS emp
WHERE NOT EXISTS
(
	SELECT pno FROM project WHERE dno = 4
	
	EXCEPT
	
	SELECT pno FROM works_on AS won WHERE won.eno = emp.eno
);

SELECT * FROM employee
WHERE eno NOT IN
(
	SELECT eno FROM 
	(
		SELECT eno, pno FROM
		(SELECT eno FROM employee) AS emp CROSS JOIN (SELECT pno FROM works_on WHERE eno = 101) AS pro

		EXCEPT
		
		SELECT eno, pno FROM works_on
	) AS temp
)
ORDER BY eno;


SELECT * FROM employee AS emp
WHERE NOT EXISTS
(
	SELECT pno FROM works_on WHERE eno = 101
	
	EXCEPT
	
	SELECT pno FROM works_on AS won WHERE won.eno = emp.eno
)
ORDER BY eno;
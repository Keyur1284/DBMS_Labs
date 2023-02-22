SET SEARCH_PATH TO company3;

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM works_on;
SELECT * FROM project;
SELECT * FROM dependent;
SELECT * FROM dept_locations;

-- Queries based on Selection and Project operations

-- 1
SELECT * FROM employee WHERE dno = 4;

-- 2
SELECT * FROM employee WHERE salary > 30000;

-- 3
SELECT eno, ename, salary FROM employee;

-- 4
SELECT eno, ename, salary FROM employee WHERE dno = 4;

-- 5
SELECT eno, ename, salary FROM employee WHERE gender = 'F';

-- 6
SELECT eno, ename, salary FROM employee WHERE super_eno = 105;

-- 7
SELECT eno, ename, salary FROM employee WHERE salary >= 10000 AND salary <= 30000;

-- 8
SELECT * FROM employee WHERE ((dno = 4 AND salary > 25000) OR (dno = 5 AND salary > 30000));

-- 9
SELECT * FROM employee WHERE dob <= '1973-01-01';

SELECT *, EXTRACT (YEAR FROM age(dob)) AS age FROM employee
WHERE EXTRACT (YEAR FROM age(dob)) >= 50;

-- Queries based on JOIN operations

-- 1
-- WITH NATURAL JOIN
SELECT eno, ename, dname FROM employee
NATURAL JOIN department;

-- WITHOUT NATURAL JOIN
SELECT eno, ename, dname FROM employee
JOIN department ON employee.dno = department.dno;

-- 2
SELECT DISTINCT ename, salary FROM employee
JOIN (SELECT super_eno FROM employee) AS temp ON employee.eno = temp.super_eno
WHERE gender = 'F';

-- 3
-- WITH NATURAL JOIN
SELECT DISTINCT ename, salary FROM employee
NATURAL JOIN department
WHERE employee.eno = department.mgr_eno AND gender = 'F';

-- WITHOUT NATURAL JOIN
SELECT DISTINCT ename, salary FROM employee
JOIN department ON employee.dno = department.dno
WHERE employee.eno = department.mgr_eno AND gender = 'F';

-- 4
-- WITH NATURAL JOIN
SELECT e1.* FROM employee AS e1
NATURAL JOIN department
JOIN employee AS e2 ON e2.eno = department.mgr_eno
WHERE e1.salary > e2.salary;

-- WITHOUT NATURAL JOIN
SELECT e1.* FROM employee AS e1
JOIN department ON department.dno = e1.dno
JOIN employee AS e2 ON e2.eno = department.mgr_eno
WHERE e1.salary > e2.salary;

-- 5
SELECT DISTINCT * FROM employee 
JOIN works_on ON employee.eno = works_on.eno
JOIN project on works_on.pno = project.pno
WHERE project.dno = 4;

-- 6
SELECT emp.ename, super.ename AS supervisor FROM employee AS emp
LEFT JOIN employee AS super ON emp.super_eno = super.eno;

-- 7
SELECT DISTINCT employee.eno, employee.ename FROM employee 
JOIN works_on ON employee.eno = works_on.eno
JOIN project ON works_on.pno = project.pno
JOIN department ON project.dno = department.dno
WHERE dname = 'Research';

-- Queries based on SET operations

-- 1
-- Method 1
SELECT eno, ename, salary FROM employee WHERE dno = 4
UNION
SELECT eno, ename, salary FROM employee WHERE dno = 5;

-- Method 2
SELECT eno, ename, salary FROM employee WHERE dno = 4 OR dno = 5;

-- 2
SELECT eno FROM employee
EXCEPT
SELECT mgr_eno FROM department;

-- 3
SELECT eno, ename, salary FROM employee
NATURAL JOIN
(
	SELECT eno FROM employee
	EXCEPT
	SELECT mgr_eno FROM department
) AS temp;

-- 4
SELECT eno, ename, salary FROM employee
NATURAL JOIN
(
	SELECT eno FROM employee
	WHERE dno = 4
	
	UNION
	
	SELECT eno FROM works_on NATURAL JOIN project 
	WHERE dno = 4

) AS temp;

-- 5
SELECT eno, ename FROM employee
NATURAL JOIN
(
	SELECT eno FROM employee
	INTERSECT
	SELECT eno FROM works_on
	
) AS temp;

-- 6
SELECT eno, ename, salary FROM employee
NATURAL JOIN 
(
	SELECT eno FROM employee
	INTERSECT
	SELECT super_eno FROM employee
	EXCEPT
	SELECT mgr_eno FROM department
)AS temp;

SELECT eno, ename, salary FROM employee
NATURAL JOIN 
(
	SELECT super_eno AS eno FROM employee
	EXCEPT
	SELECT mgr_eno FROM department
)AS temp;

-- 7
SELECT eno, ename, salary FROM employee
NATURAL JOIN 
(
	SELECT eno FROM employee
	INTERSECT
	(
		SELECT super_eno FROM employee
		UNION
		SELECT mgr_eno FROM department
		
		EXCEPT 
		
		SELECT super_eno FROM employee
		INTERSECT
		SELECT mgr_eno FROM department
	)
)AS temp;
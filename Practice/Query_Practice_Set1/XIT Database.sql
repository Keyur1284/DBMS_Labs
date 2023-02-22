SET SEARCH_PATH TO xit1;

SELECT * FROM student;
SELECT * FROM program;
SELECT * FROM department;

-- Queries based on Selection and Project operations

-- 1
SELECT studid, name FROM STUDENT WHERE progid = 'BCS' AND cpi > 7.5;

-- 2
SELECT studid, name FROM STUDENT WHERE (progid = 'BCS' OR progid = 'BIT') AND cpi > 7.5;

-- Queries based on JOIN operations

-- 1
-- WITH NATURAL JOIN
SELECT pname, dname FROM student 
JOIN program ON progid = pid
NATURAL JOIN department;

-- WITHOUT NATURAL JOIN
SELECT pname, dname FROM student 
JOIN program ON progid = pid
JOIN department ON program.did = department.did;

-- 2
SELECT * FROM student
JOIN program ON progid = pid
WHERE did = 'CS';

-- 3
SELECT name, pname FROM student
JOIN program ON progid = pid;

-- 4
SELECT name, pname FROM student
JOIN program ON progid = pid
WHERE cpi > 7.5;

-- 5
-- WITH NATURAL JOIN
SELECT dname FROM student 
JOIN program ON progid = pid
NATURAL JOIN department
WHERE studid = '123';

-- WITHOUT NATURAL JOIN
SELECT dname FROM student 
JOIN program ON progid = pid
JOIN department ON program.did = department.did
WHERE studid = '123';

-- 6
SELECT studid, name FROM student
JOIN program ON progid = pid
WHERE pname = 'BTech(CS)' OR pname = 'BTech(ECE)';
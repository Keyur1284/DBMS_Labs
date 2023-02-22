SET SEARCH_PATH TO acad;

SELECT * FROM offers;
SELECT * FROM instructor;
SELECT * FROM student;
SELECT * FROM registers;
SELECT * FROM course;
SELECT * FROM program;
SELECT * FROM result;

-- 1
SELECT instructorid, instructorname FROM (instructor NATURAL JOIN offers) 
WHERE semester = 'Autumn' AND acadyear = 2010;

-- 2
SELECT studentid, name FROM (student NATURAL JOIN registers)
WHERE batch = 2008 AND semester = 'Autumn' AND acadyear = 2008 AND courseno = 'MT101';

-- 3
SELECT studentid, name FROM (student NATURAL JOIN registers)
WHERE progid = '01' AND batch = 2008 AND semester = 'Autumn' 
AND acadyear = 2008 AND courseno = 'MT101';

-- 4
SELECT * FROM course 
NATURAL JOIN
(
	SELECT courseno FROM offers
	EXCEPT
	SELECT courseno FROM registers
	
) AS temp;

-- 5
SELECT studentid, name, courseno, grade FROM student
NATURAL JOIN registers
WHERE grade = 'F' AND acadyear = 2008 AND semester = 'Autumn';

-- 6
SELECT course.* FROM course NATURAL JOIN offers
WHERE instructorid = 'PMJ' AND acadyear = 2010 AND semester = 'Winter';

-- 7
SELECT studentid, acadyear, course.*, grade  FROM student 
NATURAL JOIN registers NATURAL JOIN course
WHERE studentid = '200711002' AND acadyear = 2008;

-- 8
SELECT studentid FROM student NATURAL JOIN 
(
	SELECT studentid FROM registers
	WHERE courseno = 'MT101'
	INTERSECT 
	SELECT studentid FROM registers
	WHERE courseno = 'MT104'
	
) AS temp;

-- 9
SELECT studentid FROM student NATURAL JOIN 
(
	SELECT studentid FROM registers
	WHERE courseno = 'MT101'
	EXCEPT 
	SELECT studentid FROM registers
	WHERE courseno = 'MT104'
	
) AS temp;
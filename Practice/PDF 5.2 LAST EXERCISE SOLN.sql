SET SEARCH_PATH TO company3;
 
 SELECT * FROM employee WHERE eno IN
 (SELECT super_eno FROM employee WHERE super_eno NOT IN (SELECT mgr_eno FROM department));
 
 SELECT * FROM employee NATURAL JOIN
 (
	 (SELECT eno FROM employee
	 INTERSECT
	 SELECT super_eno FROM employee)
	 EXCEPT
	 SELECT mgr_eno FROM department
	 
 )AS ANS;
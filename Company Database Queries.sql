SET SQL_SAFE_UPDATES=0;

SELECT * FROM department;

SELECT * FROM department WHERE DNAME = "Administration";

SELECT * FROM department CROSS JOIN employee;

SELECT * FROM department INNER JOIN employee;

SELECT * FROM department RIGHT JOIN employee ON department.MGRSSN = employee.SSN;

SELECT * FROM department LEFT JOIN employee ON department.MGRSSN = employee.SSN;

SELECT works_on.PNO, employee.SSN FROM works_on LEFT JOIN employee ON employee.SSN = works_on.ESSN WHERE (employee.SALARY) > 43000;

SELECT COUNT(ESSN), ESSN FROM works_on WHERE ESSN = 123456789 GROUP BY ESSN HAVING COUNT(ESSN) > 1 ;

DELETE d1 FROM department d1 INNER JOIN department d2 WHERE  d1.MGRSSN < d2.MGRSSN AND d1.DNAME = d2.DNAME;
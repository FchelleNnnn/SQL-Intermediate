
SELECT * FROM employee_join; 
SELECT * FROM department_join;
SELECT * FROM manager;
SELECT * FROM projects;

-- INNER JOIN 
-- Fetch the employee name and the department name they belong to.

SELECT a.emp_name , b.dept_name
FROM employee_join a 
JOIN department_join b ON a.dept_id = b.dept_id

--LEFT JOIN
-- Fetch ALL the employee and the department name they belong to 

SELECT a.emp_name , b.dept_name
FROM employee_join a 
LEFT JOIN department_join b ON a.dept_id = b.dept_id

-- RIGHT JOIN

SELECT a.emp_name , b.dept_name
FROM employee_join a 
RIGHT JOIN department_join b ON a.dept_id = b.dept_id

-- Fetch details of all employees, their manager, their department name and the projects they work on

SELECT emp_name , dept_name , manager_name , project_name
FROM employee_join a
LEFT JOIN department_join  b ON a.dept_id = b.dept_id
LEFT JOIN manager c ON a.manager_id = c.manager_id
LEFT JOIN projects d ON d.team_member_id = a.emp_id


--PART 2
SELECT * FROM employee_join; 
SELECT * FROM department_join;
SELECT * FROM company;
SELECT * FROM family;

-- FULL JOIN
-- Write a query to fetch the employee name and their corresponding departname. 
--Make sure to include all the employees and departments

SELECT emp_name , dept_name
FROM employee_join a 
FULL JOIN department_join b ON a.dept_id = b.dept_id

-- CROSS JOIN
SELECT emp_name , dept_name
FROM employee_join a -- 10 records
CROSS JOIN department_join -- 4 records
ORDER BY emp_name; -- hence 10 * 4 = 40

SELECT emp_name , company_name, location
FROM employee_join
CROSS JOIN company
ORDER BY emp_name;

--NATURAL JOIN
SELECT emp_name , dept_name
FROM employee_join
NATURAL JOIN department_join ;

-- SELF JOIN
--give proper alias to the table
--Write a query to fetch the child name and their age corresponding to their parent name and parent age.
SELECT * FROM family
SELECT child.name as "Name of the child", child.age as "Age of the child" ,
parent.name as "Name of the parent", parent.age as "Age of the parent"
FROM family child
JOIN family parent ON child.parent_id = parent.member_id -- intersect of the common column??







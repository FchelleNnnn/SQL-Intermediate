
/* WINDOW FUNCTION */

SELECT * FROM employee_window;

SELECT e.* , 
MAX(salary) OVER(PARTITION BY dept_name) AS "Max Salary"
FROM employee_window e

--ROW_NUMBER()

SELECT  * ,
ROW_NUMBER() OVER () AS RN
FROM employee_window ;

--assign a number based on different department

SELECT  * ,
ROW_NUMBER() OVER (PARTITION BY dept_name) AS RN --gets reset when it moves to diff dept
FROM employee_window ;

-- Fetch the first 2 employees who joined the company from each department
-- Assumption is the lower the mumber in the emp_id , the earlier their join date

SELECT a.*
FROM
(
SELECT  * ,
ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY emp_id) AS RN --gets reset when it moves to diff dept
FROM employee_window 
) a
WHERE RN < 3 ;

--RANK()
--Fetch the top 3 employees in each department earning the max salary

SELECT a.*
FROM
(
SELECT * , 
RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) as RNK
FROM employee_window
) a WHERE rnk < 4

--DENSE RANK()

SELECT a.*
FROM
(
SELECT * , 
DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) as RNK
FROM employee_window
) a WHERE rnk < 4

-- LEAD AND LAG
-- Fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.

SELECT a.* ,
CASE
	WHEN a.salary > a.prev_emp_salary THEN 'Higher'
	WHEN a.salary < a.prev_emp_salary THEN 'Lower'
	WHEN a.salary = a.prev_emp_salary THEN 'Equal'
	ELSE NULL
	END as "Category"
FROM 
(
SELECT *, 
LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) AS Prev_emp_salary , --2 arguments can be passed
LEAD(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) AS next_emp_salary
FROM employee_window 
) a

-- WINDOW FUNCTION PART 2 

SELECT * FROM product;
--FIRST VALUE 
--Write a query to display the most expensive product under each category (corresponding to each record)
SELECT *  , 
FIRST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY price DESC) as most_expensive 
FROM product;

--LAST VALUE
-- Write a query to display the least expensive product under each category (corresponding to each record)
--with a combination of FRAME CLAUSE
SELECT *  , 
FIRST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY price DESC) as most_expensive ,
LAST_VALUE(product_name) 
	OVER (PARTITION BY product_category ORDER BY price DESC
		 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as least_expensive --does not satisfy the req
FROM product;
-- to satisfy the requirement
SELECT *  , 
FIRST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY price DESC) as most_expensive ,
LAST_VALUE(product_name) 
	OVER (PARTITION BY product_category ORDER BY price DESC
		 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as least_expensive 
FROM product;

-- when current row in the upper bound is replaced
--difference of range and rows

SELECT *  , 
FIRST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY price DESC) as most_expensive ,
LAST_VALUE(product_name) 
	OVER (PARTITION BY product_category ORDER BY price DESC
		 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as least_expensive 
FROM product;

--Alternate way to write a query in the window function




--19:03











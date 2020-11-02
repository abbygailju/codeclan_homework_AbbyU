-- MVP

--Q1
SELECT *
FROM employees 
WHERE department = 'Human Resources';

--Q2
SELECT first_name,
	last_name,
	country
FROM employees 
WHERE department = 'Legal';

--Q3
SELECT COUNT(*)
FROM employees 
WHERE country = 'Portugal';

--	Q4
SELECT COUNT(*)
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';

--Q5
SELECT COUNT(id)
FROM employees 
WHERE pay_detail_id IS NULL

--Q6
SELECT first_name, last_name
FROM employees 
ORDER BY last_name NULLS LAST;

--Q7
SELECT COUNT(id)
FROM employees 
WHERE first_name LIKE 'F%';

--Q8
SELECT COUNT(id)
FROM employees 
WHERE (country != 'France' OR country != 'Germany') AND (pension_enrol = TRUE );

--Q9
SELECT COUNT(id) AS num_of_employees, department
FROM employees 
WHERE start_date > '2003-01-01'
GROUP BY department;

--Q10
SELECT department, fte_hours, COUNT(id) AS num_of_employees
FROM employees 
GROUP BY department, fte_hours 
ORDER BY department, fte_hours ;

--Q11
SELECT department, COUNT(id) AS num_of_unnamed_employees
FROM employees 
WHERE first_name IS NULL 
GROUP BY department 
HAVING COUNT(id) > 2;

--Q12



-- Extension




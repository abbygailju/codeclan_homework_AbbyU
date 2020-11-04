--MVP
--Q1
SELECT *
FROM pay_details 
WHERE iban IS NULL AND local_account_no = NULL;

--Q2
SELECT country,
	first_name,
	last_name
FROM employees 
ORDER BY country ASC NULLS LAST, last_name ASC NULLS LAST;

--Q3
SELECT *
FROM employees 
ORDER BY salary DESC NULLS LAST LIMIT 10;

--Q4
SELECT first_name,
	last_name,
	salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST LIMIT 1;

--Q5
SELECT *
FROM employees 
WHERE email LIKE '%@yahoo%';

--Q6
SELECT COUNT(id) AS number_of_employees, 
	CAST(pension_enrol AS varchar) AS pension_enrolled
FROM employees 
GROUP BY pension_enrol;

--Q7
SELECT salary 
FROM employees 
WHERE department = 'Engineering' AND fte_hours = '1'
ORDER BY salary DESC NULLS LAST LIMIT 1;

--Q8
SELECT 
	country,
	COUNT(id) AS number_of_employees,
	AVG(salary) AS average_salary
FROM employees  
GROUP BY country 
HAVING COUNT(id)  > 30
ORDER BY AVG(salary) DESC NULLS LAST;

--Q9
SELECT first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary  AS effective_yearly_salary
FROM employees 
	
--Q10
SELECT e.first_name,
	e.last_name
FROM employees AS e RIGHT JOIN pay_details AS pd 
ON 'id' = 'id'
WHERE pd.local_tax_code IS NULL

--Q11
SELECT e.*,
(48 * 35 * CAST(t.charge_cost AS INT) - e.salary) * e.fte_hours AS expected_profit
FROM employees AS e LEFT JOIN teams AS t 
ON e.team_id = t.id

--Q12
SELECT e.id,
	e.first_name,
	e.last_name,
	e.salary,
	e.fte_hours,
	e.salary / AVG (e.salary) OVER (PARTITION BY e.department) AS average_salary_ratio,
	e.fte_hours / AVG (e.fte_hours) OVER (PARTITION BY e.department) AS ratio_department_hours
FROM employees AS e LEFT JOIN (SELECT department, COUNT(id) 
								FROM employees 
								GROUP BY department 
								ORDER BY COUNT(id) DESC NULLS LAST LIMIT 1)  AS top
ON e.department = top.department

----- EXTENSIONS
--Q1
SELECT first_name,
COUNT(*) AS same_names_count
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name 
HAVING COUNT(id) > 1
ORDER BY COUNT(id) DESC, first_name ASC;

--Q2


--Q3
SELECT e.first_name,
		e.last_name,
		e.email,
		e.start_date
FROM (employees AS e INNER JOIN employees_committees AS ec
ON e.id = ec.employee_id ) INNER JOIN committees AS c
ON ec.committee_id = c. id
WHERE c.name = 'Equality and Diversity'
ORDER BY e.start_date ASC NULLS LAST

--Q4


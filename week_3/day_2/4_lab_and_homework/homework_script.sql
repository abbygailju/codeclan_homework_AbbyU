---- MVP
-- Q1 
SELECT e.*,
pd.local_account_no ,
pd.local_sort_code 
FROM employees AS e INNER JOIN pay_details AS pd
ON e.id = pd.id

--Q2
SELECT e.*,
t.name AS team_name,
pd.local_account_no ,
pd.local_sort_code 
FROM (employees AS e INNER JOIN pay_details AS pd 
ON e.id = pd.id) INNER JOIN teams as t
ON t.id = e.team_id;

--Q3
SELECT e.first_name,
		e.last_name,
		t.charge_cost,
		t.name AS team_name
FROM (employees AS e INNER JOIN pay_details AS pd 
ON e.id = pd.id) INNER JOIN teams as t
ON t.id = e.team_id 
WHERE CAST(t.charge_cost AS INT) > 80
ORDER BY e.last_name ASC NULLS LAST;

--Q4
SELECT 
		t.name AS team_name,
		COUNT(e.id) AS team_size
FROM (employees AS e INNER JOIN pay_details AS pd 
ON e.id = pd.id) INNER JOIN teams as t
ON t.id = e.team_id
GROUP BY t.name
ORDER BY COUNT(e.id);

--Q5
SELECT 
	id,
	first_name,
	last_name,
	SUM(fte_hours * salary) AS effective_salary,
	SUM(fte_hours * salary) OVER (ORDER BY SUM(fte_hours * salary)) AS running_total
FROM employees
GROUP BY id;

--Q6
	
SELECT 
	t.name AS team_name,
	COUNT(e.id) * CAST(t.charge_cost AS INT) AS total_day_charge
FROM employees AS e INNER JOIN teams as t
ON t.id = e.team_id 
GROUP BY t.id

--Q7
SELECT 
	t.name AS team_name,
	COUNT(e.id) * CAST(t.charge_cost AS INT) AS total_day_charge
FROM employees AS e INNER JOIN teams as t
ON t.id = e.team_id 
GROUP BY t.id
HAVING COUNT(e.id) * CAST(t.charge_cost AS INT) > 5000


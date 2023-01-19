SELECT * FROM customers
SELECT * FROM sales
SELECT * FROM salaries
SELECT * FROM employees
-- Top 5 most profitable customers


SELECT customer_name, state, b.total_profit
from customers a
INNER JOIN
(SELECT customer_id, ROUND(SUM(profit),2) as total_profit
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5) b
ON a.customer_id=b.customer_id
ORDER BY b.total_profit DESC;

--Average salary by gender

SELECT a.gender, ROUND(AVG(salary),2) AS avg_by_gender, (SELECT ROUND(AVG(salary),2) from Salaries) AS total_avg
FROM employees AS a
JOIN salaries AS b
ON a.emp_no=b.emp_no
GROUP BY a.gender
ORDER BY avg_by_gender DESC

--- Average profit by ship mode

SELECT ship_mode, count(*) , ROUND(avg(profit),2) avg_profit
from sales
group by ship_mode
order by avg_profit DESC


--- Average sales for by category

SELECT a.category, count(*), ROUND(AVG(sales),2) as avg_total_sales
from sales a
WHERE a.customer_id IN (SELECT customer_id from customers)
group by a.category
order by avg_total_sales DESC


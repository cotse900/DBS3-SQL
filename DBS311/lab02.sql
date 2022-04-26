--1
SELECT first_name || ' ' || last_name as "full name", round((sysdate - hire_date)/7) as "Weeks employed"
FROM employees;
--2
Select order_id as "Order ID", add_months(order_date,1) as "Next Order Date", add_months(order_date,-1) as "Previous Order Date" from orders
order by order_id;
--3
Select * from countries WHERE upper(country_name) LIKE 'I%';
--4
Select unit_price, round(unit_price), trunc(unit_price), floor(unit_price)
from order_items;
--5
Select lpad(region_name,4) from regions;
--6
Select employee_id, substr(first_name,3), substr(last_name,3) from employees order by employee_id;
--7
Select next_day(order_date,'Sunday'), last_day(order_date) from orders;
--8
Select email, hire_date, add_months(hire_date,3) as "3 months added" from employees;
--9
Select email, hire_date, months_between(sysdate,hire_date) as "#months" from employees;
--10
SELECT LOWER(job_title) AS "Lower",
UPPER(first_name) AS "upper",
INITCAP(email) AS "Initcap"
FROM employees
WHERE manager_id = 2;

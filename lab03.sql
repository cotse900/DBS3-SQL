--1
Select count(*) as "Number of Customers", sum(credit_limit) from customers;
--2
Select min(credit_limit), max(credit_limit), avg(credit_limit) from customers;
--3
Select count(distinct salesman_id), count(distinct customer_id) from orders;
--4
Select max(hire_date) as "Newest employee employed on", 
min(hire_date) as "Oldest employee employed on" from employees;
--5
Select min(first_name) as "First in line employee", max(first_name) as "Last in line employee" from employees;
--6
Select distinct last_name, count(distinct last_name) as "Last name ends with G" from employees 
where UPPER(last_name) like 'G%' or UPPER(last_name) like '%G' group by last_name;
--7
Select distinct salesman_id, count(salesman_id) from orders group by salesman_id;
--8
Select round(avg(unit_price),3), item_id from order_items group by item_id order by 2;
--9
Select item_id, sum(quantity) from order_items group by item_id order by 1;
--10
Select name, customer_id, count (*) over() as "Credit limit above 4000" from customers where credit_limit > 4000;

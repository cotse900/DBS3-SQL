--1
Select last_name, employee_id, hire_date from employees where employee_id > (Select employee_id from employees where last_name like 'Dunn')
and hire_date > (Select hire_date from employees where employee_id = 10);
--2
Select name, customer_id, credit_limit from customers where customer_id > (select customer_id from customers where name like 'Facebook')
and credit_limit < (select credit_limit from customers where name like 'United Continental Holdings');
--3
Select name, customer_id, credit_limit from customers where credit_limit = (select max(credit_limit) from customers);
--4
Select order_id, customer_id, order_date from orders where order_date > (select min(order_date) from orders)
and order_date < (select order_date from orders where order_id = 77);
--5
Select customer_id, min(order_date) from orders group by customer_id
having min(order_date) < (select min(order_date) from orders where customer_id = 1);
--6
Select quantity, round(unit_price,3), item_id, count (*) over(partition by item_id) from order_items group by item_id, unit_price, quantity
having unit_price > (select avg(min(unit_price)) from order_items group by item_id);

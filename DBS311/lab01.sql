--3) Write a SELECT query for each of the table created to display all the values of the tables and sort them descending with their primary keys (Hint: the number of SELECT queries depend on the number of tables created)
Select * from contacts order by contact_id desc;
Select * from countries order by country_id desc;
Select * from customers order by customer_id desc;
Select * from employees order by employee_id desc;
Select * from inventories order by product_id desc;
Select * from locations order by location_id desc;
Select * from order_items order by order_id desc;
Select * from orders order by order_id desc;
Select * from product_categories order by category_id desc;
Select * from products order by product_id desc;
Select * from regions order by region_id desc;
Select * from warehouses order by warehouse_id desc;

--4) Write a SQL statement to display DISTINCT credit limit for the customers table.
Select distinct credit_limit from customers;

--6) INSERT 2 rows of values to EMPLOYEES table. Makeup your own values and display the newly entered information
INSERT ALL
    INTO employees VALUES (108, 'Chungon', 'Tse', 'cotse@example.com', '647.182.3182', 
    to_date('23-DEC-20','DD-MON-RR'), 25, 'Shipping Clerk')
    INTO employees VALUES (109, 'Chungkwan', 'Tse', 'cktse@example.com', '647.318.2318',
    to_date('10-APR-21','DD-MON-RR'), 25, 'Shipping Clerk')
SELECT * FROM dual;

--7) Create an empty new EMPLOYEE table called “TESTEMPLOYEE” from the existing EMPLOYEE table. Display the contents of TESTEMPLOYEE. Now copy all the values from EMPLOYEE table to TESTEMPLOYEE and display the contents.
Create table testemployee as select * from employees where 1=2;
Insert into testemployee select * from employees;

--8) Write a SQL query to update ORDER_ITEMS quantity to 100 for the order ids in the range of 1 to 10
Update order_items set quantity = 100 where order_id between 1 and 10;
 
--9) Delete the newly inserted values in TESTEMPLOYEE table
Delete from testemployee where employee_id between 108 and 109;
 
--10) Using JOIN statements write the SQL query for the following data required
--a. Display all ORDER_ITEMS that are in common with ORDERS
Select order_items.order_id from order_items join orders on order_items.order_id = orders.order_id;
--b. Display all ORDER_ITEMS that are in common with PRODUCTS
Select order_items.product_id from order_items join products on order_items.product_id = products.product_id;
--c. Display all the ORDERS that are not in common with ORDER_ITEMS
Select * from orders left outer join order_items using (order_id) where item_id is null;
--d. Display all the PRODUCTS that are not in common with ORDER_ITEMS
Select * from products left outer join order_items using (product_id) where item_id is null;

-- Q1 SOLUTION – divide by 100
CREATE OR REPLACE PROCEDURE divideby100 (yournum in number)
as
BEGIN
if mod(yournum, 100) = 0
then dbms_output.put_line('The number is divisible by 100');
else
dbms_output.put_line('The number is not divisible by 100');
end if;
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.PUT_LINE ('Error!');
END divideby100;
BEGIN
divideby100(&input);
end;

-- Q2 SOLUTION – find employee
CREATE OR REPLACE PROCEDURE find_employee (empid number)
IS fname varchar2(255 byte);
lname varchar2(255 byte);
email_ varchar2(255 byte);
phone_ varchar2(50 byte);
hire date;
jobt varchar2(255 byte);
BEGIN
Select first_name, last_name, email, phone, hire_date, job_title
into fname, lname, email_, phone_, hire, jobt
from employees
where employee_id = empid;
DBMS_OUTPUT.PUT_LINE ('First name: ' || fname);
DBMS_OUTPUT.PUT_LINE ('Last name: ' || lname);
DBMS_OUTPUT.PUT_LINE ('Email: ' || email_);
DBMS_OUTPUT.PUT_LINE ('Phone: ' || phone_);
DBMS_OUTPUT.PUT_LINE ('Hire date: ' || to_char(hire, 'dd-MON-yy'));
DBMS_OUTPUT.PUT_LINE ('Job title: ' || jobt);
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.PUT_LINE ('Error!');
END find_employee;

begin
find_employee(&input);
end;

-- Q3 SOLUTION – update price category
Create or Replace procedure update_price_category
IS list_price products.list_price%type;
category_id products.category_id%type;
prod_type number;
amount number(9,2);
BEGIN
prod_type := 1;
amount := 5.00;
update products
set list_price = list_price + amount
where category_id = prod_type
AND list_price > 0;
IF SQL%ROWCOUNT > 0 THEN
dbms_output.put_line(SQL%ROWCOUNT || ' entries in the products table for category type ' || prod_type || ' have been changed by $' || amount);
ELSE
dbms_output.put_line('There is no updated row in the products table.');
END IF;
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.PUT_LINE ('Error!');
END update_price_category;

begin
update_price_category();
end;

-- Q4 SOLUTION – update low prices
Create or Replace procedure update_low_prices_154928188
IS pid products.product_id%type;
lprice products.list_price%type;
avgp number(9,2);
BEGIN
    Select avg(list_price) into avgp from products;
    IF avgp <= 1000
        THEN
            update products
            set list_price = list_price*1.02 where list_price < avgp;
                dbms_output.put_line('***OUTPUT update_low_prices_154928188 STARTED***');
                dbms_output.put_line('Number of updates: ' ||SQL%rowcount);
                dbms_output.put_line('----ENDED----');
        ELSE
            update products
            set list_price = list_price*1.01 where list_price < avgp;
                dbms_output.put_line('***OUTPUT update_low_prices_154928188 STARTED***');
                dbms_output.put_line('Number of updates: ' ||SQL%rowcount);
                dbms_output.put_line('----ENDED----');
        END IF;
            EXCEPTION
            WHEN OTHERS
            THEN
            DBMS_OUTPUT.PUT_LINE ('Error!');
END update_low_prices_154928188;

begin
update_low_prices_154928188();
end;

-- Q5 SOLUTION – price report
Create or Replace procedure price_report_154928188
IS lprice products.list_price%type;
avg_price number(9,2);
min_price number(9,2);
max_price number(9,2);
low_count number;
fair_count number;
high_count number;
BEGIN
    Select avg(list_price), min(list_price), max(list_price) into avg_price, min_price, max_price from products;
    Select count(list_price) into low_count from products where list_price < (avg_price-min_price)/2;
    Select count(list_price) into high_count from products where list_price > (max_price-avg_price)/2;
    Select count(list_price) into fair_count from products where list_price <= (max_price-avg_price)/2 and list_price >= (avg_price-min_price)/2;
        dbms_output.put_line('Low: ' || low_count);
        dbms_output.put_line('High: ' || high_count);    
        dbms_output.put_line('Fair: ' || fair_count);
    EXCEPTION
    WHEN OTHERS
    THEN
    DBMS_OUTPUT.PUT_LINE ('Error!');
END price_report_154928188;

begin
price_report_154928188();
end;

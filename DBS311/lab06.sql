-- Q1 SOLUTION – calculate salary
CREATE OR REPLACE PROCEDURE calculate_salary (empid number)
as
base_salary number(8,2);
salary number(8,2);
fName employees.first_name%type;
lName employees.last_name%type;
hDate employees.hire_date%type;
work_years number;
counter number;
BEGIN
base_salary := 10000;
counter := work_years;
select first_name, last_name, floor((to_date(sysdate, 'dd-MON-yy') - to_date(hire_date, 'dd-MON-yy'))/365)
into fName, lName, work_years
from employees
where employee_id = empid;
  FOR i IN 1..work_years LOOP
    IF i <= work_years THEN
      base_salary := base_salary*(1.05);
    END IF;
  END LOOP;
    dbms_output.put_line('First Name: ' || fName);
    dbms_output.put_line('Last Name: ' || lName);
    dbms_output.put_line('Salary: $' || base_salary);
EXCEPTION
WHEN OTHERS
  THEN
    DBMS_OUTPUT.PUT_LINE ('Employee ID ' || empid || ' does not exist.');
END calculate_salary;
BEGIN
calculate_salary(&input);
end;

-- Q2 Solution – employee works here
Alter table employees
add Department varchar2(255 byte);

Update employees set department = case
when job_title like '%Stock%' then 'Stock'
when job_title like '%Sales%' then 'Sales'
when job_title like '%Account%' or job_title like '%Finance%' then 'Finance'
when job_title like '%Shipping%' then 'Shipping'
when job_title like '%Purchasing%' then 'Purchasing'
when job_title like '%Programmer%' then 'Programming'
when job_title like '%Marketing%' then 'Marketing'
when job_title like '%Programmer%' then 'Programming'
when job_title like '%Human Resources%' then 'Human Resources'
when job_title like '%Public Relations%' then 'Public Relations'
end

CREATE OR REPLACE PROCEDURE employee_works_here (chiffre number)
AS
  empid employees.employee_id%type;
  lName employees.last_name%type;
  dept employees.department%type;
BEGIN
  select employee_id, last_name, department into empid, lName, dept from employees where
  employee_id = chiffre;
  dbms_output.put_line('Employee #/Last Name/' || rpad(' ',5,' ') || 'Department Name');
    IF dept is not null THEN
    dbms_output.put_line(empid || rpad(' ',9,' ')  || lName || rpad(' ',8,' ') || dept);
    ELSE
    dbms_output.put_line(empid || rpad(' ',9,' ')  || lName || rpad(' ',8,' ') || 'No Department');
    END IF;
  EXCEPTION
  WHEN OTHERS
    THEN
      dbms_output.put_line('Employee ID ' || chiffre || ' does not exist.');
END employee_works_here;

BEGIN
employee_works_here(&input);
end;

-- Q3 Solution – credit limit list
DECLARE
  idi customers.customer_id%type;
  name customers.name%type;
  cred customers.credit_limit%type;
  CURSOR cust IS
    SELECT customer_id, name, credit_limit FROM customers order by customer_id;
BEGIN
  dbms_output.put_line('Customer ID/Name/Status/Credit Limit');
  FOR customer IN cust
  LOOP
    IF customer.credit_limit < 1000 THEN
      dbms_output.put_line(customer.customer_id || '/' || customer.name || '/' || 'new customers' || '/' || customer.credit_limit);
    ELSIF
      customer.credit_limit > 4000 THEN
      dbms_output.put_line(customer.customer_id || '/' || customer.name || '/' || 'credit approved for new increase' || '/' || customer.credit_limit);
      ELSE
        dbms_output.put_line(customer.customer_id || '/' || customer.name || '/' || 'existing customers' || '/' || customer.credit_limit);
      END IF;
  END LOOP;
  IF cust%ISOPEN THEN
    CLOSE cust;
  END IF;
END;

-- Q4 Solution -- order id and status

DECLARE
  orid orders.order_id%type;
  status orders.status%type;
  salesguy orders.salesman_id%type;
  dept employees.job_title%type;
  flag boolean := true;
  counter number := 1;
  cnt number;
BEGIN
  dbms_output.put_line('Order ID/Status/Sales ID/Dept');
  select count(*) into cnt from orders;
  WHILE counter <= cnt
  LOOP
  select order_id, status, salesman_id, job_title 
  into orid, status, salesguy, dept
  from orders left outer join
    employees on orders.salesman_id = employees.employee_id
    where order_id = counter;
      IF salesguy is null THEN
      dbms_output.put_line(orid || '/' || status || '/' || 'nil' || '/' || 'nil');
      ELSE
      dbms_output.put_line(orid || '/' || status || '/' || salesguy || '/' || dept);
      END IF;
    counter := counter + 1;
    IF counter > cnt THEN
      flag := false;
    END IF;
  END LOOP;
END;

-- Q5 Solution -- Products table QOH
alter table products
add QOH number(9,2);

DECLARE
  product_id products.product_id%type;
  list_price products.list_price%type;
  new_price products.QOH%type;
  cnt number;
  total number;
  CURSOR np IS
    SELECT list_price, new_price, product_id from products order by product_id;
BEGIN
  OPEN np;
  Select count(*) into total from products;
  dbms_output.put_line('List Price - New Price - Product ID');
  LOOP
    FETCH np into list_price, new_price, product_id;
    EXIT WHEN np%NOTFOUND;
    CASE
      WHEN list_price < 50 THEN new_price := list_price + 30;
        dbms_output.put_line(round(list_price,2) || rpad(' ',8,' ') || new_price || lpad(' ',9,' ') || product_id);
        update products set qoh = list_price+30;
      WHEN list_price >= 50 and list_price <= 100 THEN new_price := list_price + 50;
        dbms_output.put_line(round(list_price,2) || rpad(' ',8,' ') || new_price || lpad(' ',9,' ') || product_id);
        update products set qoh = list_price+50;
      WHEN list_price >= 200 and list_price < 500 THEN new_price := list_price + 150;
        dbms_output.put_line(round(list_price,2) || rpad(' ',8,' ') || new_price || lpad(' ',9,' ') || product_id);
        update products set qoh = list_price+150;
      ELSE new_price := list_price + 200;
      dbms_output.put_line(round(list_price,2) || rpad(' ',8,' ') || new_price || lpad(' ',9,' ') || product_id);
      update products set qoh = list_price+200;
    END CASE;
  END LOOP;
  CLOSE np;
END;

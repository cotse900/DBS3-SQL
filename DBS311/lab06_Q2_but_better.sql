--I don't own this code but I think this anon author deserves honorable mention here. My Q2 was for only one ID and it did not exactly cut it. This guy was correct.
--Q2
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE employee_works_here AS
empId employees.employee_id%type;
lname employees.last_name%type;
jTitle employees.job_title%type;
minId employees.employee_id%type := 01;
maxId employees.employee_id%type := 107;
counter NUMBER := 0;
BEGIN
dbms_output.put_line(rpad('Employee #', 12)||rpad('Last Name', 20)||
rpad('Job title',20));
FOR employee IN (
SELECT employee_id, last_name, job_title
FROM employees
WHERE employee_id BETWEEN minId and maxId
ORDER BY employee_id
)
LOOP
empId := employee.employee_id;
lname := employee.last_name;
jTitle := employee.job_title;
IF jTitle = NULL THEN
jTitle := 'No job title';
END IF;
DBMS_OUTPUT.PUT_LINE(rpad(empId, 12) || rpad(lname, 20) ||
rpad(jTitle,20));
counter := counter +1;
END LOOP;
DBMS_OUTPUT.PUT_LINE (counter || ' rows returned.');
EXCEPTION
WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE('No data found!');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error!');
END;
BEGIN
employee_works_here();
END;

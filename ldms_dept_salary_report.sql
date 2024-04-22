SET VERIFY OFF

PROMPT Generating report showing the total of employee salary for a department

ACCEPT department_name PROMPT 'Enter the name of the department: '

COLUMN dept_name HEADING "Department" FORMAT A20
COLUMN total_sal HEADING "Total Salary" FORMAT 9999999

SPOOL department_total_salary_report.txt

SELECT dept.dept_name, 
       SUM(emp.emp_salary) AS total_sal
FROM   employees emp, departments dept  
WHERE  emp.dept_id = dept.dept_id 
  AND  dept.dept_name = '&department_name'
GROUP BY dept.dept_name;

SPOOL OFF
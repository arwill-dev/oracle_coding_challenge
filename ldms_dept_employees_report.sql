SET VERIFY OFF

PROMPT Generating report showing all employees in a department

ACCEPT department_name PROMPT 'Enter the name of the department: '

COLUMN emp_id HEADING "Employee ID" FORMAT 99999
COLUMN emp_name HEADING "Employee Name" FORMAT A20
COLUMN emp_job_title HEADING "Job Title" FORMAT A20

SPOOL department_employees_report.txt

SELECT emp.emp_id,
	   emp.emp_name, 
	   emp.emp_job_title
FROM   employees emp, departments dept  
WHERE  emp.dept_id = dept.dept_id 
  AND  dept.dept_name = '&department_name'
ORDER BY emp_id;

SPOOL OFF
# oracle_coding_challenge

Build Instructions (Windows):

-- Copy all the files to a directory on your Windows machine.

-- Connect to SQL*Plus and run the four scripts from the directory in the following order.

@ldms_create_tables.sql

@ldms_insert_data.sql

@pkg_employee.pks

@pkg_employee.pkb



Run Instructions (Windows):

-- Please refer to the test plan (ldms_test_plan.txt) to see sample calls for each of the subprograms below.

-- To create a new employee, call the package function pkg_employee.create_employee.

-- To change an employee's salary, call the package procedure pkg_employee.change_salary.

-- To change an employee's department, call the package procedure pkg_employee.change_dept.

-- To get an employee's salary, call the package function pkg_employee.get_salary.



-- To generate the report showing all employees for a given department, run the script below. -- It will prompt for the department and then create a txt file with the requested data.

@ldms_dept_employees_report.sql



-- To generate the report showing the total of employee salary for a given department, run the script below. -- It will prompt for the department and then create a txt file with the requested data.

@ldms_dept_salary_report.sql



-- To rollback all the changes, run the script below.

@ldms_rollback.sql

/*****************************************************************
 Name        :  pkg_employee.pks                                           
 Description :  procedures and functions used to manage employees 
                                                                              
 Version    Date        Author                    Remarks                                    
 -------    ----------- -----------------------   ----------------
 1.0        21/04/2024  A W Ekundayo              Initial version
******************************************************************/

CREATE OR REPLACE PACKAGE pkg_employee AS 

-------------------------------------------------------------------------------
-- Creates a new employee record and returns the employee id for the new record
-------------------------------------------------------------------------------
FUNCTION create_employee (p_emp_name         IN employees.emp_name%TYPE, 
                          p_emp_job_title    IN employees.emp_job_title%TYPE,  
                          p_emp_date_hired   IN employees.emp_date_hired%TYPE, 
                          p_emp_salary       IN employees.emp_salary%TYPE, 
                          p_dept_id          IN employees.dept_id%TYPE,
						  p_emp_manager_id   IN employees.emp_manager_id%TYPE) RETURN employees.emp_id%TYPE;
											 

---------------------------------------------------------------------------------------
-- Changes the salary of an employee by a percentage.
-- Accepts positive or negative values to increase or decresase the salary respectively
---------------------------------------------------------------------------------------
PROCEDURE change_salary (p_emp_id            IN employees.emp_id%TYPE, 
                         p_percentage_change IN NUMBER);


-----------------------------------
-- Changes an employee's department
-----------------------------------
PROCEDURE change_dept (p_emp_id      IN employees.emp_id%TYPE, 
                       p_new_dept_id IN employees.dept_id%TYPE);

--------------------------------
-- Returns an employee's salary
--------------------------------
FUNCTION get_salary (p_emp_id IN employees.emp_id%TYPE) RETURN employees.emp_salary%TYPE;

END pkg_employee;
/



/*****************************************************************
 Name        :  pkg_employee.pkb                                           
 Description :  procedures and functions used to manage employees 
                                                                              
 Version    Date        Author                    Remarks                                    
 -------    ----------- -----------------------   ----------------
 1.0        21/04/2024  A W Ekundayo              Initial version
******************************************************************/

CREATE OR REPLACE PACKAGE BODY pkg_employee AS 

  ---------------------------------------------------------
  -- Private function to check that an employee id is valid
  ---------------------------------------------------------
  FUNCTION emp_is_valid (p_emp_id employees.emp_id%TYPE) RETURN BOOLEAN IS 
  
  v_emp_id employees.emp_id%TYPE;
  
  BEGIN 
    SELECT emp_id INTO v_emp_id  
	FROM employees 
	WHERE emp_id = p_emp_id;
	
    RETURN TRUE; 
  
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
	  RETURN FALSE;
  END emp_is_valid;
  
  ----------------------------------------------------------
  -- Private function to check that a department id is valid
  ----------------------------------------------------------
  FUNCTION dept_is_valid (p_dept_id departments.dept_id%TYPE) RETURN BOOLEAN IS 
  
  v_dept_id employees.dept_id%TYPE;
  BEGIN 
    SELECT dept_id INTO v_dept_id 
	FROM departments 
	WHERE dept_id = p_dept_id;
	
    RETURN TRUE; 
  
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
	  RETURN FALSE;
  END dept_is_valid;
  

  ------------------------------------------------------------------------------------------------
  -- Public function to create a new employee record and return the employee id for the new record
  ------------------------------------------------------------------------------------------------
  FUNCTION create_employee (p_emp_name         IN employees.emp_name%TYPE, 
                            p_emp_job_title    IN employees.emp_job_title%TYPE, 
                            p_emp_date_hired   IN employees.emp_date_hired%TYPE, 
                            p_emp_salary       IN employees.emp_salary%TYPE, 
                            p_dept_id          IN employees.dept_id%TYPE,
						    p_emp_manager_id   IN employees.emp_manager_id%TYPE) RETURN employees.emp_id%TYPE IS 
						  
    v_emp_id          employees.emp_id%TYPE;
	e_cannot_ins_null EXCEPTION;
	
	PRAGMA EXCEPTION_INIT(e_cannot_ins_null, -1400);
  
  BEGIN 
  
    -- check that the manager id is valid
    IF NOT emp_is_valid(p_emp_manager_id) THEN 
      RAISE_APPLICATION_ERROR (-20002, 'The manager ID is not valid.');
    END IF;
  
    -- check that the dept id is valid
    IF NOT dept_is_valid(p_dept_id) THEN 
      RAISE_APPLICATION_ERROR (-20003, 'The department ID is not valid.');
    END IF;
			  
    -- insert new employee record
    INSERT INTO employees (emp_id,
                           emp_name, 
                           emp_job_title, 
					       emp_manager_id, 
						   emp_date_hired, 
						   emp_salary, 
						   dept_id)
    VALUES (seq_emp.NEXTVAL,
            p_emp_name, 
		    p_emp_job_title, 
            p_emp_manager_id, 
		    p_emp_date_hired, 
		    p_emp_salary,
		    p_dept_id) RETURNING emp_id INTO v_emp_id;

    RETURN v_emp_id;		  
						
  EXCEPTION 
    WHEN e_cannot_ins_null THEN 
	  RAISE_APPLICATION_ERROR (-20001, 'NULL values are not allowed for the name, job title, date hired, salary or department.');
    
	-- When others handler will handler other errors by logging them and raising them to the calling environment.
    WHEN OTHERS THEN 
      --<add call to logging procedure>--
      RAISE;

  END create_employee;


  ---------------------------------------------------------------------------------------
  -- Public procedure to change the salary of an employee by a percentage.
  -- Accepts positive or negative values to increase or decresase the salary respectively
  ---------------------------------------------------------------------------------------
  PROCEDURE change_salary (p_emp_id            IN employees.emp_id%TYPE, 
                           p_percentage_change IN NUMBER) IS 
						   
	e_max_sal_exceeded EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_max_sal_exceeded, -1438);
	
  BEGIN 
    -- check that the employee id is valid
    IF NOT emp_is_valid(p_emp_id) THEN 
      RAISE_APPLICATION_ERROR (-20004, 'The employee ID is not valid.');
    END IF;
	
    -- update empployees table with new salary
    UPDATE employees 
	SET emp_salary = emp_salary + (emp_salary * (p_percentage_change/100))
    WHERE emp_id = p_emp_id;
	
  EXCEPTION 
    WHEN e_max_sal_exceeded THEN 
	  RAISE_APPLICATION_ERROR (-20005, 'You have exceeded the maximum allowed salary.');
	  
    -- When others handler will handler other errors by logging them and raising them to the calling environment.
    WHEN OTHERS THEN 
      --<add call to logging procedure>--
      RAISE;

  END change_salary;
  
  
  -----------------------------------
  -- Public procedure to change an employee's department
  -----------------------------------
  PROCEDURE change_dept (p_emp_id      IN employees.emp_id%TYPE, 
                         p_new_dept_id IN employees.dept_id%TYPE) IS 
						 
  BEGIN
						 
    -- check that the dept id is valid
    IF NOT dept_is_valid (p_new_dept_id) THEN 
      RAISE_APPLICATION_ERROR (-20003, 'The department ID is not valid.');
    END IF;

    -- check that the employee id is valid
    IF NOT emp_is_valid(p_emp_id) THEN 
      RAISE_APPLICATION_ERROR (-20004, 'The employee ID is not valid.');
    END IF;
	
    -- update employee's record with new dept id
    UPDATE employees 
	SET dept_id = p_new_dept_id
    WHERE emp_id = p_emp_id;
	
  EXCEPTION 
    -- When others handler will handler other errors by logging them and raising them to the calling environment.
    WHEN OTHERS THEN 
      --<add call to logging procedure>--
      RAISE;

  END change_dept;
  
  --------------------------------
  -- Returns an employee's salary
  --------------------------------
  FUNCTION get_salary (p_emp_id IN employees.emp_id%TYPE) RETURN employees.emp_salary%TYPE IS 

    v_sal employees.emp_salary%TYPE;
  
  BEGIN 
    SELECT emp_salary INTO v_sal 
	FROM employees 
	WHERE emp_id = p_emp_id;
	
    RETURN v_sal; 
  
  EXCEPTION 
    -- When no_data_found, the error will propagate to the calling environment with a user-friendly error description.
    WHEN NO_DATA_FOUND THEN 
	  RAISE_APPLICATION_ERROR (-20004, 'The employee ID is not valid.');

    -- When others handler will handler other errors by logging them and raising them to the calling environment.
    WHEN OTHERS THEN 
      --<add call to logging procedure>--
      RAISE;
  END get_salary;
  
END pkg_employee;
/
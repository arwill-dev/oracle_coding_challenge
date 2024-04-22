-- create departments table for storing department details.
CREATE TABLE departments
(
	dept_id				               NUMBER(5)             NOT NULL,
	dept_name                          VARCHAR2(50)          NOT NULL,
	dept_location                      VARCHAR2(50)          NOT NULL
);

ALTER TABLE departments ADD CONSTRAINT pk_dept_01 PRIMARY KEY (dept_id);

COMMENT ON COLUMN departments.dept_id IS 'The unique identifier for the department';
COMMENT ON COLUMN departments.dept_name IS 'The name of the department';
COMMENT ON COLUMN departments.dept_location IS 'The physical location of the department';

CREATE SEQUENCE seq_dept
START WITH 5;


-- create employees table for storing employee details.
CREATE TABLE employees
(
	emp_id				               NUMBER(10)        	 NOT NULL,
	emp_name                           VARCHAR2(50)          NOT NULL,
	emp_job_title                      VARCHAR2(50)          NOT NULL,
	emp_manager_id                     NUMBER(10)            NULL,
	emp_date_hired                     DATE                  NOT NULL,
	emp_salary                         NUMBER(10)        	 NOT NULL,
	dept_id                            NUMBER(5)        	 NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT pk_emp_01 PRIMARY KEY (emp_id);

ALTER TABLE employees ADD CONSTRAINT fk_emp_01
   FOREIGN KEY (dept_id)
   REFERENCES departments (dept_id);
   
CREATE INDEX idx_emp_01
ON employees(dept_id);

COMMENT ON COLUMN employees.emp_id IS 'The unique identifier for the employee';
COMMENT ON COLUMN employees.emp_name IS 'The name of the employee';
COMMENT ON COLUMN employees.emp_job_title IS 'The job role undertaken by the employee. Some employees may undertaken the same job role';
COMMENT ON COLUMN employees.emp_manager_id IS 'Line manager of the employee';
COMMENT ON COLUMN employees.emp_date_hired IS 'The date the employee was hired ';
COMMENT ON COLUMN employees.emp_salary IS 'Current salary of the employee';
COMMENT ON COLUMN employees.dept_id IS 'Each employee must belong to a department';


CREATE SEQUENCE seq_emp
START WITH 90011;
-- **************************
-- **** DATA ENGINEERING ****
-- **************************

/*

-- TABLE 1: departments
-- Drop table if exists
DROP TABLE IF EXISTS departments;

-- Create new table
CREATE TABLE departments(
	ID serial PRIMARY KEY,
	dept_no VARCHAR,
	dept_name VARCHAR
);

-- View table columns and datatypes
SELECT * FROM departments;


-- TABLE 2: dept_emp
-- Drop table if exists
DROP TABLE IF EXISTS dept_emp;

-- Create new table
CREATE TABLE dept_emp(
	ID serial PRIMARY KEY,
	emp_no INT,
	dept_no VARCHAR
);

-- View table columns and datatypes
SELECT * FROM dept_emp;


-- TABLE 3: dept_manager
-- Drop table if exists
DROP TABLE IF EXISTS dept_manager;

-- Create new table
CREATE TABLE dept_manager(
	ID serial PRIMARY KEY,
	dept_no VARCHAR,
	emp_no INT
);

-- View table columns and datatypes
SELECT * FROM dept_manager;


-- TABLE 4: employees
-- Drop table if exists
DROP TABLE IF EXISTS employees;

-- Create new table
CREATE TABLE employees(
	ID serial PRIMARY KEY,
	emp_no INT,
	emp_title VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE
);

-- View table columns and datatypes
SELECT * FROM employees;


-- TABLE 5: salaries
-- Drop table if exists
DROP TABLE IF EXISTS salaries;

-- Create new table
CREATE TABLE salaries(
	ID serial PRIMARY KEY,
	emp_no INT,
	salary INT
);

-- View table columns and datatypes
SELECT * FROM salaries;


-- TABLE 6: titles
-- Drop table if exists
DROP TABLE IF EXISTS titles;

-- Create new table
CREATE TABLE titles(
	ID serial PRIMARY KEY,
	title_id VARCHAR,
	title VARCHAR
);

-- View table columns and datatypes
SELECT * FROM titles;

*/


-- **********************
-- ******* TABLES *******
-- **********************


-- TABLES 1-6                  #
SELECT * FROM departments; --- 1
SELECT * FROM dept_emp; ------ 2
SELECT * FROM dept_manager; -- 3
SELECT * FROM employees; ----- 4
SELECT * FROM salaries; ------ 5
SELECT * FROM titles; -------- 6
-- NEW TABLES 7-17                           #
SELECT * FROM employee_salary; ------------- 7 --- Data Analysis #1
SELECT * FROM eightysix_employees; --------- 8 --- Data Analysis #2
SELECT * FROM manager_department; ---------- 9
SELECT * FROM manager_info; ---------------- 10 -- Data Analysis #3
SELECT * FROM employee_department_number; -- 11
SELECT * FROM employee_department_name; ---- 12
SELECT * FROM employee_department_info; ---- 13 -- Data Analysis #4
SELECT * FROM employee_hercules_b; --------- 14 -- Data Analysis #5
SELECT * FROM employee_sales_dept; --------- 15 -- Data Analysis #6
SELECT * FROM employee_salesdev_dept; ------ 16 -- Data Analysis #7
SELECT * FROM last_name_count; ------------- 17 -- Data Analysis #8
-- BONUS TABLES 18-20
SELECT * FROM new_titles; ------------------ 18 -- BONUS
SELECT * FROM employee_titles; ------------- 19 -- BONUS
SELECT * FROM titles_salaries; ------------- 20 -- BONUS FINAL


-- ***********************
-- **** DATA ANALYSIS ****
-- ***********************


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
-- Merge tables 4.employees and 5.salaries into new table 7.employee_salary

DROP TABLE IF EXISTS employee_salary;
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
INTO employee_salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

SELECT * FROM employee_salary;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
-- Take select information from table 4.employees into new table 8.eightysix_employees

DROP TABLE IF EXISTS eightysix_employees;
SELECT employees.first_name, employees.last_name, employees.hire_date
INTO eightysix_employees
FROM employees
WHERE
	hire_date >= DATE '1986-01-01'
	AND hire_date <= DATE '1986-12-31';
	
SELECT * FROM eightysix_employees;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- First, merge table 1.departments into table 3.dept_manager to create table 9.manager_department

DROP TABLE IF EXISTS manager_department;
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no
INTO manager_department
FROM dept_manager
INNER JOIN departments ON
dept_manager.dept_no=departments.dept_no;

SELECT * FROM manager_department;

-- Second, merge table 9.manager_department into table 4.employees to create table 10.manager_info

DROP TABLE IF EXISTS manager_info;
SELECT manager_department.dept_no, manager_department.dept_name, employees.emp_no, employees.last_name, employees.first_name
INTO manager_info
FROM manager_department
INNER JOIN employees ON
manager_department.emp_no=employees.emp_no;

SELECT * FROM manager_info;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- First, merge table 2.dept_emp with table 4.employees to match emp_no to dept_no and create table 11.employee_department_number

DROP TABLE IF EXISTS employee_department_number;
SELECT employees.emp_no, dept_emp.dept_no
INTO employee_department_number
FROM dept_emp
INNER JOIN employees ON
dept_emp.emp_no=employees.emp_no;

SELECT * FROM employee_department_number;

-- Second, merge table 11.employee_department_number with table 1.departments to link employeer number with dapartment name and create table 12.employee_department_name

DROP TABLE IF EXISTS employee_department_name;
SELECT employee_department_number.emp_no, departments.dept_name
INTO employee_department_name
FROM employee_department_number
INNER JOIN departments ON
employee_department_number.dept_no=departments.dept_no;

SELECT * FROM employee_department_name;

-- Third, merge table 12.employee_department_name with table 4.employees to create the final table 13.employee_department_info

DROP TABLE IF EXISTS employee_department_info;
SELECT employee_department_name.emp_no, employees.last_name, employees.first_name, employee_department_name.dept_name
INTO employee_department_info
FROM employees
INNER JOIN employee_department_name ON
employee_department_name.emp_no=employees.emp_no;

SELECT * FROM employee_department_info;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
-- Create new table 14.employee_hercules_b to display results of analysis.

DROP TABLE IF EXISTS employee_hercules_b;
SELECT *
INTO employee_hercules_b
FROM employees
WHERE first_name LIKE 'Hercules'
	AND last_name LIKE 'B%';
	
SELECT * FROM employee_hercules_b;

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- Create new table 15.employee_sales_dept to display results of analysis.

DROP TABLE IF EXISTS employee_sales_dept;
SELECT *
INTO employee_sales_dept
FROM employee_department_info
WHERE dept_name LIKE 'Sales';
	
SELECT * FROM employee_sales_dept;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- Create new table 16.employee_salesdev_dept to display results of analysis.

DROP TABLE IF EXISTS employee_salesdev_dept;
SELECT *
INTO employee_salesdev_dept
FROM employee_department_info
WHERE dept_name LIKE 'Sales'
	OR dept_name LIKE 'Development';
	
SELECT * FROM employee_salesdev_dept;

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
-- Create new table 17.last_name_count to display results of analysis.

DROP TABLE IF EXISTS last_name_count;
SELECT last_name, COUNT(last_name)AS Frequency
INTO last_name_count
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;

SELECT * FROM last_name_count;



-- *********************
-- ******* BONUS *******
-- *********************


-- Make new_titles table to make adjustments for bonus.

/*
CREATE TABLE new_titles(
	ID serial PRIMARY KEY,
	title_id VARCHAR,
	title VARCHAR
);

INSERT INTO new_titles SELECT * FROM titles;

ALTER TABLE new_titles
RENAME COLUMN title_id TO emp_title;
*/

SELECT * FROM new_titles;

-- Merge new_titles and employees to create employee_titles.

DROP TABLE IF EXISTS employee_titles;
SELECT employees.emp_no, employees.last_name, employees.first_name, new_titles.title
INTO employee_titles
FROM new_titles
INNER JOIN employees ON
new_titles.emp_title=employees.emp_title;

SELECT * FROM employee_titles;

-- Merge employee_titles and salaries to create titles_salaries.

DROP TABLE IF EXISTS titles_salaries;
SELECT employee_titles.emp_no, employee_titles.last_name, employee_titles.first_name, employee_titles.title, salaries.salary
INTO titles_salaries
FROM employee_titles
INNER JOIN salaries ON
employee_titles.emp_no=salaries.emp_no;

SELECT * FROM titles_salaries;

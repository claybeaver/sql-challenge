-- **************************
-- **** DATA ENGINEERING ****
-- **************************

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
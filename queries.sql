CREATE TABLE titles (
	title_id VARCHAR NOT NULL PRIMARY KEY,
	title VARCHAR NOT NULL
);

CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL, 
	FOREIGN KEY (emp_title_id) REFERENCes titles(title_id),
	birth_date DATE not null,
	first_name VARCHAR not null,
	last_name VARCHAR not null,
	sex VARCHAR(1) not null,
	hire_date DATE not null
);
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL Primary key, 
	dept_name VARCHAR NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR NOT NULL,  
	FOREIGN KEY (dept_No) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);

--List the employee number, last name, first name, sex, and 
--salary of each employee.
SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary
FROM employees AS E
LEFT JOIN salaries AS S
ON (E.emp_no = S.emp_no)
ORDER BY E.last_name;

--List the first name, last name, and hire date for the employees 
--who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their 
--department number, department name, employee number, 
--last name, and first name.

SELECT DM.dept_no, D.dept_name, E.emp_no, E.last_name, E.first_name

FROM dept_manager AS DM
INNER JOIN departments AS D
ON (DM.dept_no = D.dept_no)
	INNER JOIN employees AS E
	ON (DM.emp_no = E.emp_no);

--List the department number for each employee along with 
--that employee’s employee number, last name, first name, and 
--department name.
SELECT DM.dept_no, D.dept_name, DM.emp_no, E.first_name, E.last_name
FROM dept_manager AS DM
INNER JOIN departments AS D
ON (DM.dept_no = D.dept_no)
	INNER JOIN employees AS E
	ON (DM.emp_no = E.emp_no);



--List first name, last name, and sex of each employee 
--whose first name is Hercules and whose last name begins 
--with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE (first_name = 'Hercules')
AND last_name LIKE 'B%';

--List each employee in the Sales department, including their 
--employee number, last name, and first name.
SELECT DE.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees AS E
INNER JOIN dept_emp AS DE
ON (E.emp_no=DE.emp_no)
	INNER JOIN departments AS D
	ON(DE.dept_no=D.dept_no)
	WHERE D.dept_name IN ('Sales')
ORDER BY (E.emp_no);


--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and 
--department name.
SELECT DE.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees AS E
INNER JOIN dept_emp AS DE
ON (E.emp_no=DE.emp_no)
	INNER JOIN departments AS D
	ON(DE.dept_no=D.dept_no)
	WHERE D.dept_name IN ('Sales', 'Development')
ORDER BY (E.emp_no);

--List the frequency counts, in descending order, of all the 
--employee last names (that is, how many employees share each 
--last name).
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

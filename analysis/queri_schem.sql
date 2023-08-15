-- Creating table schemas

CREATE TABLE Departments (
    dept_no VARCHAR(5) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Title (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(30) NOT NULL
);

CREATE TABLE Employees (
    emp_no VARCHAR(15) PRIMARY KEY,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES Title(title_id)
);

CREATE TABLE Salary (
    emp_no VARCHAR(15) PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE EmployeeDepartment (
    emp_no VARCHAR(15) NOT NULL,
    dept_no VARCHAR(5),
	PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
);

CREATE TABLE Managers (
    dept_no VARCHAR(5) NOT NULL,
    emp_no VARCHAR(15) NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (emp_no, dept_no) REFERENCES EmployeeDepartment(emp_no, dept_no)
);

-- List the employee number, last name, first name, sex, and salary of each employee.

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salary.salary
FROM Employees
JOIN Salary ON employees.emp_no = Salary.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT managers.dept_no, departments.dept_name, managers.emp_no, employees.last_name, employees.first_name
FROM managers
JOIN departments ON managers.dept_no = departments.dept_no
JOIN employees ON managers.emp_no = employees.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN employeedepartment ON employees.emp_no = employeedepartment.emp_no
JOIN departments ON employeedepartment.dept_no = departments.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
-- Department number for Sales department is d007

SELECT * FROM departments;
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN employeedepartment ON employees.emp_no = employeedepartment.emp_no
JOIN departments ON employeedepartment.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- Department number for Sales department is d007 and Development department is d005

SELECT * FROM departments;
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN employeedepartment ON employees.emp_no = employeedepartment.emp_no
JOIN departments ON employeedepartment.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007' or departments.dept_no = 'd005';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "Times Appeared"
FROM employees
GROUP BY last_name
ORDER BY "Times Appeared" DESC;
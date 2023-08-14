-- Creating table schemas

CREATE TABLE Departments (
    dept_no VARCHAR(5) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE EmployeeDepartment (
    emp_no INT NOT NULL,
    dept_no VARCHAR(5) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE Managers (
    dept_no VARCHAR(5) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES EmployeeDepartment(emp_no),
	PRIMARY KEY(dept_no, emp_no)
);

CREATE TABLE Employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES Title(title_id)
);

CREATE TABLE Salary (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE Title (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(30) NOT NULL
);





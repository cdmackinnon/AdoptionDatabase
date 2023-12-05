-- Project 2 Alien Adoption Table Instantiation
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman

--Sample Table Generation ;)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);
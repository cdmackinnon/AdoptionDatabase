-- Project 2 Alien Adoption Table Instantiation
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman

--Sample Table Generation ;)
--CREATE TABLE employees (
--    employee_id INT PRIMARY KEY,
--    first_name VARCHAR(50),
--    last_name VARCHAR(50),
--    birth_date DATE,
--    hire_date DATE,
--    department VARCHAR(50),
--    salary DECIMAL(10, 2)
--);

CREATE TABLE agency (
    name VARCHAR(50) PRIMARY KEY,
    planet VARCHAR(50)
);

CREATE TABLE planet (
    name VARCHAR(50) PRIMARY KEY,
    galaxy VARCHAR(50),
    climate VARCHAR(50)
);

CREATE TABLE orphanages (
    name VARCHAR(50) PRIMARY KEY,
    agency VARCHAR(50) PRIMARY KEY
);
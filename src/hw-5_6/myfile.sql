CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    f_name VARCHAR,
    m_init CHAR(1),
    l_name VARCHAR,
    title VARCHAR
)

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR
)

CREATE TABLE Role (
    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id) 
        ON DELETE CASCADE,
    role_id INT PRIMARY
)
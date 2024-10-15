/*Create tables*/
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

/*Insert 5 records*/
INSERT INTO Employee
VALUES
    (1, 'Luis', 'O', 'Menendez', 'Firmware Engineer'),
    (2, 'Ayden', 'J', 'Thompson', 'Firmware Engineer'),
    (3, 'Isaac', 'R' 'Malone', 'Hardware Engineer'),
    (4, 'Lilly', 'A', 'Silva', 'Hardware Engineer'),
    (5, 'Dominic', 'R', 'Ryan', 'Fullstack Developer');

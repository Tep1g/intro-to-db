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

CREATE TABLE Position (
    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id) 
        ON DELETE CASCADE,
    position_id INT PRIMARY
)

/*Insert 5 records*/
INSERT INTO Employee
VALUES
    (1, 'Luis', 'O', 'Menendez', 'Firmware Engineer'),
    (2, 'Stan', 'J', 'Edgar', 'Chief Executive Officer'),
    (3, 'Isaac', 'R' 'Malone', 'Hardware Engineer'),
    (4, 'Noelle', 'A', 'Silva', 'IT Support Technician'),
    (5, 'Dominic', 'R', 'Ryan', 'Marketing Coordinator');

INSERT INTO Department
VALUES
    (1, 'Software Development'),
    (2, 'Executive & Administrative'),
    (3, 'Hardware Development'),
    (4, 'Information Technology'),
    (5, 'Marketing & Sales');


/*List all info sorted by l_name*/
SELECT * from Employee
ORDER BY l_name;


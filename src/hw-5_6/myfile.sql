DROP TABLE IF EXISTS position, employee, department;

/*Create tables*/
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    f_name VARCHAR,
    m_init CHAR(1),
    l_name VARCHAR,
    title VARCHAR
);

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR
);

CREATE TABLE position (
    position_id INT PRIMARY KEY,
    employee_id INT,
    dept_id INT,
    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (dept_id)
        REFERENCES department(dept_id) 
        ON DELETE CASCADE
);

/*Insert 5 records*/
INSERT INTO employee
VALUES
    (1, 'Luis', 'O', 'Menendez', 'Firmware Engineer'),
    (2, 'Stan', 'J', 'Edgar', 'Chief Executive Officer'),
    (3, 'Isaac', 'R', 'Malone', 'Hardware Engineer'),
    (4, 'Noelle', 'A', 'Silva', 'IT Support Technician'),
    (5, 'Dominic', 'R', 'Ryan', 'Marketing Coordinator');

INSERT INTO department
VALUES
    (1, 'Software Development'),
    (2, 'Executive & Administrative'),
    (3, 'Hardware Development'),
    (4, 'Information Technology'),
    (5, 'Marketing & Sales');

INSERT INTO position
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5);

/*List all info sorted by l_name*/
SELECT * from employee
ORDER BY l_name;

/*List f_name and l_name (from Employee) with dept_name (from Department)*/
SELECT f_name, l_name, dept_name
    FROM employee LEFT OUTER JOIN position
        ON employee.employee_id = position.employee_id
        FULL OUTER JOIN department
            ON position.dept_id = department.dept_id;
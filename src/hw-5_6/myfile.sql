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
INSERT INTO employee (employee_id, f_name, m_init, l_name, title)
VALUES
    (1, 'Luis', 'O', 'Menendez', 'Embedded Software Engineer'),
    (2, 'Stan', 'J', 'Edgar', 'Chief Executive Officer'),
    (3, 'Isaac', 'R', 'Malone', 'Systems Engineer'),
    (4, 'Noelle', 'A', 'Silva', 'IT Support Technician'),
    (5, 'Dominic', 'R', 'Ryan', 'Marketing Coordinator'),
    (6, 'Nae', 'T', 'Kobayashi', 'Fullstack Developer');

INSERT INTO department (dept_id, dept_name)
VALUES
    (1, 'Software Development'),
    (2, 'Executive & Administrative'),
    (3, 'Hardware Development'),
    (4, 'Information Technology'),
    (5, 'Marketing & Sales');

INSERT INTO position (position_id, employee_id, dept_id)
VALUES
    (1, 1, 1),
    (2, 1, 4),
    (3, 2, 2),
    (4, 3, 3),
    (5, 3, 1),
    (6, 4, 4),
    (7, 5, 5),
    (8, 6, 1);

/*List all info sorted by l_name*/
SELECT * from employee
ORDER BY l_name;

/*List f_name and l_name (from Employee) with dept_name (from Department)*/
SELECT f_name, l_name, dept_name
    FROM employee LEFT OUTER JOIN position
        ON employee.employee_id = position.employee_id
        FULL OUTER JOIN department
            ON position.dept_id = department.dept_id;

/*List f_name and l_name (from employee) with number of positions*/
SELECT employee.f_name, employee.l_name, COUNT(position.employee_id) as num_positions
    FROM employee LEFT OUTER JOIN position
        ON employee.employee_id = position.employee_id
        GROUP BY employee.employee_id;

/*Delete one record from department table that has at least one entry in the position table*/
DELETE
    FROM department
        WHERE dept_id IN (
            SELECT dept_id
                FROM position
                GROUP BY dept_id
                HAVING COUNT(*) >= 1
                LIMIT 1
        );

/*Show that the number of roles decreased for one employee*/
SELECT employee.f_name, employee.l_name, COUNT(position.employee_id) as num_positions
    FROM employee LEFT OUTER JOIN position
        ON employee.employee_id = position.employee_id
        GROUP BY employee.employee_id;

ALTER TABLE department
    ADD small_department BOOLEAN DEFAULT 'false';

UPDATE department
    SET small_department = 'true'
        WHERE dept_id IN (
            SELECT dept_id
                FROM position
                GROUP BY dept_id
                HAVING COUNT(*) <= 2
        );
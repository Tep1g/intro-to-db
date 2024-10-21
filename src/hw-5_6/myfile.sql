DROP VIEW IF EXISTS title_department;
DROP TABLE IF EXISTS employee, department, "role";

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

CREATE TABLE "role" (
    role_id INT PRIMARY KEY,
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
    (2, 'Stan', 'J', 'Edgar', 'Chief Technology Officer'),
    (3, 'Isaac', 'R', 'Malone', 'Systems Engineer'),
    (4, 'Noelle', 'A', 'Silva', 'IT Support Technician'),
    (5, 'Dominic', 'R', 'Ryan', 'Marketing Coordinator');

INSERT INTO department (dept_id, dept_name)
VALUES
    (1, 'Software Development'),
    (2, 'Executive & Administrative'),
    (3, 'Hardware Development'),
    (4, 'Information Technology'),
    (5, 'Marketing & Sales');

INSERT INTO "role" (role_id, employee_id, dept_id)
VALUES
    (1, 1, 1),
    (2, 1, 4),
    (3, 2, 1),
    (4, 2, 2),
    (5, 2, 3),
    (6, 3, 3),
    (7, 3, 1),
    (8, 4, 4),
    (9, 5, 5);

/*List all info sorted by l_name*/
SELECT * from employee
ORDER BY l_name;

/*List f_name and l_name (from Employee) with dept_name (from Department)*/
SELECT f_name, l_name, dept_name
    FROM employee LEFT OUTER JOIN "role"
        ON employee.employee_id = role.employee_id
        FULL OUTER JOIN department
            ON role.dept_id = department.dept_id;

/*List f_name and l_name (from employee) with number of roles*/
SELECT employee.l_name, COUNT(role.employee_id) as num_roles
    FROM employee LEFT OUTER JOIN "role"
        ON employee.employee_id = role.employee_id
        GROUP BY employee.employee_id;

/*Delete one record from department table that has at least one entry in the role table*/
DELETE
    FROM department
        WHERE dept_id IN (
            SELECT dept_id
                FROM "role"
                GROUP BY dept_id
                HAVING COUNT(*) >= 1
                LIMIT 1
        );

/*Show that the number of roles decreased for one employee*/
SELECT employee.l_name, COUNT(role.employee_id) as num_roles
    FROM employee LEFT OUTER JOIN "role"
        ON employee.employee_id = role.employee_id
        GROUP BY employee.employee_id;

ALTER TABLE department
    ADD small_department BOOLEAN DEFAULT 'false';

UPDATE department
    SET small_department = 'true'
        WHERE dept_id IN (
            SELECT dept_id
                FROM "role"
                GROUP BY dept_id
                HAVING COUNT(*) <= 2
        );

/*Create view that lists titles together with each name of a department*/
CREATE VIEW title_department AS
    SELECT title, STRING_AGG(dept_name, ', ') AS dept_names
        FROM employee
        LEFT OUTER JOIN "role" 
            ON employee.employee_id = role.employee_id
        LEFT OUTER JOIN department 
            ON role.dept_id = department.dept_id
        GROUP BY title;

SELECT * FROM title_department;
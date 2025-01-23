----------------------- SCIENCEQTECH EMPLOYEE PERFROMANCE MAPPING SAUMYA GUREJA ------------------------------

-- 1.Create a database named employee, then import data_science_team.csv, proj_table.csv and 
-- emp_record_table.csv into the employee database from the given resources.

CREATE DATABASE employee;
USE employee;

--------------------------------------------------------------------------------------------------------------
-- I imported the csv files using table import wizard and then altered them:

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS where table_name="proj_table";

ALTER TABLE proj_table
CHANGE `START _DATE` START_DATE char(10);

ALTER TABLE proj_table 
MODIFY PROJECT_ID varchar(10) primary key ,
MODIFY PROJ_NAME varchar(50),
MODIFY DOMAIN varchar(50),
MODIFY CLOSURE_DATE char(10),
MODIFY DEV_QTR char(2),
MODIFY STATUS varchar(10);


UPDATE emp_record_table
SET PROJ_ID = NULL
WHERE PROJ_ID = 'NA';

ALTER TABLE emp_record_table 
MODIFY EMP_ID varchar(10) PRIMARY KEY, 
MODIFY FIRST_NAME varchar(50), 
MODIFY LAST_NAME varchar(50), 
MODIFY GENDER varchar(1), 
MODIFY ROLE varchar(50), 
MODIFY DEPT varchar(50), 
MODIFY EXP int, 
MODIFY COUNTRY varchar(50), 
MODIFY CONTINENT varchar(50), 
MODIFY SALARY int, 
MODIFY EMP_RATING int, 
MODIFY MANAGER_ID varchar(50), 
MODIFY PROJ_ID varchar(10), 
ADD FOREIGN KEY (PROJ_ID) REFERENCES proj_table(PROJECT_ID);

ALTER TABLE data_science_team
MODIFY EMP_ID varchar(10) primary key,
MODIFY FIRST_NAME varchar(50),
MODIFY LAST_NAME varchar(50),
MODIFY GENDER varchar(1),
MODIFY ROLE varchar(50),
MODIFY DEPT varchar(50),
MODIFY EXP int,
MODIFY COUNTRY varchar(50),
MODIFY CONTINENT varchar(50),
ADD foreign key (EMP_ID) REFERENCES emp_record_table(EMP_ID);

--------------------------------------------------------------------------------------------------------------
-- 2.Create an ER diagram for the given employee database.
-- using reverse engineer in database tab.

--------------------------------------------------------------------------------------------------------------
-- 3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record 
-- table, and make a list of employees and details of their department.

SELECT emp_id, first_name, last_name, gender, dept FROM emp_record_table;

--------------------------------------------------------------------------------------------------------------
-- 4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the 
-- EMP_RATING is: 
-- •	less than two
-- •	greater than four 
-- •	between two and four

SELECT emp_id, first_name, last_name, gender, dept, emp_rating FROM emp_record_table WHERE emp_rating<2;

SELECT emp_id, first_name, last_name, gender, dept, emp_rating FROM emp_record_table WHERE emp_rating>4;

SELECT emp_id, first_name, last_name, gender, dept, emp_rating FROM emp_record_table 
WHERE emp_rating BETWEEN 2 AND  4;

--------------------------------------------------------------------------------------------------------------
-- 5. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department 
-- from the employee table and then give the resultant column alias as NAME.

SELECT concat(first_name, " ", last_name),dept FROM emp_record_table WHERE dept="Finance";

--------------------------------------------------------------------------------------------------------------
-- 6. Write a query to list only those employees who have someone reporting to them. Also, show the number 
-- of reporters (including the President).

SELECT DISTINCT manager_id, count(emp_id) OVER (PARTITION BY manager_id) no_of_reporters 
FROM emp_record_table WHERE manager_id IS NOT NULL;

--------------------------------------------------------------------------------------------------------------
-- 7.Write a query to list down all the employees from the healthcare and finance departments using union. 
-- Take data from the employee record table.

SELECT emp_id,first_name,last_name,dept FROM emp_record_table WHERE dept="healthcare"
UNION
SELECT emp_id,first_name,last_name,dept FROM emp_record_table WHERE dept="finance"; 

--------------------------------------------------------------------------------------------------------------
-- 8. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, 
-- and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating 
-- for the department.

SELECT  emp_id,
		first_name,
		last_name,
		role,
		emp_rating,
		dept,
		max(emp_rating) OVER (PARTITION BY dept) max_dept_rating 
FROM emp_record_table;

--------------------------------------------------------------------------------------------------------------
-- 9. Write a query to calculate the minimum and the maximum salary of the employees in each role. 
-- Take data from the employee record table.

SELECT role, MAX(salary) maximum_salary, MIN(salary) minimum_salary FROM emp_record_table GROUP BY role;

--------------------------------------------------------------------------------------------------------------
-- 10. Write a query to assign ranks to each employee based on their experience. Take data from the 
-- employee record table.

SELECT emp_id, first_name,last_name,dept,exp, dense_rank() OVER (ORDER BY exp desc) rank_ 
FROM emp_record_table;

--------------------------------------------------------------------------------------------------------------
-- 11. Write a query to create a view that displays employees in various countries whose salary is more than 
-- six thousand. Take data from the employee record table.

CREATE VIEW employee_salary_more_than_6000 AS
SELECT country, emp_id, concat(first_name," ",last_name) emp_name, salary, emp_rating, role, dept, 
manager_id, proj_id, gender, continent  FROM emp_record_table WHERE salary>6000 ORDER BY country asc;

SELECT * FROM employee_salary_more_than_6000;

--------------------------------------------------------------------------------------------------------------
-- 12. Write a nested query to find employees with experience of more than ten years. Take data from the 
-- employee record table.

SELECT * FROM emp_record_table WHERE exp>10;

--------------------------------------------------------------------------------------------------------------
-- 13.Write a query to create a stored procedure to retrieve the details of the employees whose experience is
--  more than three years. Take data from the employee record table.

DELIMITER //

CREATE PROCEDURE exp_more_than_three()
BEGIN
    SELECT *
    FROM emp_record_table
    WHERE exp > 3;
END //

DELIMITER ;

CALL exp_more_than_three();

--------------------------------------------------------------------------------------------------------------
-- 14. Write a query using stored functions in the project table to check whether the job profile assigned 
-- to each employee in the data science team matches the organization’s set standard.
 
-- The standard being:
-- For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
-- For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
-- For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
-- For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
-- For an employee with the experience of 12 to 16 years assign 'MANAGER'.

DELIMITER //

CREATE FUNCTION get_expected_job_profile(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE job_profile VARCHAR(50);

    IF exp <= 2 THEN
        SET job_profile = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET job_profile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp > 5 AND exp <= 10 THEN
        SET job_profile = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET job_profile = 'LEAD DATA SCIENTIST';
    ELSEIF exp > 12 AND exp <= 16 THEN
        SET job_profile = 'MANAGER';
    ELSE
        SET job_profile = 'UNKNOWN PROFILE';
    END IF;

    RETURN job_profile;
END //

DELIMITER ;

SELECT 
    d.EMP_ID,
    d.FIRST_NAME,
    d.LAST_NAME,
    d.EXP,
    d.ROLE AS assigned_role,
    get_expected_job_profile(d.EXP) AS expected_role,
    CASE 
        WHEN d.ROLE = get_expected_job_profile(d.EXP) THEN 'MATCH'
        ELSE 'DOES NOT MATCH'
    END AS profile_check
FROM 
    data_science_team d;
    
--------------------------------------------------------------------------------------------------------------
-- 15. Create an index to improve the cost and performance of the query to find the employee whose 
-- FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.    
    
CREATE INDEX idx_first_name ON emp_record_table(first_name);

SELECT * FROM emp_record_table WHERE first_name="Eric";

EXPLAIN SELECT * FROM emp_record_table WHERE first_name="Eric";

--------------------------------------------------------------------------------------------------------------
-- 16. Write a query to calculate the bonus for all the employees, based on their ratings and salaries 
-- (Use the formula: 5% of salary * employee rating).

SELECT emp_id,concat(first_name," ",last_name) emp_name, emp_rating, salary, (0.05*salary*emp_rating) bonus 
FROM emp_record_table;

--------------------------------------------------------------------------------------------------------------
-- 17. Write a query to calculate the average salary distribution based on the continent and country. 
-- Take data from the employee record table.

SELECT DISTINCT continent,country,AVG(salary) OVER (PARTITION BY continent, country) average_salary 
FROM emp_record_table;
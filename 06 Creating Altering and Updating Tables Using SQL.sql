
-------------------------------------------------------------------------------
------------- 023 Creating Your Own Tables  Design Considerations -------------
-------------------------------------------------------------------------------

--! Primary Key Column can't have duplicates or be NULL

-- we need define what type of date will be stored in columns in parenthesis
CREATE TABLE stores
(
  store_id number not null,
  city varchar(50) 
);

-- store_id is primary key
-- not null is constraints to the column
-- varchar variable characters, 
-- it could be numbers, words, sentences but capacity limited by 50 chars
--! space is also a character




-------------------------------------------------------------------------------
---------------------- 024 Inserting Data Into Our Table ----------------------
-------------------------------------------------------------------------------

-- no place for duplicates in Primary key column

INSERT INTO stores(store_id, city) VALUES (1, 'San Francisco');

INSERT INTO stores(store_id, city) VALUES (2, 'New York City');

-- Auto/Implied Commit
-- In many systems after INSERT command we should explicitly COMMIT it to save,
-- but not in Oracle Apex, here is Auto/Implied Commit implemented

INSERT INTO stores(store_id, city) VALUES (3, 'CHICAGO');

-- INSERT ALL allows insert many values with one execution

SELECT * FROM stores;

INSERT ALL
  INTO stores (store_id, city) VALUES (4, 'Philadelphia')
  INTO stores (store_id, city) VALUES (5, 'Boston')
  INTO stores (store_id, city) VALUES (6, 'Seattle')
SELECT * FROM DUAL;
-- select * from dual is a specific Oracle syntax

select store_id, count(*) 
from stores
group by store_id
order by 1
-- order by 1st column




-------------------------------------------------------------------------------
--------------- 025 Create Table With a Primary Key Constraint ----------------
-------------------------------------------------------------------------------

CREATE TABLE products
(
  product_id number not null,
  name varchar(50),
  product_cost number(5, 2),
  product_retail number(5, 2),
  product_type varchar(10),
  store_id number not null,

  CONSTRAINT product_pk PRIMARY KEY (product_id)
)
-- number(5, 2) means 3 digits and 2 digits after comma
-- product_retail actual price in retail store

--! Foreign Key to relate two Tables
--! Primary Key to restrict duplicates
-- constraint is a kind of object of a table object hmm
-- we creating primary key entity and then assigning it to particular column

INSERT INTO products 
(product_id, name, product_cost, product_retail, product_type, store_id)
VALUES (1001, 'Colgate Toothpaste', 2.25, 5.47, 'hygiene', 2);

INSERT INTO products
(product_id, name, product_cost, product_retail, product_type, store_id ) 
VALUES (1002, 'Colgate Toothpaste', 2.25, 5.47, 'hygiene', 2);

INSERT INTO products
(product_id, name, product_cost, product_retail, product_type, store_id) 
VALUES (1003, 'Listerine Mouthwash', 1.75, 4.81, 'hygiene', 3);

-- with INSERT ALL if one record failed then all query failed
INSERT ALL
  INTO products 
  (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1004, 'T-Shirt', 1.75, 7.77, 'Clothing', 2)
  INTO products
  (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1005, 'T-Shirt', 1.65, 7.85, 'Clothing', 2)
  INTO products
    (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1006, 'T-Shirt', 1.73, 7.80, 'Clothing', 3)
  INTO products
    (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1007, 'Shorts', 0.73, 5.60, 'Clothing', 3)
  INTO products
    (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1008, 'Dress Shoes', 17.85, 87.67, 'Clothing', 2)
  INTO products
    (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1009, 'Garden Chair', 12.01, 27.87, 'Home & Gar', 2)
  INTO products
    (product_id, name, product_cost, product_retail, product_type, store_id)
  VALUES (1010, 'Grass Fertilizer', 3.20, 8.70, 'Home & Gar', 2)
SELECT * FROM DUAL;




-------------------------------------------------------------------------------
--------------- 026 Using ALTER to modify the table structure -----------------
-------------------------------------------------------------------------------

SELECT * FROM products;

-- without mention specific columns
INSERT INTO products VALUES (1011, '', 4.00, 8.00, 'Clothing', 3)

-- about table report 
DESCRIBE products

ALTER TABLE products
MODIFY name varchar2(50) not null
--! can't apply because we already added a record with NULL in the name field

-- about table report 
DESCRIBE products

DELETE FROM products WHERE products_id = 1011

DESCRIBE product_pk

-- lets add not null constraint to other columns
ALTER TABLE products
MODIFY (product_cost number(5, 2) not null,
        product_retail number(5, 2) not null);

ALTER TABLE products
  RENAME name TO product_name;




-------------------------------------------------------------------------------
----------------- 027 Create Table with SELECT  UPDATE Data -------------------
-------------------------------------------------------------------------------

CREATE TABLE employees AS
SELECT empno, ename, job, hiredate, sal, comma
FROM emp;

DESCRIBE employees;


SELECT * FROM employees;

ALTER TABLE employees
  ADD store_id number;

-- INSERT record, but UPDATE particular column
UPDATE table_name
SET column_name = value
WHERE some criteria

UPDATE employees
SET store_id = 3
WHERE ename in ('KING', 'BLAKE', 'CLARK')

-- ############################################################################
-- put SALESMAN to store 2, CLERKs to store 4, analysts to 4 and Jones to 1
-- ############################################################################

UPDATE employees
SET store_id = 2
WHERE job = 'SALESMAN'

UPDATE employees
SET store_id = 4
WHERE job = 'CLERK'

UPDATE employees
SET store_id = 4
WHERE job = 'ANALYST'

UPDATE employees
SET store_id = 1
WHERE ename = 'JONES'

ALTER TABLE employees
  MODIFY store_id number not null;




-------------------------------------------------------------------------------
----------------- 028 DELETE TRUNCATE and DROP Commands -------------------
-------------------------------------------------------------------------------

-- difference between DELETE & TRUNCATE statement
--! you can't roll back the TRUNCATE TABLE statement

SELECT * FROM dept

-- remember in apex.oracle autocommit feature implemented
SELECT * FROM dept WHERE deptno = 40
DELETE FROM dept WHERE deptno = 40

-- will lead to Error
DELETE FROM dept
-- integrity constraint (MY_DATABASE.SYS_C00687188149) violated - 
-- child record found
-- we must brake the link between those two tables by deleting constraint rule in the emp table

-- default table
SELECT * FROM emp

ALTER TABLE emp
  DROP CONSTRAINT SYS_C0062811149

SELECT * FROM emp
-- so that column still exist, but no longer connected to another table

-- drop the entire table
DROP TABLE dept

--! truncate doesn't drop the data from system, but it's eliminates all data
-- we are get rid of data, but the structure still exists
TRUNCATE TABLE emp

DROP TABLE emp
-- table is gone from our system

-------------------------------------------------------------------------------
---------------------- 029 Working With Database Indexes ----------------------
-------------------------------------------------------------------------------

-- INDEX is a data structure used by database to search for things much faster
-- without fell defined indexes big tables become slow down
-- columns that queried often should be Index
-- creating Indexes spend some space
select * from employees

-- good practice to add idx msg to the name
CREATE INDEX emp_name_idx
  ON employees (ename)
-- the database will create a section, object

-- oracle don't have to search entire table, it's just check the index
-- it's just search John in the alphabetically sorted list of data
SELECT * FROM employees
WHERE ename = 'JOHN'

CREATE INDEX emp_name_job_date_idx
  ON employees(ename, job, hiredate)

SELECT * FROM employees
WHERE ename = 'JOHN'
AND hiredate = ''
AND job = ''

CREATE UNIQUE INDEX emp_job_idx
ON employees(job)
-- error duplicate keys found
-- it's make sure that job column has unique data
-- every particular cell in column better to be unique

CREATE INDEX emp_job_idx
ON employees(job)

DROP INDEX emp_job_idx

DROP INDEX emp_name_job_date_idx

-- statistics are used by the optimizer to choose a best path 
-- for executing any queries that involve those particular column
-- "plan of execution", when SQL statements are executed
CREATE INDEX emp_name_job_date_idx
ON employees(ename, job, hiredate)
COMPUTE STATISTICS;

ALTER INDEX emp_name_idx
  REBUILD COMPUTE STATISTICS




-------------------------------------------------------------------------------
------------ 030 System Tables Pseudo Columns  Deleting Duplicates ------------
-------------------------------------------------------------------------------

-- ############################################################################
-- create a unique index on the store_id column
-- to do that we should delete duplicate records
-- ############################################################################

SELECT * FROM stores

CREATE UNIQUE INDEX unique_store_id_idx
ON stores(store_id)

SELECT store_id, city, count(*)
FROM stores
GROUP BY store_id, city
ORDER BY COUNT(*)

-- ROWID pseudo column, represented in string form
--! each row in a database has an address
SELECT rowid, store_id, city FROM stores
-- looks like that AD/gdsADYAAAAFzAAA

DELETE FROM stores
WHERE rowid NOT IN (
  SELECT MIN(rowid)
  FROM stores
  GROUP BY store_id, city
)

ALTER TABLE stores
ADD CONSTRAINT store_id_pk PRIMARY KEY (store_id)

CREATE UNIQUE INDEX store_id_idx
ON stores(store_id)
COMPUTE STATISTICS


SELECT * FROM all_tables
WHERE table_name = 'EMPLOYEES'
AND rownum < 10


SELECT * FROM all_tab_columns
WHERE table_name = 'EMPLOYEES'

SELECT * FROM all_objects
WHERE rownum < 50

SELECT * FROM all_objects
WHERE object_type = 'INDEX'
AND object_name = 'EMP_NAME_IDX'

-- same with lower function
SELECT * FROM all_objects
WHERE object_type = 'INDEX'
AND lower(object_name) = 'emp_name_idx'

SELECT * FROM user_tab_columns

CREATE PUBLIC SYNONYM emp_table
FOR employees
-- insufficient privileges

CREATE SYNONYM emp_table
FOR employees
-- Synonym created.

SELECT * FROM emp_table

SELECT rownum, enum, sal FROM emp_table




-------------------------------------------------------------------------------
------------ 031 Views and Other Objects and Commands Newly Added -------------
-------------------------------------------------------------------------------

-- VIEW object is convenient when you are handle with complex query
-- VIEW like a named query

CREATE VIEW managers_v AS
SELECT * FROM employees
WHERE job = 'MANAGER'

SELECT * FROM managers_v

SELECT * FROM user_objects
WHERE object_type = 'VIEW'

SELECT * FROM all_objects
WHERE OWNER = 'TIHOVS_DATABASE'
AND object_type = 'TABLE'

SELECT * FROM all_objects
WHERE object_type = 'VIEW'
AND rownum < 10

-- information about particular database
SELECT * FROM SYS.V_$VerSioN

DROP VIEW managers_v


-- ############################################################################
-- return highest paid employees from stores
-- ############################################################################

CREATE VIEW super_employees AS
SELECT * FROM employees e1
INNER JOIN
  (SELECT store_id, max(sal) sal
  FROM employees
  GROUP BY store_id) e2
ON e1.store_id = e2.store_id
AND e1.sal = e2.sal
WHERE ename != 'FORD'
-- ORA-00957: duplicate column name
-- because of *

CREATE VIEW super_employees AS
SELECT e1.* FROM employees e1
INNER JOIN
  (SELECT store_id, max(sal) sal
  FROM employees
  GROUP BY store_id) e2
ON e1.store_id = e2.store_id
AND e1.sal = e2.sal
WHERE ename != 'FORD'

-- UNION is used to combine, use two things together
-- The UNION operator selects only distinct values by default.
-- To allow duplicate values, use UNION ALL
-- The UNION operator is used to combine the result-set
-- of two or more SELECT statements.
-- Each SELECT statement within UNION must have the same number of columns
-- The columns must also have similar data types
-- The columns in each SELECT statement must also be in the same order


CREATE VIEW super_employees AS
SELECT e1.* FROM employees e1
INNER JOIN
  (SELECT store_id, max(sal) sal
  FROM employees
  GROUP BY store_id) e2
ON e1.store_id = e2.store_id
AND e1.sal = e2.sal
WHERE ename != 'FORD'
UNION
SELECT * FROM employees

SELECT * FROM employees
UNION
SELECT * FROM super_employees

SELECT ename, job FROM employees
UNION
SELECT ename, job FROM super_employees
ORDER BY job

-- to get duplicates 
SELECT * FROM employees
UNION ALL
SELECT * FROM super_employees

-- MINUS
SELECT * FROM super_employees
MINUS -- MINUS records below from table mentioned above
SELECT * FROM employees WHERE job = 'SALESMAN'

-- how to change VIEW
CREATE OR REPLACE VIEW super_employees AS
SELECT e1.* FROM employees e1
INNER JOIN
  (SELECT store_id, max(sal) sal
  FROM employees
  GROUP BY store_id) e2
ON e1.store_id = e2.store_id
WHERE ename !='FORD'
-- ORA-00955: name is already used by an existing object

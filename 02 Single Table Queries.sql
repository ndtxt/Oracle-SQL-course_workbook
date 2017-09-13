-- https://apex.oracle.com/
-- Move courser to the end than press SHIFT + HOME buttons than CTRL + ENTER



----------------- 004 Retrieving Data Using the SELECT Clause -----------------

select * from emp;

-- columns order is matter
select job, ename from emp;

select job from emp;

select * from dept;

select dname, loc from dept;

select job from emp;

select distinct job from emp;




-------------------- 005 Using the WHERE Clause in a Query --------------------

select * from emp where job = 'MANAGER';

select * from emp where job = 'manager'; 
-- the result is 'no data found' because SQL is case insensitive but not the 
-- data we are querying for.*/

select * from emp where job = 'SALESMAN';
select * from emp where ename = 'ALLEN';

-- after where must be and
select * from emp where job = 'SALESMAN' and sal = 1600;

select * from emp where job = 'SALESMAN' and sal = 1600 and comm = '500';
select * from emp where job = 'SALESMAN' and sal = 1600 and comm = '300';

 -- When Oracle interpreter parsing the query, it starts FROM the table name 
 -- than goes to WHERE to eliminate useless records and at the end goes to 
 -- columns.




------------------- 006 Using Operators in the WHERE Clause -------------------

select * from emp where job = 'SALESMAN'

-- ! is not operator
select * from emp where job != 'SALESMAN';

-- example of correct syntax but incorrect logic
select * from emp where job != 'SALESMAN' and job = 'SALESMAN';


select * from emp where job != 'SALESMAN' and sal < 2500;

-- ############################################################################
-- get all employees tha are not a managers and have a salary grater than 2500 
-- and also work in department no# 20
-- ############################################################################

select * from emp 
where job != 'MANAGER' 
and sal > 2500 
and deptno = 20;




----------------- 007 Combining WHERE AND  OR with Operators -----------------

select * from emp where job = 'CLERK' or job = 'SALESMAN';

-- ############################################################################
-- Get the names of those employees that are not managers nor salesman and 
-- have a salary greater than or equal to 2000
-- ############################################################################

select * from emp 
where sal >= 2500
and job != 'MANAGER' 
and job != 'SALESMAN';

-- ############################################################################
-- the names of those employees that are not managers nor salesman and have a 
-- salary greater than or equal to 2000
-- ############################################################################

select ename from emp 
where sal > 2500
and job != 'MANAGER' 
and job != 'SALESMAN';




------------- 008 Query Filtering Continued BETWEEN IN and NULL ------------- 
select * from emp;
select * from dept;

select ename, hiredate from emp where deptno = 20 or deptno = 30;
select ename, hiredate from emp where deptno in (20, 30);

select ename, hiredate from emp where ename = 'BLAKE' 
or ename = 'JONES' or ename = 'SCOTT' or ename = 'FORD' or ename = 'MARTIN';

select ename, hiredate from emp 
where ename in ('BLAKE', 'JONES', 'SCOTT', 'FORD', 'MARTIN');

select ename, hiredate from emp 
where ename NOT in ('BLAKE', 'JONES', 'SCOTT', 'FORD', 'MARTIN');

-- all employess hired between 
select * from emp where hiredate BETWEEN '05/01/1981' and '12/09/1982';
-- in most database systems you need to write dates in quotes 

-- ############################################################################
-- employes who has a salary not between 1000 and 2000
-- ############################################################################

select * from emp where 
sal between 1250 and 1600;
-- same as salary >= 1250 or salary <= 1600

select * from emp where 
sal >= 1250 and sal <= 1600;


select * from emp where 
sal NOT between 1250 and 1600;
-- same as salary < 1250 or salary > 1600


select * from emp where comm is null;

select * from emp where comm is NOT null;

-- ############################################################################
-- a query that returns those employees that don't make any commission and 
-- have a salary greater than 1100 but less than 5000. Exclude those employees 
-- that have a salary equal to 3000. 
-- ############################################################################

select * from emp 
where comm is null
and sal != 3000 
and sal between 1100 and 5000;
-- BETWEEN here are used intentionally

-- equality means exact of something so watch out 'comm = null' is not correct
-- two NULLs are not equal to each other




------------- 009 Query Filtering Conditions  Operator Precedence -------------

--! <> like != and could exclude value also
select * from emp 
where comm is null
and sal <> 3000 
and sal > 1100 and sal < 5000;

--! watch out db treat 0 as NULL
select * from emp 
where comm is null 
and sal <> 3000 
and sal > 1100 and sal < 5000
or comm = 0;

select * from emp 
where (comm is null or comm = 0)
and sal <> 1500
and sal > 1100 and sal < 5000;

-- ############################################################################
-- return those employees that are salesman and that make either 300 dollars 
-- in commission or greater than 1000 dollars in commission
-- ############################################################################

--! conditions in parenthesis will be evaluated together 
select * from emp 
where job = 'SALESMAN'
and (comm = 300 or comm > 1000);


-- use LIKE it's don't match exactly, it's like a pattern
-- LIKE condition allows wildcards to be used
-- % sign is 'wild card' it can be replaced by any character
-- _ underscore can be replaced by any single character

select * from emp 
where job LIKE 'S%';


select * from emp 
where job LIKE '%NAGER';




------------- 010 Ordering Concatenating  Aliasing Query Results -------------

-- Alias is like another nickname to particular attribute
-- useful for reports for someone unfamiliar with ur columns names
select ename employee, sal salary, comm commission from emp;

--! use double quotes
select ename "employee Name", sal AS "()*($", comm commission from emp;

-- concatenation ||
select 'Hello, my name is ' || ename from emp where job='MANAGER';

--! to FIX column name use alias and use double quotes only
select 'Hello, my name is ' || ename as "Managers name" from emp 
where job='MANAGER';

-- ############################################################################
-- result should be "KING makes 5000 per month"
-- ############################################################################

select ename || ' makes $' || sal || ' per month' as "money report" from emp;

-- ORDER BY
select ename, sal from emp ORDER BY ename;
select * from emp ORDER BY ename;

--! by default it's ordered by ascending from lowest to highest 
select * from emp ORDER BY sal;
--! change the default order to descending
select * from emp ORDER BY sal DESC;
select * from emp ORDER BY sal ASC;

select deptno, sal, ename from emp order by DEPTNO, SAL;

-- order by 2 columns
select * from emp order by DEPTNO, SAL;
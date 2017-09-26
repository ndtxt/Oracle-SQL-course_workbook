
-------------------------------------------------------------------------------
--------------------- 019 SELECT within SELECT Subqueries ---------------------
-------------------------------------------------------------------------------

-- Nested query is a select statement within a select statement
select * from dept
where deptno = (select deptno from dept where deptno = 30)

--! nested portion is a thing that goes run FIRST, [ike in math

select * from dept
where deptno < (select deptno from dept where deptno = 30)
and dname = 'ACCOUNTING'

select * from (select * from emp)

--! nested queries to join tables
select * from emp 
where deptno = (select deptno from dept where loc = 'CHICAGO')

-- with multiple columns / rows
--! if we have a list of results use in, if one use = sign
select * from emp 
where deptno in (select deptno from dept where deptno in (10, 20))

select job, ename, (select job from emp where ename = 'KING')
from emp
-- will repeat Kings job title in every table row

select job, ename, (select * from dual)
from emp

-- u can't select 'text' from real tables, that's wy use DUAL dummy table
select job, ename, (select 'Hi there' from dual)
from emp

select job, ename, (select 'Hello there' from dual)
from emp
where job = (select job from emp where job = 'PRESIDENT')




-------------------------------------------------------------------------------
------------------ 020 Relating Tables Together Using JOINs -------------------
-------------------------------------------------------------------------------

-- JOIN is performed whenever two or more tables are joined in a SQL statement

select * from emp
select * from dept

-- looks like just add dept table next to emp
select * from emp, dept

select * from emp, dept
where emp.deptno = dept.deptno

-- ############################################################################
-- return those employees that work in Dallas department
-- ############################################################################

select * from emp, dept
where emp.deptno = dept.deptno
and loc = 'DALLAS'

-- we could explicitly saying in which table look for a particular column
select ename, job, sal
from emp, dept
where emp.deptno = dept.deptno
and dept.loc = 'DALLAS'

-- aliases 
select ename as first_name, job, e.sal
from emp e, dept d
where e.deptno = d.deptno
and d.loc = 'DALLAS'


select ename as first_name, job, e.sal, e.deptno, loc
from (select * from emp where job in ('MANAGER', 'CLERK')) e, (select * from dept where loc = 'DALLAS') d
where e.deptno = d.deptno

-------------------------------------------------------------------------------
------------------- 021 Joins Continued INNER  OUTER Joins --------------------
-------------------------------------------------------------------------------

-- inner join, right join, left join like a two circles partially overlapped

-- = sign to join
-- or INNER JOIN ON

select * from emp, dept
where emp.deptno = dept.deptno

-- INNER JOIN
select * 
from emp INNER JOIN dept
on emp.deptno = dept.deptno
-- only rows which deptno presented in both tables
-- 14 rows

-- RIGHT JOIN
select * 
from emp RIGHT JOIN dept
ON emp.deptno = dept.deptno
--! all rows from right table a added in final result, 
-- with NULLs at left (emp) side
-- 15 rows

select * 
from emp LEFT JOIN dept
ON emp.deptno = dept.deptno
-- 14 rows

-- what if change order of table names with same LEFT join
select * 
from dept LEFT JOIN emp
ON emp.deptno = dept.deptno
-- order is matter
--! 15 rows

-- OUTER just a syntax
select * 
from dept LEFT OUTER JOIN emp
ON emp.deptno = dept.deptno

-- older implicit syntax
--! equivalent to LEFT OUTER JOIN syntax
select * 
from emp, dept
where dept.deptno = emp.deptno(+)
--! it means add all from left table regardless it's join or not to right table

-- FULL OUTER JOIN shows null on both sides
select * 
FROM (select * from emp) e 
FULL OUTER JOIN dept 
ON e.deptno = dept.deptno

select * 
FROM (select * from emp where job = 'SALESMAN') e 
FULL OUTER JOIN dept 
ON e.deptno = dept.deptno

-- ############################################################################
-- same result as above, but with LEFT JOIN
-- ############################################################################

select empno, ename, job, mgr, hiredate, sal, comm, e.deptno as deptno, dept.deptno as deptno, dname, loc  
FROM dept left JOIN (select * from emp where job = 'SALESMAN') e
ON dept.deptno = e.deptno





-------------------------------------------------------------------------------
----------------- 022 More Joins With  Correlated Subqueries ------------------
-------------------------------------------------------------------------------

--! EXISTS is a condition which used in combination with subquery
--! net exists is very inefficient tool, because it should check every single record
--! use EXISTS condition with Correlated Subquery

select empno, ename, job, mgr, hiredate, sal, comm, emp_deptno as deptno, dept_deptno as deptno, dname, loc from (
select empno, ename, job, mgr, hiredate, sal, comm, e.deptno as emp_deptno, dept.deptno as dept_deptno, loc  
FROM dept left JOIN (select * from emp where job = 'SALESMAN') e
ON dept.deptno = e.deptno)

-- tablename.* returns all data in tablename dataset
select e.*, dept.deptno as deptno, dname, loc  
FROM dept left JOIN (select * from emp where job = 'SALESMAN') e
ON dept.deptno = e.deptno

select e.*, dept.* 
FROM dept left JOIN (select * from emp where job = 'SALESMAN') e
ON dept.deptno = e.deptno

-- EXISTS at least one row exist

select * from emp
where NOT EXISTS (select 'random' from dual)
-- no data found, because of NOT

--! NULL in subquery are still a record 
select * from emp
where EXISTS (select NULL from dual)
-- return full table

select * from emp
where EXISTS (select * from emp where job = 'PROGRAMMER')
-- no data found, because there is no such job record

-- alias from outer query
select * from dept d
where exists (select * from emp where d.deptno = emp.deptno)
--! its SLOW because subquery is gonna run for every record in outer query of dept table

-- which records are uniq for dept table
select * from dept d
where NOT exists (select * from emp where d.deptno = emp.deptno)

select * from dept d
where NOT exists (select * from emp where d.deptno = emp.deptno)
OR loc = 'CHICAGO'
--! return both records, Boston and Chicago

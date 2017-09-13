
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
------------------ 020 Relating Tables Together Using JOINs ------------------
-------------------------------------------------------------------------------

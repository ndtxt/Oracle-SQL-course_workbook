
--------------------- 019 SELECT within SELECT Subqueries ---------------------

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

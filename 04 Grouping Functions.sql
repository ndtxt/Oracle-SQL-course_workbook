
-------------------------------------------------------------------------------
---------------- 016 Grouping Functions MIN MAX AVG COUNT etc -----------------
-------------------------------------------------------------------------------

-- Grouping function get many rows and return one row. Many inputs, one output.
-- Single row function instead get 4 rows and return 4 results

-- scalar value means 1 unit of data

select max(sal) as max_sal from emp;

select min(sal) as min_sal from emp;

select sum(sal) as sum_sal from emp;

-- ############################################################################
-- return a salary of a highest payed manager
-- ############################################################################

select * from emp 
where lower(job) like 'manager'
order by job, sal desc

select max(sal) as max_manager_sal 
from emp
where job = 'MANAGER';

select max(sal) as max_manager_sal from emp
where lower(job) like '%manager%'


select avg(sal) as avg_sal from emp;
-- 2073.21428571428571428571428571428571429

--! count only cells with data
-- count anything even salary or hiredate
select count(ename) as count_emp from emp;
select count(sal) as count from emp;

-- wild card * if u want to count rows in particular table
select count(*) as count from emp;

--! only 4 employees have a commission
select count(comm) as count from emp;

select sum(sal) / count(*) as computed_avg, avg(sal) as native_avg from emp;
-- 2073.2142857142857142857142857142857142

select sum(sal) as sum, avg(sal) as avg, max(sal) as max, min(sal) as min, 
count(*) as count 
from emp;

select avg(sal)
from emp
where job = 'CLERK'

select avg(sal)
from emp
where job = 'MANAGER'

select avg(sal)
from emp
where job = 'SALESMAN'




-------------------------------------------------------------------------------
--------------------- 017 GROUP BY Clause  HAVING Clause ----------------------
-------------------------------------------------------------------------------

-- The HAVING clause is like the WHERE clause,
-- except it acts on the grouped data.

-- grouped by keyword, by something

select avg(sal), job
from emp
group by job

select job from emp
group by job
-- it returns uniq values of the job column

select count(*), job
from emp
group by job

select distinct job from emp;

--! No Group functions allowed with WHERE clause

-- count only for groups with 2 records
select count(*), job
from emp
group by job
HAVING count(*) = 2

select job
from emp
group by job
HAVING count(*) = 2

1) select job
2) from emp
3) where
4) group by job
5) having count(*) = 2
6) order by


-- ############################################################################
-- return those department numbers, that have more than 3 employees
-- ############################################################################

select deptno
from emp
group by deptno
HAVING count(ename) >= 4

select deptno, count(*)
from emp
group by deptno
HAVING count(ename) >= 4




-------------------------------------------------------------------------------
----------------- 018 More Practice With The GROUP BY Clause ------------------
-------------------------------------------------------------------------------

select job, deptno, count(*) as emps_by_dept
from emp
group by job, deptno;

SELECT col_1, col_2, col_3, group_function(aggregate_expression)
FROM tables
[ WHERE conditions ]
GROUP BY col_1, col_2, col_3, ..., col_n
[ ORDER BY conditions ]

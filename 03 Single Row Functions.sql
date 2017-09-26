

-------------------------------------------------------------------------------
------------- 011 Single Row Functions SRF  Using The Dual Table --------------
-------------------------------------------------------------------------------

-- SQL functions, single row functions (SRF), Dual Table
-- function is a predefined program that performs some tasks
-- SRF work on a single row at a time
--
-- Grouping functions get many rows and return 1 row 

select 'my name is ' || ename as hello from emp;
select concat('my name is ', ename) as hello from emp;

-- upper('sometext') uppercase text for every single row in table
select upper('hey') from emp;
-- same as
select 'HEY' from emp;

-- DUAL tabel to test functions like this
select lower('HEY') from DUAL;

select 'pizza' as food, 'fanta' as drink, concat('Hello ','John') as "This is a func" from dual;

-- functions nesting
select concat( lower(ename), ' this is a name') from emp;

-- ############################################################################
-- expected result is below:
-- johns IS THE NAME and their job is: MANAGER
-- scott IS THE NAME and their job is: ANALYST
-- ...
-- ############################################################################

select concat(lower(ename), upper(' is the name')) || concat(' and their job is: ', job) 
as "function call" from emp where deptno = 20;

select concat( concat(lower(ename), upper(' is the name')), concat(' and their job is: ', job)) 
as "function call" from emp where deptno = 20;




-------------------------------------------------------------------------------
------------ 012 Using Functions in WHERE And Character Based SRFs ------------
-------------------------------------------------------------------------------

select *
from emp
where job = lower('MANAGER');
-- no data found

-- there are character based functions and numeric functions

-- capitalize
select initcap('hello world') from dual;

select length('hello world') as lenght from dual;

select length(ename) as lenght from emp;

select ename, length(ename) as lenght from emp;

select ename, length(ename) as lenght 
from emp
where length(ename) = 6;

select 'hello', substr('hello', 2, 3) from dual;
-- ell

-- from 2 char to the end
select 'hello', substr('hello', 2) from dual;


select LPAD('hello', 10, '&*') from dual;
-- &*&*&hello
select rtrim('ooohelloooo', 'o') from dual;
-- ooohell



-------------------------------------------------------------------------------
--------------------- 013 Numeric and Date Data type SRFs ---------------------
-------------------------------------------------------------------------------

select round(107.088, 2) from dual;
-- 107.09

select round(107.0887) from dual;
-- 107

select trunc(107.9887) from dual;
-- 107

-- truncate all after 3rd position
select trunc(107.988776, 3) from dual;

-- date functions
select sysdate from dual;
-- 09/12/2017

select systimestamp from dual;
-- 12-SEP-17 11.10.20.899460 AM +00:00

-- 'month day year'
select add_months('12/09.2017', -3) from dual;
-- 09/09/2017

select add_months('1209-17', -3) from dual;
-- 09/09/0017

--! February
select add_months('11-30-2017', 3) from dual;
--! 02/28/2018

select add_months(sysdate, 300) from dual;
-- 09/12/2042

-- function calculates the fraction based on a 31-day month
select months_between('11302017', '11242018') from dual;
-- -11.806451612903225806451612903225806452

select trunc(systimestamp) from dual;
-- 09/12/2017

select systimestamp from dual;
-- select systimestamp from dual;

-- first date of the 'YEAR'
select trunc(systimestamp, 'year') from dual;

select to_date('11302017') from dual;
-- 11/30/2017

select trunc(to_date('11302017'), 'year') from dual;
-- 01/01/2017

-- first date of month
select trunc(systimestamp, 'month') from dual;
-- 09/01/2017

select ename, hiredate, trunc(hiredate, 'month') from emp;

select ename, hiredate, trunc(hiredate, 'month') from emp
where trunc(hiredate, 'year') = '01/01/1982';




-------------------------------------------------------------------------------
-------------------- 014 Conversion SRFs  Date Formatting ---------------------
-------------------------------------------------------------------------------

select to_char(sysdate, 'dd-mm-yyyy') from dual;
-- 12-09-2017

select to_char(sysdate, 'ddth "of" month, yyyy') from dual;
-- 12th of september, 2017

-- ############################################################################
-- input: 12400.8
-- output: 12,400.80
-- ############################################################################

select ename, sal, to_char( sal, '$99,999.99') salaries from emp;

-- string with maybe date and pattern, how to read it
select to_date('2012-08-27', 'yyyy-mm-dd') from dual;
-- 08/27/2012 - was converted to standard date format

select add_months(to_date('2012-08-27', 'yyyy-mm-dd'), 2) from dual;
select to_date('12 of June, 2012', 'dd "of" Month, yyyy') from dual;




-------------------------------------------------------------------------------
----------------- 015 Concluding SRFs NULL NULLIF Functions  ------------------
-------------------------------------------------------------------------------

-- to_char function has 
-- converted comm column with numbers to column with strings
-- than we could apply nvl and replace one text to another one
select ename, job, sal, NVL(to_char(comm), 'No data found')
from emp
where empno in (7839, 7698, 7566, 7654)

-- ############################################################################
-- replace Null (- sign) to string 'lenght is 5'
-- ############################################################################
select ename, length(ename), 
nvl(to_char(nullif(length(ename), 5)), 'lenght is 5') 
from emp;

-- another way, convert every parameter
select ename, length(ename), 
nvl((nullif(to_char(length(ename)), to_char(5))), 'lenght is 5') 
from emp;

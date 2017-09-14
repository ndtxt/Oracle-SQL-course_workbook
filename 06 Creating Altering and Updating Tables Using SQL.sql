
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


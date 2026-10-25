-- Assignment 02: SQL JOINs
-- BikeStores SQL Server Database

-- 2.1. List every product with its brand name
SELECT
    p.product_name,
    b.brand_name
FROM production.products AS p
INNER JOIN production.brands AS b
    ON p.brand_id = b.brand_id;


-- 2.2. Find every store with zero staff currently assigned to it
SELECT
    s.store_id,
    s.store_name
FROM sales.stores AS s
LEFT JOIN sales.staffs AS st
    ON s.store_id = st.store_id
WHERE st.staff_id IS NULL;


-- 2.3. Return products with fewer than 5 units in stock at store 1
SELECT
    p.product_name,
    s.quantity
FROM production.products AS p
LEFT JOIN production.stocks AS s
    ON p.product_id = s.product_id
WHERE s.store_id = 1
  AND s.quantity < 5;


-- 2.4. List every manager with each employee they manage.
-- The placeholder column shows 1 for each employee-manager pair.
SELECT
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    1 AS employee_count
FROM sales.staffs AS e
INNER JOIN sales.staffs AS m
    ON e.manager_id = m.staff_id;


-- 2.5. List every item in order #1, including product name and quantity
SELECT
    o.order_id,
    p.product_name,
    oi.quantity
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN production.products AS p
    ON oi.product_id = p.product_id
WHERE o.order_id = 1;


-- 2.6. Explain/fix inflated order counts caused by joining orders
-- to order_items. Use COUNT(DISTINCT) so each order is counted once.
SELECT
    COUNT(DISTINCT o.order_id) AS true_order_count
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id;


-- 2.7. Example of a deliberate CROSS JOIN.
-- It produces every possible store/product combination.
SELECT
    s.store_name,
    p.product_name
FROM sales.stores AS s
CROSS JOIN production.products AS p;

-- CROSS JOIN explanation:
-- A CROSS JOIN has no ON condition and combines every row from the
-- first table with every row from the second table. It can create
-- a very large number of rows, so an accidental missing ON clause
-- should be checked carefully.

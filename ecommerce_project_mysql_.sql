-- E-COMMERCE DATABASE SIMULATION PROJECT (MySQL Workbench)


CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Drop tables in reverse FK order (so you can re-run the script)
DROP TABLE IF EXISTS shipping;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;


-- 1. TABLE DESIGN


-- 1.1 Users
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender CHAR(1),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

-- 1.2 Categories (self-referencing for hierarchy)
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
);

-- 1.3 Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    category_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 1.4 Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 1.5 Order Items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 1.6 Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 1.7 Reviews
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    review_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 1.8 Shipping
CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    shipped_date DATETIME,
    delivered_date DATETIME,
    shipping_status VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- 2. SAMPLE DATA


-- 2.1 Users
INSERT INTO users (name, email, phone, date_of_birth, gender)
VALUES
('Amit Sharma', 'amit@example.com', '9991110001', '1995-01-10', 'M'),
('Priya Verma', 'priya@example.com', '9991110002', '1998-03-22', 'F'),
('Rahul Singh', 'rahul@example.com', '9991110003', '1992-07-05', 'M'),
('Sneha Patel', 'sneha@example.com', '9991110004', '1997-11-15', 'F'),
('Vikram Rao', 'vikram@example.com', '9991110005', '1990-09-30', 'M'),
('Neha Gupta', 'neha@example.com', '9991110006', '1996-05-12', 'F'),
('Arjun Mehta', 'arjun@example.com', '9991110007', '1994-12-01', 'M'),
('Kavya Iyer', 'kavya@example.com', '9991110008', '1999-02-08', 'F');

-- 2.2 Categories
INSERT INTO categories (category_id, category_name, parent_category_id)
VALUES
(1, 'Electronics', NULL),
(2, 'Mobiles', 1),
(3, 'Laptops', 1),
(4, 'Accessories', 1),
(5, 'Home Appliances', NULL),
(6, 'Fashion', NULL),
(7, 'Books', NULL),
(8, 'Sports', NULL),
(9, 'Beauty', NULL),
(10, 'Groceries', NULL);

-- 2.3 Products
INSERT INTO products (name, description, price, stock_quantity, category_id)
VALUES
('Smartphone A', 'Basic smartphone with 64GB storage', 12000.00, 50, 2),
('Smartphone B', 'Mid-range smartphone with 128GB storage', 18000.00, 30, 2),
('Laptop X', '14-inch laptop with 8GB RAM', 45000.00, 20, 3),
('Laptop Y', '15.6-inch laptop with 16GB RAM', 65000.00, 15, 3),
('Wireless Earbuds', 'Bluetooth earbuds with charging case', 2500.00, 80, 4),
('Wired Headphones', 'Over-ear wired headphones', 1500.00, 60, 4),
('Microwave Oven', '20L solo microwave oven', 7000.00, 10, 5),
('Air Fryer', '3.5L digital air fryer', 9000.00, 12, 5),
('T-Shirt', 'Cotton round-neck T-shirt', 600.00, 100, 6),
('Running Shoes', 'Lightweight running shoes', 2500.00, 40, 8),
('Novel: The Journey', 'Best-selling fiction novel', 400.00, 70, 7),
('Face Cream', 'Daily moisturizing cream', 350.00, 50, 9);

-- 2.4 Orders
INSERT INTO orders (user_id, order_date, status, total_amount)
VALUES
(1, '2024-01-05 10:15:00', 'Delivered', 14500.00),
(2, '2024-01-07 14:30:00', 'Delivered', 18000.00),
(3, '2024-01-10 09:45:00', 'Shipped', 47500.00),
(4, '2024-01-12 16:00:00', 'Delivered', 3100.00),
(5, '2024-01-15 11:20:00', 'Processing', 9500.00),
(1, '2024-02-02 13:30:00', 'Delivered', 2900.00),
(2, '2024-02-05 18:10:00', 'Delivered', 7000.00),
(6, '2024-02-10 19:00:00', 'Delivered', 2900.00),
(7, '2024-02-15 12:25:00', 'Shipped', 67500.00),
(8, '2024-02-20 17:50:00', 'Processing', 400.00);

-- 2.5 Order Items
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
VALUES
-- Order 1 (Amit)
(1, 1, 1, 12000.00),
(1, 5, 1, 2500.00),

-- Order 2 (Priya)
(2, 2, 1, 18000.00),

-- Order 3 (Rahul)
(3, 3, 1, 45000.00),
(3, 5, 1, 2500.00),

-- Order 4 (Sneha)
(4, 11, 5, 400.00),
(4, 12, 1, 350.00),

-- Order 5 (Vikram)
(5, 8, 1, 9000.00),
(5, 9, 1, 600.00),

-- Order 6 (Amit again)
(6, 6, 1, 1500.00),
(6, 9, 1, 600.00),
(6, 11, 2, 400.00),

-- Order 7 (Priya again)
(7, 7, 1, 7000.00),

-- Order 8 (Neha)
(8, 10, 1, 2500.00),
(8, 12, 1, 350.00),

-- Order 9 (Arjun)
(9, 4, 1, 65000.00),
(9, 10, 1, 2500.00),

-- Order 10 (Kavya)
(10, 11, 1, 400.00);

-- 2.6 Payments
INSERT INTO payments (order_id, payment_date, amount, payment_method, status)
VALUES
(1, '2024-01-05 10:20:00', 14500.00, 'UPI', 'Success'),
(2, '2024-01-07 14:35:00', 18000.00, 'Credit Card', 'Success'),
(3, '2024-01-10 09:50:00', 47500.00, 'Net Banking', 'Success'),
(4, '2024-01-12 16:05:00', 3100.00, 'UPI', 'Success'),
(5, '2024-01-15 11:25:00', 9500.00, 'Debit Card', 'Pending'),
(6, '2024-02-02 13:35:00', 2900.00, 'UPI', 'Success'),
(7, '2024-02-05 18:15:00', 7000.00, 'Credit Card', 'Success'),
(8, '2024-02-10 19:05:00', 2900.00, 'UPI', 'Success'),
(9, '2024-02-15 12:30:00', 67500.00, 'Credit Card', 'Success'),
(10, '2024-02-20 17:55:00', 400.00, 'UPI', 'Pending');

-- 2.7 Reviews
INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
VALUES
(1, 1, 4, 'Good phone for the price', '2024-01-10 12:00:00'),
(2, 2, 5, 'Excellent performance', '2024-01-15 09:30:00'),
(3, 3, 4, 'Laptop is fast and light', '2024-01-20 15:45:00'),
(4, 11, 5, 'Loved the story!', '2024-01-25 18:10:00'),
(5, 8, 4, 'Air fryer is very useful', '2024-01-28 20:00:00'),
(1, 5, 3, 'Earbuds are okay', '2024-02-05 11:00:00'),
(6, 10, 5, 'Very comfortable shoes', '2024-02-12 19:30:00'),
(7, 4, 5, 'Powerful laptop!', '2024-02-18 16:00:00');

-- 2.8 Shipping
INSERT INTO shipping (order_id, shipping_address, city, state, pincode,
                      shipped_date, delivered_date, shipping_status)
VALUES
(1, '123 MG Road', 'Mumbai', 'Maharashtra', '400001',
 '2024-01-06 10:00:00', '2024-01-08 16:00:00', 'Delivered'),
(2, '45 Park Street', 'Kolkata', 'West Bengal', '700016',
 '2024-01-08 11:00:00', '2024-01-11 15:00:00', 'Delivered'),
(3, '78 Residency Lane', 'Delhi', 'Delhi', '110001',
 '2024-01-11 09:00:00', NULL, 'Shipped'),
(4, '9 Lake View', 'Pune', 'Maharashtra', '411001',
 '2024-01-13 12:00:00', '2024-01-16 14:00:00', 'Delivered'),
(5, '55 River Road', 'Ahmedabad', 'Gujarat', '380001',
 NULL, NULL, 'Processing'),
(6, '123 MG Road', 'Mumbai', 'Maharashtra', '400001',
 '2024-02-03 10:00:00', '2024-02-06 16:00:00', 'Delivered'),
(7, '45 Park Street', 'Kolkata', 'West Bengal', '700016',
 '2024-02-06 11:00:00', '2024-02-09 15:00:00', 'Delivered'),
(8, '21 Hill Top', 'Bengaluru', 'Karnataka', '560001',
 '2024-02-11 10:00:00', '2024-02-14 17:00:00', 'Delivered'),
(9, '92 Green Valley', 'Chennai', 'Tamil Nadu', '600001',
 '2024-02-16 09:30:00', NULL, 'Shipped'),
(10, '17 Sunset Road', 'Jaipur', 'Rajasthan', '302001',
 NULL, NULL, 'Processing');


-- 3. SQL QUERY PRACTICE


-- 3.1 Basic queries

-- 1) List all users
SELECT * FROM users;

-- 2) Products with price > 1000 and in stock
SELECT product_id, name, price, stock_quantity
FROM products
WHERE price > 1000 AND stock_quantity > 0;

-- 3) Orders sorted by total amount (highest first)
SELECT order_id, user_id, order_date, status, total_amount
FROM orders 
ORDER BY total_amount DESC;

-- 3.2 Aggregations

-- 4) Total sales per category
SELECT c.category_id,c.category_name,SUM(oi.quantity * oi.price_at_purchase) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_sales DESC;

-- 5) Average rating per product
SELECT p.product_id,p.name,AVG(r.rating) AS avg_rating,COUNT(r.review_id) AS number_of_reviews
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
ORDER BY avg_rating DESC;

-- 6) Number of orders per user
SELECT u.user_id,u.name,COUNT(o.order_id) AS total_orders
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY total_orders DESC;

-- 3.3 Joins

-- 7) INNER JOIN users and orders
SELECT o.order_id,u.name AS user_name,o.order_date,o.total_amount
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
ORDER BY o.order_date;

-- 8) Products with no reviews (LEFT JOIN)
SELECT p.product_id,p.name
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
WHERE r.product_id IS NULL;

-- 9) Parent-child categories (SELF JOIN)
SELECT c.category_id AS child_id,c.category_name AS child_name,p.category_id AS parent_id,p.category_name AS parent_name
FROM categories c
LEFT JOIN categories p ON c.parent_category_id = p.category_id
ORDER BY parent_name, child_name;

-- 3.4 Subqueries

-- 10) Products more expensive than avg price of their category
SELECT p.product_id,p.name,p.price,c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.price >
      (SELECT AVG(p2.price)
       FROM products p2
       WHERE p2.category_id = p.category_id);

-- 11) Users who spent more than 30000 in total
SELECT u.user_id, u.name
FROM users u
WHERE u.user_id IN (
    SELECT o.user_id
    FROM orders o
    GROUP BY o.user_id
    HAVING SUM(o.total_amount) > 30000
);

-- 3.5 CTEs & Views (MySQL 8+)

-- 12) Monthly sales using CTE
WITH monthly_sales AS (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS year_month,SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT * FROM monthly_sales;

-- 13) View: top selling products
CREATE OR REPLACE VIEW top_selling_products AS
SELECT p.product_id,p.name,SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_quantity_sold DESC;

-- 14) View: high value customers (spent > 30000)
CREATE OR REPLACE VIEW high_value_customers AS
SELECT u.user_id,u.name,SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
HAVING SUM(o.total_amount) > 30000
ORDER BY total_spent DESC;

-- 3.6 Functions

-- 15) Cleaned email (lower + trim)
SELECT user_id,name,email,LOWER(TRIM(email)) AS cleaned_email
FROM users;

-- 16) Orders where delivery took more than 7 days
SELECT o.order_id,o.order_date,s.shipped_date,s.delivered_date,DATEDIFF(s.delivered_date, o.order_date) AS days_taken
FROM orders o
JOIN shipping s ON o.order_id = s.order_id
WHERE s.delivered_date IS NOT NULL AND DATEDIFF(s.delivered_date, o.order_date) > 7;

-- 17) 10% discount on each order
SELECT order_id,total_amount,(total_amount * 0.10) AS discount_amount,(total_amount * 0.90) AS discounted_total
FROM orders;

-- 3.7 Indexes

-- 18) Index on user_id in orders
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- 19) Index on product_id in order_items
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- 3.8 Temporary table & Transaction

-- 20) Daily revenue (temporary table)
CREATE TEMPORARY TABLE daily_revenue AS
SELECT DATE(order_date) AS order_day,SUM(total_amount) AS daily_total
FROM orders
GROUP BY DATE(order_date);

SELECT * FROM daily_revenue;

-- 21) Simple transaction example (place new order)

START TRANSACTION;

INSERT INTO orders (user_id, order_date, status, total_amount)
VALUES (1, NOW(), 'Processing', 12000.00);

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
VALUES (@new_order_id, 1, 1, 12000.00);

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

INSERT INTO payments (order_id, payment_date, amount, payment_method, status)
VALUES (@new_order_id, NOW(), 12000.00, 'UPI', 'Success');

COMMIT;

-- END

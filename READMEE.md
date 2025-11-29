# E-Commerce SQL Project (MySQL Workbench)

This repository contains a complete **SQL project** for an E-Commerce system, built and tested for **MySQL 8 / MySQL Workbench**.


---

## 1. Project Overview

The database simulates a simple online store where:

- Users register and place orders
- Products belong to categories (with parent–child relationship)
- Each order has multiple order items
- Payments are tracked
- Users can write product reviews
- Shipping details (address, status, dates) are stored

This project focuses only on **pure SQL** (no frontend / backend code), so you can clearly show your **database design and query skills**.

---


---

## 2. Files

- `ecommerce_project_mysql.sql`
  - Creates the database `ecommerce_db`
  - Creates all tables with relationships
  - Inserts sample data
  - Includes a set of practice queries (SELECT, JOIN, GROUP BY, CTE, VIEW, INDEX, TRANSACTION, etc.)



## 3. Database Schema (Tables)

The script creates the following tables:

1. **`users`**
   Stores customer information.
   - `user_id`, `name`, `email`, `phone`, `date_of_birth`, `gender`, `created_at`, `updated_at`

2. **`categories`**
   Product categories with optional parent category (for hierarchy).
   - `category_id`, `category_name`, `parent_category_id`

3. **`products`**
   All products sold on the platform.
   - `product_id`, `name`, `description`, `price`, `stock_quantity`, `category_id`, timestamps

4. **`orders`**
   Each row represents one order placed by a user.
   - `order_id`, `user_id`, `order_date`, `status`, `total_amount`

5. **`order_items`**
   Line items inside each order (one order can have many items).
   - `order_item_id`, `order_id`, `product_id`, `quantity`, `price_at_purchase`

6. **`payments`**
   Payments for each order.
   - `payment_id`, `order_id`, `payment_date`, `amount`, `payment_method`, `status`

7. **`reviews`**
   Product ratings and comments from users.
   - `review_id`, `user_id`, `product_id`, `rating`, `comment`, `review_date`

8. **`shipping`**
   Shipping and delivery details.
   - `shipping_id`, `order_id`, `shipping_address`, `city`, `state`, `pincode`, `shipped_date`, `delivered_date`, `shipping_status`

All tables are connected with **primary keys** and **foreign keys**.

---

## 6. SQL Topics Covered

The project covers most important SQL topics in simple form:

### ✅ Basic Queries
- SELECT, WHERE, ORDER BY
- Example: list all users, list products above a certain price, sort orders by total amount.

### ✅ Joins
- `INNER JOIN` between users and orders
- `LEFT JOIN` to find products with no reviews
- `SELF JOIN` on categories to show parent–child relations

### ✅ Aggregations
- `SUM`, `AVG`, `COUNT` with `GROUP BY`
- Total sales per category
- Average rating per product
- Total orders per user

### ✅ Subqueries
- Products more expensive than the **average price** of their category
- Users who spent more than a given total amount

### ✅ CTEs & Views 
- CTE to calculate monthly sales
- View: `top_selling_products`
- View: `high_value_customers`

### ✅ Functions
- String functions: `LOWER`, `TRIM`
- Date function: `DATEDIFF` (to check delivery delay)
- Arithmetic expressions: discounts on order totals

### ✅ Indexes & Performance
- Index on `orders(user_id)`
- Index on `order_items(product_id)`

### ✅ Temporary Tables & Transactions
- Temporary table to store daily revenue summary
- Simple transaction to simulate placing an order:
  - Insert order
  - Insert order items
  - Update product stock
  - Insert payment
  - Commit transaction

---

-- END --

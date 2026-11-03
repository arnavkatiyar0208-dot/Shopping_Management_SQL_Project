DROP DATABASE IF EXISTS Shopping_Management;
CREATE DATABASE Shopping_Management;

USE Shopping_Management;
CREATE TABLE customers
(
    Customer_Id INT AUTO_INCREMENT PRIMARY KEY,

    Customer_Name VARCHAR(100) NOT NULL,

    Email VARCHAR(100) UNIQUE,

    Phone_Number VARCHAR(10) NOT NULL UNIQUE,

    Age INT CHECK (Age > 0),

    Gender ENUM('Male', 'Female', 'Other'),

    Country VARCHAR(50) DEFAULT 'India',

    City VARCHAR(50) NOT NULL,

    Pincode CHAR(6) DEFAULT '201301',

    Registration_Date DATE DEFAULT (CURRENT_DATE),

    Registration_Time TIME DEFAULT (CURRENT_TIME),

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Address VARCHAR(250),

    Customer_Status ENUM('Active', 'Inactive', 'Blocked')
    DEFAULT 'Active',

    Customer_Notes TEXT,

    CHECK (Phone_Number REGEXP '^[0-9]{10}$'),

    CHECK (Pincode REGEXP '^[0-9]{6}$'),

    CHECK (OCTET_LENGTH(Customer_Notes) < 1024)

);

CREATE TABLE orders
(
    Order_Id INT AUTO_INCREMENT PRIMARY KEY,

    Customer_Id INT NOT NULL,

    Order_Date DATE DEFAULT (CURRENT_DATE),

    Order_Amount DECIMAL(10,2) NOT NULL,

    Order_Status ENUM(
        'Pending',
        'Processing',
        'Shipped',
        'Delivered',
        'Cancelled'
    ) DEFAULT 'Pending',

    Payment_Method ENUM(
        'Cash',
        'Card',
        'UPI',
        'Net Banking'
    ),

    Payment_Status ENUM(
        'Pending',
        'Paid',
        'Failed'
    ) DEFAULT 'Pending',

    Shipping_Address VARCHAR(250) NOT NULL,

    Delivery_Pincode CHAR(6),

    Quantity INT NOT NULL CHECK (Quantity > 0),

    Discount_Amount DECIMAL(10,2) DEFAULT 0.00,

    Delivery_Date DATE DEFAULT NULL,

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Tracking_Number VARCHAR(30) UNIQUE,

    Delivery_Status ENUM(
        'Not Dispatched',
        'In Transit',
        'Delivered',
        'Returned'
    ) DEFAULT 'Not Dispatched',

    Order_Notes TEXT,

    CHECK (Order_Amount >= 0),

    CHECK (Discount_Amount >= 0),

    CHECK (Delivery_Pincode IS NULL OR
           Delivery_Pincode REGEXP '^[0-9]{6}$'),

    CHECK (OCTET_LENGTH(Order_Notes) < 1024)

);


ALTER TABLE orders

ADD CONSTRAINT fk_customer_orders

FOREIGN KEY (Customer_Id)

REFERENCES customers(Customer_Id)

ON DELETE CASCADE

ON UPDATE CASCADE;









SHOW DATABASES;

USE Shopping_Management;

SHOW TABLES;

DESC customers;

SHOW CREATE TABLE customers;

SHOW CREATE TABLE orders;

INSERT INTO customers
(
    Customer_Name,
    Email,
    Phone_Number,
    Age,
    Gender,
    City,
    Address
)
VALUES
(
    'Rahul Sharma',
    'rahul@gmail.com',
    '9876543210',
    23,
    'Male',
    'Noida',
    'Sector 62, Noida'
),
(
    'Priya Verma',
    'priya@gmail.com',
    '8765432109',
    22,
    'Female',
    'Lucknow',
    'Gomti Nagar, Lucknow'
),
(
    'Amit Kumar',
    'amit@gmail.com',
    '7654321098',
    25,
    'Male',
    'Kanpur',
    'Kakadeo, Kanpur'
);

SELECT * FROM customers;

INSERT INTO orders
(
    Customer_Id,
    Order_Amount,
    Order_Status,
    Payment_Method,
    Payment_Status,
    Shipping_Address,
    Delivery_Pincode,
    Quantity,
    Discount_Amount,
    Tracking_Number,
    Delivery_Status
)
VALUES
(
    1,
    2500.00,
    'Processing',
    'UPI',
    'Paid',
    'Sector 62, Noida',
    '201301',
    2,
    100.00,
    'TRK1001',
    'Not Dispatched'
),
(
    2,
    1500.00,
    'Pending',
    'Card',
    'Pending',
    'Gomti Nagar, Lucknow',
    '226010',
    1,
    50.00,
    'TRK1002',
    'Not Dispatched'
),
(
    3,
    3500.00,
    'Shipped',
    'Cash',
    'Paid',
    'Kakadeo, Kanpur',
    '208025',
    3,
    200.00,
    'TRK1003',
    'In Transit'
);

SELECT * FROM orders;

SELECT
    customers.Customer_Id,
    customers.Customer_Name,
    customers.City,
    orders.Order_Id,
    orders.Order_Amount,
    orders.Order_Status

FROM customers

INNER JOIN orders

ON customers.Customer_Id = orders.Customer_Id;

DELETE FROM customers
WHERE Customer_Id = 1;

SELECT * FROM orders;

UPDATE customers
SET Customer_Id = 10
WHERE Customer_Id = 2;

SELECT * FROM orders;
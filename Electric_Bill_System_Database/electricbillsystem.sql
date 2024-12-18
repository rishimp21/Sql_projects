-- Create Database
CREATE DATABASE ElectricBillSystem;

-- Use the Database
USE ElectricBillSystem;

-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Meters Table
CREATE TABLE meters (
    meter_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    meter_number VARCHAR(50) UNIQUE NOT NULL,
    meter_type ENUM('Residential', 'Commercial') NOT NULL,
    installation_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Billing Table
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    meter_id INT NOT NULL,
    billing_month DATE NOT NULL,
    units_consumed DECIMAL(10, 2) NOT NULL,
    amount_due DECIMAL(10, 2) NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('Pending', 'Paid') DEFAULT 'Pending',
    FOREIGN KEY (meter_id) REFERENCES meters(meter_id) ON DELETE CASCADE
);

-- 4. Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Online Transfer') NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES billing(bill_id) ON DELETE CASCADE
);

-- Sample Data Insertion

-- Insert Customers
INSERT INTO customers (first_name, last_name, email, phone, address)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Oak Avenue');

-- Insert Meters
INSERT INTO meters (customer_id, meter_number, meter_type, installation_date)
VALUES
(1, 'MTR-1001', 'Residential', '2024-01-15'),
(2, 'MTR-1002', 'Commercial', '2024-02-01');

-- Insert Billing Records
INSERT INTO billing (meter_id, billing_month, units_consumed, amount_due, due_date)
VALUES
(1, '2024-03-01', 150.5, 75.25, '2024-03-15'),
(2, '2024-03-01', 500.0, 250.00, '2024-03-20');

-- Insert Payments
INSERT INTO payments (bill_id, payment_date, payment_amount, payment_method)
VALUES
(1, '2024-03-10', 75.25, 'Online Transfer'),
(2, '2024-03-18', 250.00, 'Card');

-- Query Examples

-- View All Customers
SELECT * FROM customers;

-- View Billing Details
SELECT b.bill_id, c.first_name, c.last_name, m.meter_number, b.billing_month, b.units_consumed, b.amount_due, b.status
FROM billing b
JOIN meters m ON b.meter_id = m.meter_id
JOIN customers c ON m.customer_id = c.customer_id;

-- View Payments
SELECT p.payment_id, c.first_name, c.last_name, b.billing_month, p.payment_date, p.payment_amount, p.payment_method
FROM payments p
JOIN billing b ON p.bill_id = b.bill_id
JOIN meters m ON b.meter_id = m.meter_id
JOIN customers c ON m.customer_id = c.customer_id;


 
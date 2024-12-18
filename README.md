The **Electric Bill System Database** is a robust SQL-based project designed to manage electricity billing processes efficiently. This system can be used by utility companies to automate and streamline their billing, payment tracking, and customer management processes. Below is a comprehensive breakdown of the database and its functionalities.

---

## **Project Objectives**

1. **Customer Management**: Maintain detailed records of customers including their personal details and address.
2. **Meter Management**: Link each customer to one or more electricity meters and track the type and installation details of the meters.
3. **Billing System**: Automate the generation of monthly bills for electricity usage and calculate due amounts.
4. **Payment Tracking**: Track payments made by customers against their bills.
5. **Dynamic Queries**: Provide the ability to query the database for various reports like outstanding bills, payment history, and usage statistics.

---

## **Database Schema**

### 1. **`customers` Table**
- **Purpose**: Store details of electricity customers.
- **Columns**:
  - `customer_id`: Unique identifier for each customer.
  - `first_name` and `last_name`: Name of the customer.
  - `email` and `phone`: Contact details.
  - `address`: Customer's physical address.
  - `created_at`: Timestamp indicating when the customer record was added.

---

### 2. **`meters` Table**
- **Purpose**: Store details of electricity meters assigned to customers.
- **Columns**:
  - `meter_id`: Unique identifier for each meter.
  - `customer_id`: Foreign key linking the meter to a specific customer.
  - `meter_number`: Unique number for identifying the meter.
  - `meter_type`: Type of meter (`Residential` or `Commercial`).
  - `installation_date`: Date when the meter was installed.
- **Relationships**:
  - Each customer can have multiple meters.
  - `ON DELETE CASCADE`: If a customer is deleted, their associated meters are also removed.

---

### 3. **`billing` Table**
- **Purpose**: Store monthly billing records for each meter.
- **Columns**:
  - `bill_id`: Unique identifier for each bill.
  - `meter_id`: Foreign key linking the bill to a specific meter.
  - `billing_month`: The month for which the bill is generated.
  - `units_consumed`: The number of units of electricity consumed.
  - `amount_due`: The total amount payable for the units consumed.
  - `due_date`: The payment due date.
  - `status`: Indicates whether the bill is `Pending`, `Paid`, or `Overdue`.
- **Relationships**:
  - Each meter generates monthly bills.

---

### 4. **`payments` Table**
- **Purpose**: Store payment details for each bill.
- **Columns**:
  - `payment_id`: Unique identifier for each payment.
  - `bill_id`: Foreign key linking the payment to a specific bill.
  - `payment_date`: Date the payment was made.
  - `payment_amount`: Amount paid.
  - `payment_method`: Method of payment (`Cash`, `Card`, or `Online Transfer`).
- **Relationships**:
  - Each bill can have multiple payments associated with it.

---

## **Key Features**

### **1. Customer Management**
- The `customers` table allows the system to store and retrieve customer information easily.
- Enables linking of customers to one or more meters through the `meters` table.

### **2. Meter Management**
- Each meter is uniquely identified and tied to a customer.
- The `meter_type` field enables the differentiation between `Residential` and `Commercial` meters.

### **3. Billing Automation**
- Bills are generated monthly for each meter based on the electricity usage recorded in the `units_consumed` field.
- The `amount_due` is calculated dynamically using a tariff system (which can be implemented in future iterations).

### **4. Payment Tracking**
- The `payments` table records all payments made by customers.
- It allows querying for payment history and outstanding bills.

### **5. Flexible Queries**
- The database structure supports a variety of queries:
  - View all customers and their meters.
  - Retrieve all bills for a specific customer.
  - List all outstanding bills.
  - Generate a report of monthly revenue.

---

## **Sample Data**

### Customers
| customer_id | first_name | last_name | email               | phone      | address         |
|-------------|------------|-----------|---------------------|------------|-----------------|
| 1           | John       | Doe       | john.doe@example.com | 1234567890 | 123 Elm Street |
| 2           | Jane       | Smith     | jane.smith@example.com | 9876543210 | 456 Oak Avenue |

### Meters
| meter_id | customer_id | meter_number | meter_type  | installation_date |
|----------|-------------|--------------|-------------|-------------------|
| 1        | 1           | MTR-1001     | Residential | 2024-01-15        |
| 2        | 2           | MTR-1002     | Commercial  | 2024-02-01        |

### Billing
| bill_id | meter_id | billing_month | units_consumed | amount_due | due_date   | status  |
|---------|----------|---------------|----------------|------------|------------|---------|
| 1       | 1        | 2024-03-01    | 150.5          | 75.25      | 2024-03-15 | Paid    |
| 2       | 2        | 2024-03-01    | 500.0          | 250.00     | 2024-03-20 | Pending |

### Payments
| payment_id | bill_id | payment_date | payment_amount | payment_method   |
|------------|---------|--------------|----------------|------------------|
| 1          | 1       | 2024-03-10   | 75.25          | Online Transfer  |
| 2          | 2       | 2024-03-18   | 250.00         | Card             |

---

## **Query Examples**

### 1. View All Customers
```sql
SELECT * FROM customers;
```

### 2. View Billing Details
```sql
SELECT 
    b.bill_id, c.first_name, c.last_name, m.meter_number, b.billing_month, 
    b.units_consumed, b.amount_due, b.status
FROM billing b
JOIN meters m ON b.meter_id = m.meter_id
JOIN customers c ON m.customer_id = c.customer_id;
```

### 3. View Payments
```sql
SELECT 
    p.payment_id, c.first_name, c.last_name, b.billing_month, 
    p.payment_date, p.payment_amount, p.payment_method
FROM payments p
JOIN billing b ON p.bill_id = b.bill_id
JOIN meters m ON b.meter_id = m.meter_id
JOIN customers c ON m.customer_id = c.customer_id;
```

---

## **Future Enhancements**

1. **Tariff Table**: Introduce a table to handle dynamic pricing based on usage bands.
2. **Alerts and Notifications**: Add email or SMS alerts for due bills and payment confirmations.
3. **Meter Readings**: Automate the capture of meter readings to calculate usage.
4. **User Interface**: Develop a web-based front-end to interact with the database.

This database design ensures scalability, flexibility, and efficient management of the electricity billing process. Let me know if you'd like further customizations or additional details!
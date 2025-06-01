CREATE TABLE IF NOT EXISTS departments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(255) NOT NULL,
  provider_id INT NOT NULL,

  FOREIGN KEY (provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  position enum('manager', 'supervisor', 'staff') NOT NULL,
  hire_date DATE NOT NULL,
  department_id INT NOT NULL,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE,
  FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS salaries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NOT NULL,
  total_salary DECIMAL(10, 2) NOT NULL CHECK (total_salary > 0),
  bonus DECIMAL(10, 2) NOT NULL CHECK (bonus >= 0),
  deduction DECIMAL(10, 2) NOT NULL CHECK (deduction >= 0),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  payment_id INT,

  FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE CASCADE,
  FOREIGN KEY (payment_id) REFERENCES payments (id)
);

CREATE TABLE IF NOT EXISTS attendance (
  id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NOT NULL,
  attendance_date DATE NOT NULL,
  check_in_time TIME,
  check_out_time TIME,

  FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE CASCADE
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('500 Corporate Drive', 'Business District', 'CORP-01');

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('Smart City Corporation', 'active', 32, 5); 

INSERT INTO departments (department_name, provider_id) VALUES
('Administration', 12),
('Information Technology', 12),
('Human Resources', 12),
('Engineering', 12),
('Marketing', 12);

INSERT INTO bank_customers (citizen_id, provider_id, credit_score) VALUES
(NULL, 12, 870); 

INSERT INTO accounts (bank_id, bank_customer_id, account_number, account_type, balance) VALUES
(1, 22, '1001-CORP-0001-0001', 'current', 1500000.00); 

INSERT INTO employees (citizen_id, position, hire_date, department_id) VALUES
(1, 'manager', '2020-06-15', 1),      -- Robert Johnson - Admin Manager
(2, 'staff', '2020-07-20', 1),        -- Jennifer Johnson - Admin Staff
(3, 'supervisor', '2020-08-10', 2),   -- Michael Williams - IT Supervisor
(4, 'staff', '2020-08-25', 2),        -- Sarah Williams - IT Staff
(5, 'manager', '2020-06-01', 3),      -- David Thompson - HR Manager
(7, 'supervisor', '2021-02-01', 4),   -- James Anderson - Engineering Supervisor
(8, 'staff', '2021-02-15', 4),        -- Christopher Wilson - Engineering Staff
(9, 'manager', '2021-01-10', 5),      -- Jessica Martinez - Marketing Manager
(10, 'staff', '2022-03-15', 5),       -- Daniel Taylor - Marketing Staff
(11, 'staff', '2022-02-01', 5);       -- Sophia Lee - Marketing Staff

INSERT INTO salaries (employee_id, total_salary, bonus, deduction, start_date, end_date) VALUES
(1, 12000.00, 1500.00, 300.00, '2023-03-01', '2023-03-31'),    -- Robert - Admin Manager
(3, 8500.00, 900.00, 220.00, '2023-03-01', '2023-03-31'),      -- Michael - IT Supervisor
(5, 11500.00, 1400.00, 280.00, '2023-03-01', '2023-03-31'),    -- David - HR Manager
(7, 8200.00, 850.00, 210.00, '2023-03-01', '2023-03-31'),      -- James - Engineering Supervisor
(9, 10800.00, 1250.00, 265.00, '2023-03-01', '2023-03-31');    -- Jessica - Marketing Manager

INSERT INTO attendance (employee_id, attendance_date, check_in_time, check_out_time) VALUES
(1, '2023-03-06', '08:52:32', '17:05:18'),
(2, '2023-03-06', '09:02:15', '17:32:40'),
(3, '2023-03-06', '08:45:10', '17:15:22'),
(4, '2023-03-06', '08:58:45', '17:10:55'),
(5, '2023-03-06', '08:30:20', '17:45:30'),
(6, '2023-03-06', '08:40:12', '17:55:48'),
(7, '2023-03-06', '08:50:35', '18:10:25'),
(8, '2023-03-06', '09:05:40', '17:30:15'),
(9, '2023-03-06', '08:35:50', '18:05:30'),
(10, '2023-03-06', '08:48:25', '17:15:40');

-- Robert's salary payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(23, 12000.00, 'debit', '2023-03-31 23:45:10');
UPDATE accounts SET balance = balance - 12000.00 WHERE id = 23;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(2, 12000.00, 'credit', '2023-03-31 23:45:10');
UPDATE accounts SET balance = balance + 12000.00 WHERE id = 2;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(12000.00, 29, 30, '2023-03-31 23:45:10');
UPDATE salaries SET payment_id = 15 WHERE id = 1;

-- Michael's salary payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(23, 8500.00, 'debit', '2023-03-31 23:47:20');
UPDATE accounts SET balance = balance - 8500.00 WHERE id = 23;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(6, 8500.00, 'credit', '2023-03-31 23:47:20');
UPDATE accounts SET balance = balance + 8500.00 WHERE id = 6;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(8500.00, 31, 32, '2023-03-31 23:47:20');
UPDATE salaries SET payment_id = 16 WHERE id = 2;

-- David's salary payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(23, 11500.00, 'debit', '2023-03-31 23:49:30');
UPDATE accounts SET balance = balance - 11500.00 WHERE id = 23;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(9, 11500.00, 'credit', '2023-03-31 23:49:30');
UPDATE accounts SET balance = balance + 11500.00 WHERE id = 9;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(11500.00, 33, 34, '2023-03-31 23:49:30');
UPDATE salaries SET payment_id = 17 WHERE id = 3;

-- James's salary payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(23, 8200.00, 'debit', '2023-03-31 23:51:40');
UPDATE accounts SET balance = balance - 8200.00 WHERE id = 23;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(13, 8200.00, 'credit', '2023-03-31 23:51:40');
UPDATE accounts SET balance = balance + 8200.00 WHERE id = 13;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(8200.00, 35, 36, '2023-03-31 23:51:40');
UPDATE salaries SET payment_id = 18 WHERE id = 4;

-- Jessica's salary payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(23, 10800.00, 'debit', '2023-03-31 23:53:50');
UPDATE accounts SET balance = balance - 10800.00 WHERE id = 23;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(15, 10800.00, 'credit', '2023-03-31 23:53:50');
UPDATE accounts SET balance = balance + 10800.00 WHERE id = 15;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(10800.00, 37, 38, '2023-03-31 23:53:50');
UPDATE salaries SET payment_id = 19 WHERE id = 5;

select * from employees e
JOIN salaries s ON s.employee_id = e.id;
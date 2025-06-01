CREATE TABLE IF NOT EXISTS banks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_provider_id INT NOT NULL,
  bank_name VARCHAR(255) NOT NULL,
  branch_code VARCHAR(50) NOT NULL,

  FOREIGN KEY (service_provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bank_customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT,
  provider_id INT,
  credit_score INT NOT NULL,
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id),
  FOREIGN KEY (provider_id) REFERENCES service_providers (id)
);

CREATE TABLE IF NOT EXISTS accounts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  bank_id INT NOT NULL,
  bank_customer_id INT NOT NULL,
  account_number VARCHAR(20) NOT NULL,
  account_type ENUM('savings', 'current', 'fd') NOT NULL,
  balance DECIMAL(10, 2) NOT NULL CHECK (balance > 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (bank_id) REFERENCES banks (id) ON DELETE CASCADE,
  FOREIGN KEY (bank_customer_id) REFERENCES bank_customers (id) ON DELETE CASCADE
);
  
CREATE TABLE IF NOT EXISTS transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT NOT NULL,
  amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
  transaction_type ENUM('credit', 'debit') NOT NULL,
  transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (account_id) REFERENCES accounts (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS loans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT,
  loan_amount DECIMAL(10, 2) NOT NULL CHECK (loan_amount > 0),
  interest_rate DECIMAL(5, 2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',

  FOREIGN KEY (account_id) REFERENCES accounts (id)
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('670 Banking Street', 'Financial District', 'FIN-01'),
('680 Investment Avenue', 'Financial District', 'FIN-01'),
('690 Commerce Plaza', 'Financial District', 'FIN-01'),
('700 Trust Boulevard', 'Financial District', 'FIN-01'),
('710 Finance Street', 'Financial District', 'FIN-01');

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('First National Bank', 'active', 21, 2),   
('City Credit Union', 'active', 22, 2),
('Wealth Management Bank', 'active', 23, 2),
('Commercial Trust Bank', 'active', 24, 2),
('Smart City Savings & Loan', 'active', 25, 2);

INSERT INTO banks (service_provider_id, bank_name, branch_code) VALUES
(1, 'First National Bank', 'FNB-001'),
(2, 'City Credit Union', 'CCU-001'),
(3, 'Wealth Management Bank', 'WMB-001'),
(4, 'Commercial Trust Bank', 'CTB-001'),
(5, 'Smart City Savings & Loan', 'SCSL-001');

INSERT INTO bank_customers (citizen_id, provider_id, credit_score) VALUES
(1, NULL, 750),  
(2, NULL, 745),  
(3, NULL, 680),  
(4, NULL, 710),  
(5, NULL, 800),  
(6, NULL, 790),  
(7, NULL, 720),  
(8, NULL, 650),  
(9, NULL, 700),  
(10, NULL, 715), 
(11, NULL, 820), 
(12, NULL, 760), 
(13, NULL, 690), 
(14, NULL, 780), 
(15, NULL, 775); 

SELECT * FROM bank_customers;

INSERT INTO accounts (bank_id, bank_customer_id, account_number, account_type, balance) VALUES
(1, 1, '1001-2345-6789-0001', 'savings', 15000.00),  
(1, 1, '1001-2345-6789-0002', 'current', 5000.00),   
(1, 2, '1001-2345-6789-0003', 'savings', 12500.00),  
(1, 11, '1001-2345-6789-0004', 'savings', 28000.00), 
(1, 12, '1001-2345-6789-0005', 'current', 9300.00),  
(2, 3, '2001-3456-7890-0001', 'current', 7800.00),   
(2, 4, '2001-3456-7890-0002', 'savings', 9200.00),   
(2, 13, '2001-3456-7890-0003', 'savings', 11500.00), 
(3, 5, '3001-4567-8901-0001', 'fd', 75000.00),       
(3, 6, '3001-4567-8901-0002', 'savings', 18500.00),  
(3, 14, '3001-4567-8901-0003', 'fd', 100000.00),     
(3, 15, '3001-4567-8901-0004', 'savings', 23000.00), 
(4, 7, '4001-5678-9012-0001', 'current', 12700.00),  
(4, 8, '4001-5678-9012-0002', 'savings', 6800.00),   
(5, 9, '5001-6789-0123-0001', 'savings', 8900.00),   
(5, 10, '5001-6789-0123-0002', 'current', 4500.00);  

SELECT * FROM accounts;

INSERT INTO loans (account_id, loan_amount, interest_rate, start_date, end_date, status) VALUES
(2, 250000.00, 5.25, '2022-06-15', '2047-06-15', 'approved'),  
(16, 15000.00, 8.75, '2023-03-15', '2026-03-15', 'approved'),   
(3, 18000.00, 8.50, '2023-04-18', '2026-04-18', 'pending');    

UPDATE accounts SET balance = balance + 250000.00 WHERE id = 2;
UPDATE accounts SET balance = balance + 15000.00 WHERE id = 16;

SELECT * FROM loans;
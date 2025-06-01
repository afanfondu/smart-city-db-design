CREATE TABLE IF NOT EXISTS transportation_customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vehicles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  vehicle_type ENUM('bus', 'car', 'bike') NOT NULL,
  registration_number VARCHAR(20) NOT NULL,
  model VARCHAR(50) NOT NULL,
  status ENUM('active', 'inactive') DEFAULT 'active',
  provider_id INT NOT NULL,

  FOREIGN KEY (provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS drivers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  driver_license VARCHAR(20) NOT NULL,
  driver_rating DECIMAL(2, 1),

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  journey_date DATE NOT NULL,
  start_location_id INT NOT NULL,
  end_location_id INT NOT NULL,
  payment_id INT,
  status ENUM('booked', 'cancelled', 'completed') DEFAULT 'booked',

  FOREIGN KEY (customer_id) REFERENCES transportation_customers (id) ON DELETE CASCADE,
  FOREIGN KEY (start_location_id) REFERENCES addresses (id),
  FOREIGN KEY (end_location_id) REFERENCES addresses (id),
  FOREIGN KEY (payment_id) REFERENCES payments (id)
);

CREATE TABLE IF NOT EXISTS rides (
  id INT AUTO_INCREMENT PRIMARY KEY,
  booking_id INT NOT NULL,
  vehicle_id INT NOT NULL,
  driver_id INT NOT NULL,
  start_time TIME,
  end_time TIME,
  distance DECIMAL(5, 2),
  customer_rating DECIMAL(2, 1),

  FOREIGN KEY (booking_id) REFERENCES bookings (id) ON DELETE CASCADE,
  FOREIGN KEY (vehicle_id) REFERENCES vehicles (id) ON DELETE CASCADE,
  FOREIGN KEY (driver_id) REFERENCES drivers (id) ON DELETE CASCADE
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('700 Rideshare Avenue', 'Tech Hub', 'TRANS-01');

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('Uber', 'active', 33, 7);

INSERT INTO bank_customers (citizen_id, provider_id, credit_score) VALUES
(NULL, 13, 865);

INSERT INTO accounts (bank_id, bank_customer_id, account_number, account_type, balance) VALUES
(1, 22, '1001-UBER-0001-0001', 'current', 750000.00); 

INSERT INTO transportation_customers (citizen_id) VALUES
(1),   
(2),   
(3),   
(4),   
(5),   
(6),   
(7),   
(8);   

INSERT INTO vehicles (vehicle_type, registration_number, model, status, provider_id) VALUES
('car', 'UBR-1234', 'Toyota Camry', 'active', 13),
('car', 'UBR-5678', 'Honda Accord', 'active', 13),
('car', 'UBR-9012', 'Tesla Model 3', 'active', 13),
('car', 'UBR-3456', 'Ford Fusion', 'active', 13),
('car', 'UBR-7890', 'Chevrolet Malibu', 'inactive', 13);

INSERT INTO drivers (citizen_id, driver_license, driver_rating) VALUES
(12, 'DL-12345678', 4.8),  
(13, 'DL-23456789', 4.7),  
(14, 'DL-34567890', 4.9),  
(15, 'DL-45678901', 4.6),  
(16, 'DL-56789012', 4.5);  

-- Robert's booking with payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(2, 25.75, 'debit', '2023-03-10 08:15:30');
UPDATE accounts SET balance = balance - 25.75 WHERE id = 2;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(24, 25.75, 'credit', '2023-03-10 08:15:30');
UPDATE accounts SET balance = balance + 25.75 WHERE id = 24;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(25.75, 39, 40, '2023-03-10 08:15:30');
INSERT INTO bookings (customer_id, booking_date, journey_date, start_location_id, end_location_id, payment_id, status) VALUES
(1, '2023-03-10 08:00:00', '2023-03-10', 1, 6, 20, 'completed'); 
INSERT INTO rides (booking_id, vehicle_id, driver_id, start_time, end_time, distance, customer_rating) VALUES
(1, 1, 1, '08:15:00', '08:42:00', 8.2, 4.8);  -- Robert's ride with first driver in Toyota Camry

-- Jennifer's booking with payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(3, 18.50, 'debit', '2023-03-12 17:30:45'); 
UPDATE accounts SET balance = balance - 18.50 WHERE id = 3;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(24, 18.50, 'credit', '2023-03-12 17:30:45');
UPDATE accounts SET balance = balance + 18.50 WHERE id = 24;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(18.50, 41, 42, '2023-03-12 17:30:45');
INSERT INTO bookings (customer_id, booking_date, journey_date, start_location_id, end_location_id, payment_id, status) VALUES
(2, '2023-03-12 17:15:00', '2023-03-12', 2, 11, 21, 'completed');  -- Jennifer: Pine Avenue to Meadow Lane
INSERT INTO rides (booking_id, vehicle_id, driver_id, start_time, end_time, distance, customer_rating) VALUES
(2, 2, 2, '17:30:00', '17:52:00', 5.7, 4.9);  -- Jennifer's ride with second driver in Honda Accord

-- Michael's booked ride with payment
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(6, 32.25, 'debit', '2023-03-15 12:45:20');  
UPDATE accounts SET balance = balance - 32.25 WHERE id = 6;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(24, 32.25, 'credit', '2023-03-15 12:45:20');
UPDATE accounts SET balance = balance + 32.25 WHERE id = 24;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(32.25, 43, 44, '2023-03-15 12:45:20');
INSERT INTO bookings (customer_id, booking_date, journey_date, start_location_id, end_location_id, payment_id, status) VALUES
(3, '2023-03-15 12:30:00', '2023-03-15', 7, 16, 22, 'booked');  -- Michael: Tower View Apt to Main Street
INSERT INTO rides (booking_id, vehicle_id, driver_id, start_time, end_time, distance, customer_rating) VALUES
(3, 3, 3, '12:45:00', NULL, 10.5, NULL);  -- Michael's booked ride with third driver in Tesla Model 3

INSERT INTO bookings (customer_id, booking_date, journey_date, start_location_id, end_location_id, status) VALUES
(4, '2023-03-18 09:45:00', '2023-03-18', 3, 12, 'cancelled'),  
(5, '2023-03-20 14:30:00', '2023-03-20', 8, 17, 'cancelled'),   
(6, '2023-03-22 19:00:00', '2023-03-22', 13, 18, 'cancelled');  

select * from bookings b
LEFT JOIN payments p ON p.id = b.payment_id;
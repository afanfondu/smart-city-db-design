CREATE TABLE IF NOT EXISTS healthcare_facilities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_provider_id INT NOT NULL,
  facility_name VARCHAR(255) NOT NULL,
  facility_type enum('hospital', 'clinic', 'pharmacy', 'diagnostic_center') NOT NULL,

  FOREIGN KEY (service_provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS patients (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  blood_group varchar(3),
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  specialization VARCHAR(100) NOT NULL,
  license_number VARCHAR(50) NOT NULL,
  healthcare_facility_id INT NOT NULL,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE,
  FOREIGN KEY (healthcare_facility_id) REFERENCES healthcare_facilities (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS appointments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATE NOT NULL,
  status enum('pending', 'paid', 'confirmed', 'treated', 'cancelled') NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
  payment_id INT,

  FOREIGN KEY (patient_id) REFERENCES patients (id) ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctors (id) ON DELETE CASCADE,
  FOREIGN KEY (payment_id) REFERENCES payments (id)
);

CREATE TABLE IF NOT EXISTS prescriptions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NOT NULL,
  medications VARCHAR(255) NOT NULL,
  dosage VARCHAR(255) NOT NULL,
  instructions TEXT,
  issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  valid_until DATE,

  FOREIGN KEY (appointment_id) REFERENCES appointments (id) ON DELETE CASCADE
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('202 Hospital Road', 'Central District', 'MED-01'),
('220 Wellness Boulevard', 'East District', 'MED-02'),
('260 Therapy Lane', 'West District', 'MED-03');

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('Smart City General Hospital', 'active', 29, 1), 
('Community Health Clinic', 'active', 30, 1),
('Wellness Therapy Center', 'active', 31, 1);

INSERT INTO healthcare_facilities (service_provider_id, facility_name, facility_type) VALUES
(9, 'Smart City General Hospital', 'hospital'),
(10, 'Community Health Clinic', 'clinic'),
(11, 'Wellness Therapy Center', 'clinic');

INSERT INTO bank_customers (citizen_id, provider_id, credit_score) VALUES
(NULL, 9, 840),  
(NULL, 10, 805),  
(NULL, 11, 790);  

INSERT INTO accounts (bank_id, bank_customer_id, account_number, account_type, balance) VALUES
(1, 19, '1001-HOSP-0001-0001', 'current', 850000.00),  
(2, 20, '2001-CLIN-0001-0001', 'current', 350000.00),  
(3, 21, '3001-THER-0001-0001', 'current', 180000.00);  

INSERT INTO doctors (citizen_id, specialization, license_number, healthcare_facility_id) VALUES
(5, 'Cardiology', 'DOC-2023-1001', 1),      
(7, 'General Surgery', 'DOC-2023-1002', 1), 
(14, 'Family Medicine', 'DOC-2023-1003', 2),
(16, 'Pediatrics', 'DOC-2023-1004', 2),     
(8, 'Physical Therapy', 'DOC-2023-1005', 3),
(19, 'Orthopedics', 'DOC-2023-1006', 3);    

INSERT INTO patients (citizen_id, blood_group) VALUES
(1, 'O+'),   
(2, 'A-'),   
(3, 'B+'),   
(4, 'AB+'),  
(9, 'A+'),   
(10, 'O-'),  
(11, 'B-'),  
(12, 'O+'),  
(13, 'A+'),  
(15, 'AB-'), 
(17, 'A-'),  
(18, 'B+'),  
(20, 'O+');  

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, total_amount) VALUES
(1, 1, '2023-02-05', 'treated', 250.00),      -- Robert with Dr. Thompson (Cardiology)
(2, 2, '2023-02-10', 'treated', 500.00),      -- Jennifer with Dr. Anderson (Surgery)
(3, 3, '2023-02-15', 'confirmed', 150.00),    -- Michael with Dr. Miller (Family Medicine)
(4, 4, '2023-02-20', 'confirmed', 175.00),    -- Sarah with Dr. Davis (Pediatrics)
(5, 5, '2023-03-01', 'treated', 120.00),      -- Jessica with Dr. Wilson (Physical Therapy)
(6, 6, '2023-03-05', 'paid', 225.00),         -- Daniel with Dr. Kim (Orthopedics)
(7, 1, '2023-03-10', 'paid', 250.00),         -- Sophia with Dr. Thompson (Cardiology)
(8, 3, '2023-03-15', 'confirmed', 150.00),    -- Matthew with Dr. Miller (Family Medicine)
(9, 5, '2023-03-20', 'pending', 120.00),      -- Olivia with Dr. Wilson (Physical Therapy)
(10, 6, '2023-03-25', 'pending', 225.00),     -- Elizabeth with Dr. Kim (Orthopedics)
(11, 2, '2023-04-01', 'pending', 500.00),     -- Patricia with Dr. Anderson (Surgery)
(12, 4, '2023-04-05', 'cancelled', 175.00),   -- Emma with Dr. Davis (Pediatrics)
(13, 1, '2023-04-10', 'pending', 250.00);     -- Natalie with Dr. Thompson (Cardiology)

INSERT INTO prescriptions (appointment_id, medications, dosage, instructions, valid_until) VALUES
(1, 'Atorvastatin', '20mg', 'Take once daily with evening meal', '2023-05-05'),
(2, 'Amoxicillin', '500mg', 'Take three times daily for 7 days', '2023-02-17'),
(5, 'Ibuprofen, Physical Therapy Exercises', '400mg', 'Take as needed for pain, not exceeding 3 times daily. Complete exercise routine daily.', '2023-04-01');

-- Transaction for Appointment 1 (Robert Johnson - Dr. Thompson - Cardiology) - Treated
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(2, 250.00, 'debit', '2023-02-05 10:30:00');
UPDATE accounts SET balance = balance - 250.00 WHERE id = 2;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(20, 250.00, 'credit', '2023-02-05 10:30:00'); 
UPDATE accounts SET balance = balance + 250.00 WHERE id = 20;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(250.00, 13, 14, '2023-02-05 10:30:00');
UPDATE appointments SET payment_id = 7 WHERE id = 1;

-- Transaction for Appointment 2 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(3, 500.00, 'debit', '2023-02-10 14:15:00');
UPDATE accounts SET balance = balance - 500.00 WHERE id = 3;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(20, 500.00, 'credit', '2023-02-10 14:15:00'); 
UPDATE accounts SET balance = balance + 500.00 WHERE id = 20;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(500.00, 15, 16, '2023-02-10 14:15:00');
UPDATE appointments SET payment_id = 8 WHERE id = 2;

-- Transaction for Appointment 3
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(6, 150.00, 'debit', '2023-02-15 09:45:00');
UPDATE accounts SET balance = balance - 150.00 WHERE id = 6;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(21, 150.00, 'credit', '2023-02-15 09:45:00'); 
UPDATE accounts SET balance = balance + 150.00 WHERE id = 21;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(150.00, 17, 18, '2023-02-15 09:45:00');
UPDATE appointments SET payment_id = 9 WHERE id = 3;

-- Transaction for Appointment 4 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(7, 175.00, 'debit', '2023-02-20 11:30:00');
UPDATE accounts SET balance = balance - 175.00 WHERE id = 7;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(21, 175.00, 'credit', '2023-02-20 11:30:00'); 
UPDATE accounts SET balance = balance + 175.00 WHERE id = 21;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(175.00, 19, 20, '2023-02-20 11:30:00');
UPDATE appointments SET payment_id = 10 WHERE id = 4;

-- Transaction for Appointment 5 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(15, 120.00, 'debit', '2023-03-01 15:00:00');
UPDATE accounts SET balance = balance - 120.00 WHERE id = 15;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(22, 120.00, 'credit', '2023-03-01 15:00:00'); 
UPDATE accounts SET balance = balance + 120.00 WHERE id = 22;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(120.00, 21, 22, '2023-03-01 15:00:00');
UPDATE appointments SET payment_id = 11 WHERE id = 5;

-- Transaction for Appointment 6
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(16, 225.00, 'debit', '2023-03-05 10:15:00');
UPDATE accounts SET balance = balance - 225.00 WHERE id = 16;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(22, 225.00, 'credit', '2023-03-05 10:15:00'); 
UPDATE accounts SET balance = balance + 225.00 WHERE id = 22;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(225.00, 23, 24, '2023-03-05 10:15:00');
UPDATE appointments SET payment_id = 12 WHERE id = 6;

-- Transaction for Appointment 7 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(4, 250.00, 'debit', '2023-03-10 13:20:00');
UPDATE accounts SET balance = balance - 250.00 WHERE id = 4;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(20, 250.00, 'credit', '2023-03-10 13:20:00'); 
UPDATE accounts SET balance = balance + 250.00 WHERE id = 20;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(250.00, 25, 26, '2023-03-10 13:20:00');
UPDATE appointments SET payment_id = 13 WHERE id = 7;

-- Transaction for Appointment 8 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(5, 150.00, 'debit', '2023-03-15 16:10:00');
UPDATE accounts SET balance = balance - 150.00 WHERE id = 5;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(21, 150.00, 'credit', '2023-03-15 16:10:00'); 
UPDATE accounts SET balance = balance + 150.00 WHERE id = 21;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(150.00, 27, 28, '2023-03-15 16:10:00');
UPDATE appointments SET payment_id = 14 WHERE id = 8;

SELECT * FROM appointments a
LEFT JOIN payments p ON p.id = a.payment_id;
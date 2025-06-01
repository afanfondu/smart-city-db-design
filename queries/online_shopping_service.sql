CREATE TABLE IF NOT EXISTS online_shopping_customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  citizen_id INT NOT NULL,
  membership_type ENUM('silver', 'gold', 'platinum') NOT NULL,
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
  image_url VARCHAR(255),
  stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
  provider_id INT NOT NULL,

  FOREIGN KEY (provider_id) REFERENCES service_providers (id)
);

CREATE TABLE IF NOT EXISTS orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount > 0),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('pending', 'paid', 'delivered', 'cancelled') DEFAULT 'pending',
  customer_id INT NOT NULL,
  payment_id INT,

  FOREIGN KEY (customer_id) REFERENCES online_shopping_customers (id) ON DELETE CASCADE,
  FOREIGN KEY (payment_id) REFERENCES payments (id)
);

CREATE TABLE IF NOT EXISTS order_items (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT,
  quantity INT DEFAULT 1 CHECK (quantity >= 1),
  total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount > 0),

  FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products (id)
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('410 Retail Road', 'Smart City Mall', 'SHOP-01'),
('450 Technology Way', 'Electronics District', 'SHOP-02'),
('440 Fashion Boulevard', 'Fashion District', 'SHOP-03');

SELECT * FROM addresses;

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('SmartBuy Marketplace', 'active', 26, 4),
('TechGadgets Direct', 'active', 27, 4),
('Fashion Forward', 'active', 28, 4);

SELECT * FROM service_providers;

INSERT INTO online_shopping_customers (citizen_id, membership_type) VALUES
(1, 'gold'),      
(2, 'silver'),    
(5, 'platinum'),  
(6, 'gold'),      
(9, 'silver'),    
(11, 'platinum'), 
(12, 'silver'),   
(14, 'gold'),     
(18, 'silver'),   
(19, 'gold');     

INSERT INTO online_shopping_customers (citizen_id, membership_type) VALUES
(3, 'silver'),  
(4, 'gold'),    
(7, 'silver'),  
(8, 'platinum'),
(10, 'gold');   


SELECT * FROM online_shopping_customers;

INSERT INTO products (title, description, price, image_url, stock_quantity, provider_id) VALUES
('Smart Home Hub', 'Central control for all your smart home devices', 129.99, 'smarthub.jpg', 50, 6),
('Wireless Earbuds', 'Premium sound quality with noise cancellation', 89.99, 'earbuds.jpg', 75, 6),
('Fitness Tracker', 'Track steps, heart rate, and sleep patterns', 59.99, 'fitnesstracker.jpg', 100, 6),
('Kitchen Blender', 'High-power blender for smoothies and soups', 79.99, 'blender.jpg', 30, 6),
('Smart Scale', 'Track weight, BMI and body composition', 49.99, 'smartscale.jpg', 45, 6);

INSERT INTO products (title, description, price, image_url, stock_quantity, provider_id) VALUES
('Gaming Laptop', '15" high-performance gaming laptop with RGB keyboard', 1299.99, 'gaminglaptop.jpg', 15, 7),
('4K Smart TV', '55" Ultra HD Smart TV with voice control', 699.99, 'smarttv.jpg', 20, 7),
('Wireless Charger', 'Fast wireless charging pad for smartphones', 29.99, 'wirelesscharger.jpg', 60, 7),
('Bluetooth Speaker', 'Waterproof portable speaker with 20hr battery life', 79.99, 'speaker.jpg', 40, 7),
('Digital Camera', 'Mirrorless camera with 24MP sensor', 599.99, 'camera.jpg', 25, 7);

INSERT INTO products (title, description, price, image_url, stock_quantity, provider_id) VALUES
('Men\'s Casual Shirt', 'Cotton button-down shirt in various colors', 39.99, 'mensshirt.jpg', 80, 8),
('Women\'s Summer Dress', 'Floral print dress perfect for summer', 59.99, 'summerdress.jpg', 65, 8),
('Leather Wallet', 'Genuine leather wallet with RFID protection', 49.99, 'wallet.jpg', 50, 8),
('Designer Sunglasses', 'UV protection polarized sunglasses', 89.99, 'sunglasses.jpg', 35, 8),
('Athletic Shoes', 'Comfortable running shoes with cushioned soles', 79.99, 'shoes.jpg', 70, 8);

SELECT * FROM products;

INSERT INTO bank_customers (citizen_id, provider_id, credit_score) VALUES
(NULL, 6, 795),  
(NULL, 7, 820),  
(NULL, 8, 775);  
SELECT * FROM bank_customers;

INSERT INTO accounts (bank_id, bank_customer_id, account_number, account_type, balance) VALUES
(1, 16, '1001-BUSI-0001-0001', 'current', 500000.00),
(3, 17, '3001-BUSI-0002-0001', 'current', 750000.00),
(2, 18, '2001-BUSI-0003-0001', 'current', 320000.00);

SELECT * FROM accounts;

INSERT INTO loans (account_id, loan_amount, interest_rate, start_date, end_date, status) VALUES
(18, 500000.00, 6.25, '2023-01-15', '2028-01-15', 'approved');
UPDATE accounts SET balance = balance + 500000.00 WHERE id = 18;

-- creating orders for customers, which will also include the payment details
-- with debit and credit transactions
INSERT INTO orders (total_amount, order_date, status, customer_id) VALUES
(219.98, '2023-02-10 13:45:22', 'delivered', 1),  
(699.99, '2023-02-15 09:30:15', 'delivered', 3),  
(89.99, '2023-02-20 16:20:45', 'delivered', 5),   
(1299.99, '2023-03-05 11:15:30', 'paid', 6),      
(169.98, '2023-03-10 14:40:25', 'paid', 8),       
(139.98, '2023-03-15 10:25:18', 'paid', 2),       
(599.99, '2023-03-20 15:50:40', 'pending', 9),    
(129.98, '2023-03-25 12:35:55', 'pending', 4),    
(79.99, '2023-04-01 09:15:33', 'pending', 7),     
(219.97, '2023-04-05 16:45:10', 'cancelled', 10); 

INSERT INTO order_items (order_id, product_id, quantity, total_amount) VALUES
-- Order 1: Robert Johnson (Smart Home Hub + Wireless Earbuds)
(1, 1, 1, 129.99),  -- Smart Home Hub
(1, 2, 1, 89.99),   -- Wireless Earbuds
-- Order 2: David Thompson (4K Smart TV)
(2, 7, 1, 699.99),  -- 4K Smart TV
-- Order 3: Jessica Martinez (Designer Sunglasses)
(3, 14, 1, 89.99),  -- Designer Sunglasses
-- Order 4: Sophia Lee (Gaming Laptop)
(4, 6, 1, 1299.99), -- Gaming Laptop
-- Order 5: William Miller (Kitchen Blender + Smart Scale)
(5, 4, 1, 79.99),   -- Kitchen Blender
(5, 5, 1, 89.99),   -- Smart Scale
-- Order 6: Jennifer Johnson (Fitness Tracker + Wireless Charger)
(6, 3, 1, 59.99),   -- Fitness Tracker
(6, 8, 1, 79.99),   -- Wireless Charger
-- Order 7: Emma Rodriguez (Digital Camera)
(7, 10, 1, 599.99), -- Digital Camera
-- Order 8: Emily Thompson (Men's Casual Shirt + Leather Wallet)
(8, 11, 1, 39.99),  -- Men's Casual Shirt
(8, 13, 1, 89.99),  -- Leather Wallet
-- Order 9: Matthew Brown (Bluetooth Speaker)
(9, 9, 1, 79.99),   -- Bluetooth Speaker
-- Order 10: Andrew Kim (Men's Shirt + Wallet + Athletic Shoes - cancelled)
(10, 11, 1, 39.99), -- Men's Casual Shirt 
(10, 13, 1, 99.99), -- Leather Wallet
(10, 15, 1, 79.99); -- Athletic Shoes

-- Transaction for Order 1
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(2, 219.98, 'debit', '2023-02-10 13:47:30');
UPDATE accounts SET balance = balance - 219.98 WHERE id = 2;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(17, 219.98, 'credit', '2023-02-10 13:47:30'); 
UPDATE accounts SET balance = balance + 219.98 WHERE id = 17;
-- Create payment records linking debit and credit transactions
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(219.98, 1, 2, '2023-02-10 13:47:30');
UPDATE orders SET payment_id = 1 WHERE id = 1;

-- Transaction for Order 2 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(9, 699.99, 'debit', '2023-02-15 09:32:45');
UPDATE accounts SET balance = balance - 699.99 WHERE id = 9;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(18, 699.99, 'credit', '2023-02-15 09:32:45');
UPDATE accounts SET balance = balance + 699.99 WHERE id = 18;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(699.99, 3, 4, '2023-02-15 09:32:45');
UPDATE orders SET payment_id = 2 WHERE id = 2;

-- Transaction for Order 3 
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(15, 89.99, 'debit', '2023-02-20 16:22:15');
UPDATE accounts SET balance = balance - 89.99 WHERE id = 15;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(19, 89.99, 'credit', '2023-02-20 16:22:15'); 
UPDATE accounts SET balance = balance + 89.99 WHERE id = 19;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(89.99, 5, 6, '2023-02-20 16:22:15');
UPDATE orders SET payment_id = 3 WHERE id = 3;

-- Transaction for Order 4
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(4, 1299.99, 'debit', '2023-03-05 11:18:10');
UPDATE accounts SET balance = balance - 1299.99 WHERE id = 4;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(18, 1299.99, 'credit', '2023-03-05 11:18:10');
UPDATE accounts SET balance = balance + 1299.99 WHERE id = 18;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(1299.99, 7, 8, '2023-03-05 11:18:10');
UPDATE orders SET payment_id = 4 WHERE id = 4;

-- Transaction for Order 5
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(11, 169.98, 'debit', '2023-03-10 14:42:50');
UPDATE accounts SET balance = balance - 169.98 WHERE id = 11;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(17, 169.98, 'credit', '2023-03-10 14:42:50');
UPDATE accounts SET balance = balance + 169.98 WHERE id = 17;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(169.98, 9, 10, '2023-03-10 14:42:50');
UPDATE orders SET payment_id = 5 WHERE id = 5;

-- Transaction for Order 6
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(3, 139.98, 'debit', '2023-03-15 10:28:22');
UPDATE accounts SET balance = balance - 139.98 WHERE id = 3;
INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES
(17, 139.98, 'credit', '2023-03-15 10:28:22');  -- Order 6
UPDATE accounts SET balance = balance + 139.98 WHERE id = 17;
INSERT INTO payments (amount, debit_transaction_id, credit_transaction_id, payment_date) VALUES
(139.98, 11, 12, '2023-03-15 10:28:22');
UPDATE orders SET payment_id = 6 WHERE id = 6;

select * from orders o
LEFT JOIN payments p ON o.payment_id = p.id;
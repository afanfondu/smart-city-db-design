CREATE TABLE IF NOT EXISTS payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  amount DECIMAL(10, 2) NOT NULL,
  debit_transaction_id INT NOT NULL,
  credit_transaction_id INT NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (debit_transaction_id) REFERENCES transactions (id),
  FOREIGN KEY (credit_transaction_id) REFERENCES transactions (id)
);

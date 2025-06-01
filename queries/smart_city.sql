CREATE DATABASE IF NOT EXISTS smart_city;

USE smart_city;

CREATE TABLE IF NOT EXISTS citizens (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  gender ENUM('male', 'female') NOT NULL,
  date_of_birth DATE NOT NULL,
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  address_id INT,

  FOREIGN KEY (address_id) REFERENCES addresses (id)
);

CREATE TABLE IF NOT EXISTS services (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_name VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS service_providers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  provider_name VARCHAR(255) NOT NULL,
  status ENUM('active', 'inactive') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  address_id INT,
  service_id INT NOT NULL,

  FOREIGN KEY (address_id) REFERENCES addresses (id),
  FOREIGN KEY (service_id) REFERENCES services (id) ON DELETE CASCADE
);

SELECT * FROM citizens c
JOIN addresses a ON c.address_id = a.id;

INSERT INTO citizens (first_name, last_name, email, gender, date_of_birth, address_id) VALUES
('Robert', 'Johnson', 'robert.johnson@email.com', 'male', '1978-05-12', 1),
('Jennifer', 'Johnson', 'jennifer.johnson@email.com', 'female', '1980-09-23', 1),
('Michael', 'Williams', 'michael.williams@email.com', 'male', '1975-11-30', 2),
('Sarah', 'Williams', 'sarah.williams@email.com', 'female', '1977-04-18', 2),
('David', 'Thompson', 'david.thompson@email.com', 'male', '1982-07-07', 3),
('Emily', 'Thompson', 'emily.thompson@email.com', 'female', '1984-03-15', 3),
('James', 'Anderson', 'james.anderson@email.com', 'male', '1970-01-25', 4),
('Christopher', 'Wilson', 'christopher.wilson@email.com', 'male', '1968-12-05', 5),
('Jessica', 'Martinez', 'jessica.martinez@email.com', 'female', '1992-08-17', 6),
('Daniel', 'Taylor', 'daniel.taylor@email.com', 'male', '1990-06-28', 7),
('Sophia', 'Lee', 'sophia.lee@email.com', 'female', '1995-02-09', 8),
('Matthew', 'Brown', 'matthew.brown@email.com', 'male', '1993-11-14', 9),
('Olivia', 'Garcia', 'olivia.garcia@email.com', 'female', '1991-04-03', 10),
('William', 'Miller', 'william.miller@email.com', 'male', '1965-10-20', 11),
('Elizabeth', 'Miller', 'elizabeth.miller@email.com', 'female', '1967-07-11', 11),
('Richard', 'Davis', 'richard.davis@email.com', 'male', '1955-05-30', 12),
('Patricia', 'Davis', 'patricia.davis@email.com', 'female', '1958-09-04', 12),
('Emma', 'Rodriguez', 'emma.rodriguez@email.com', 'female', '1988-12-22', 16),
('Andrew', 'Kim', 'andrew.kim@email.com', 'male', '1986-03-17', 17),
('Natalie', 'Singh', 'natalie.singh@email.com', 'female', '1989-01-08', 18);

SELECT * FROM services;

INSERT INTO services (service_name, description) VALUES
('Healthcare', 'Medical facilities and services including hospitals, clinics, and emergency care'),
('Banking', 'Financial institutions offering personal and business banking services'),
('Payment', 'Digital and traditional payment processing solutions'),
('Online Shopping', 'E-commerce platforms and delivery services for retail products'),
('HR Management', 'Human resources services for workforce management and recruitment'),
('Location', 'Geographic information services and mapping solutions'),
('Transportation', 'Public and private transportation networks and ride services'),
('Social Media', 'Digital platforms for social networking and community engagement'),
('Music Streaming', 'On-demand music services with extensive digital libraries'),
('Education', 'Learning institutions from primary education to higher learning and professional development');
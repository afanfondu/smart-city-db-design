CREATE TABLE IF NOT EXISTS addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(255) NOT NULL,
  landmark VARCHAR(100) NOT NULL,
  zone_code VARCHAR(20) NOT NULL
);

SELECT * FROM addresses;

INSERT INTO addresses (street, landmark, zone_code) VALUES
('25 Oak Street', 'Maple Grove Neighborhood', 'RES-A'),
('42 Pine Avenue', 'Maple Grove Neighborhood', 'RES-A'),
('78 Cedar Lane', 'Maple Grove Neighborhood', 'RES-A'),
('103 Birch Road', 'Maple Grove Neighborhood', 'RES-A'),
('156 Willow Drive', 'Maple Grove Neighborhood', 'RES-A'),
('1120 Tower View Apt 301', 'Skyline Apartment Complex', 'RES-B'),
('1120 Tower View Apt 507', 'Skyline Apartment Complex', 'RES-B'),
('1242 Parkside Apt 15B', 'Central Park Residences', 'RES-B'),
('1242 Parkside Apt 22C', 'Central Park Residences', 'RES-B'),
('850 Riverside Apt 112', 'Waterfront Apartments', 'RES-B'),
('28 Meadow Lane', 'Green Valley Suburb', 'RES-C'),
('45 Sunset Drive', 'Green Valley Suburb', 'RES-C'),
('72 Spring Street', 'Green Valley Suburb', 'RES-C'),
('96 Summer Avenue', 'Green Valley Suburb', 'RES-C'),
('125 Autumn Road', 'Green Valley Suburb', 'RES-C'),
('501 Main Street Apt 3D', 'City Center Lofts', 'RES-D'),
('720 Urban Plaza Unit 12', 'Downtown Living Complex', 'RES-D'),
('835 Metropolitan Ave #507', 'Urban Heights Condos', 'RES-D'),
('921 City View Penthouse B', 'Skyline Towers', 'RES-D'),
('1050 Central Avenue Unit 32', 'Downtown Residences', 'RES-D');
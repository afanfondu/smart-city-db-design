CREATE TABLE IF NOT EXISTS students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  
  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS instructors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  qualification VARCHAR(100) NOT NULL,
  
  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS institutions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_provider_id INT NOT NULL,
  instituition_name VARCHAR(255) NOT NULL,
  instituition_type ENUM('university', 'training_center', 'online_platform') NOT NULL,

  FOREIGN KEY (service_provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS courses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(255) NOT NULL,
  description TEXT,
  duration INT NOT NULL, -- hours
  credits INT NOT NULL,
  instructor_id INT NOT NULL,
  institution_id INT NOT NULL,
  
  FOREIGN KEY (instructor_id) REFERENCES instructors (id) ON DELETE CASCADE,
  FOREIGN KEY (institution_id) REFERENCES institutions (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS enrollments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('enrolled', 'completed', 'dropped') NOT NULL,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  
  FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exams (
  id INT AUTO_INCREMENT PRIMARY KEY,
  enrollment_id INT NOT NULL,
  exam_date TIMESTAMP NOT NULL,
  duration INT NOT NULL, -- minutes
  grade VARCHAR(2),

  FOREIGN KEY (enrollment_id) REFERENCES enrollments (id) ON DELETE CASCADE
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('123 University Avenue', 'Academic District', 'EDU-01'),
('456 Learning Lane', 'Knowledge Park', 'EDU-02'),       
('789 Digital Drive', 'Innovation Hub', 'EDU-03');       

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('Smart City University', 'active', 39, 10),        
('Professional Skills Institute', 'active', 40, 10),
('Digital Learning Platform', 'active', 41, 10);    

INSERT INTO institutions (service_provider_id, instituition_name, instituition_type) VALUES
(19, 'College of Engineering', 'university'), 
(20, 'IT Training Center', 'training_center'),
(21, 'Coding Bootcamp', 'online_platform');   

INSERT INTO instructors (citizen_id, qualification) VALUES
(5, 'PhD in Computer Science'),   
(9, 'MBA, Marketing Specialist'), 
(13, 'MFA, Visual Arts Educator'),
(14, 'MSc in Data Science'),      
(16, 'PhD in Literature');        

INSERT INTO students (citizen_id) VALUES
(2), 
(3), 
(4), 
(6), 
(7), 
(8), 
(10),
(11);

INSERT INTO courses (course_name, description, duration, credits, instructor_id, institution_id) VALUES
-- College of Engineering courses (University)
('Introduction to Programming', 'Fundamentals of programming using Python and Java', 45, 3, 1, 1),
('Database Systems', 'Design and implementation of database systems', 40, 3, 4, 1),
('Machine Learning Fundamentals', 'Introduction to machine learning algorithms and applications', 50, 4, 1, 1),
('Computer Networks', 'Principles of computer networking and communications', 45, 3, 1, 1),
-- IT Training Center courses (Training Center)
('Web Development Bootcamp', 'Comprehensive course on modern web development', 60, 5, 4, 2),
('Cybersecurity Essentials', 'Fundamentals of information security', 48, 4, 1, 2),
('Project Management', 'Methodologies and tools for effective project management', 35, 3, 2, 2),
('Business Analytics', 'Using data analytics for business decision making', 42, 3, 2, 2),
-- Coding Bootcamp courses (Online Platform)
('Full Stack Development', 'End-to-end web application development', 80, 6, 4, 3),
('Mobile App Development', 'Creating applications for iOS and Android', 70, 5, 1, 3),
('UX/UI Design', 'Designing user experiences for digital products', 60, 4, 3, 3),
('Data Science Fundamentals', 'Introduction to data analysis and visualization', 75, 5, 4, 3);

INSERT INTO enrollments (enrollment_date, status, student_id, course_id) VALUES
-- Jennifer's enrollments (University)
('2023-01-10 09:30:00', 'enrolled', 1, 1),     -- Intro to Programming
('2023-01-15 14:20:00', 'enrolled', 1, 2),     -- Database Systems
-- Michael's enrollments (Mixed)
('2023-01-12 10:15:00', 'enrolled', 2, 3),     -- Machine Learning (University)
('2023-01-20 11:45:00', 'enrolled', 2, 5),     -- Web Development (Training Center)
-- Sarah's enrollments (Training Center)
('2023-01-18 13:30:00', 'completed', 3, 7),    -- Project Management
('2023-02-05 09:15:00', 'enrolled', 3, 8),     -- Business Analytics
-- Emily's enrollments (University)
('2023-01-25 16:45:00', 'enrolled', 4, 4),     -- Computer Networks
('2023-02-10 14:30:00', 'dropped', 4, 1),      -- Intro to Programming
-- James's enrollments (Online Platform)
('2023-01-30 11:20:00', 'enrolled', 5, 9),     -- Full Stack Development
('2023-02-15 13:10:00', 'enrolled', 5, 10),    -- Mobile App Development
-- Christopher's enrollments (Training Center)
('2023-02-01 10:30:00', 'completed', 6, 6),    -- Cybersecurity Essentials
-- Daniel's enrollments (Mixed)
('2023-02-08 09:45:00', 'enrolled', 7, 3),     -- Machine Learning (University)
('2023-02-12 15:20:00', 'dropped', 7, 7),      -- Project Management (Training Center)
-- Sophia's enrollments (Online Platform)
('2023-02-18 11:15:00', 'enrolled', 8, 11),    -- UX/UI Design
('2023-02-22 14:40:00', 'enrolled', 8, 12);    -- Data Science Fundamentals

INSERT INTO exams (enrollment_id, exam_date, duration, grade) VALUES
-- Jennifer's exams
(1, '2023-02-15 10:00:00', 120, 'A-'),        -- Intro to Programming midterm
(2, '2023-02-20 14:00:00', 90, 'B+'),         -- Database Systems midterm
-- Michael's exams
(3, '2023-02-17 09:30:00', 120, 'A'),         -- Machine Learning midterm
(4, '2023-02-25 13:00:00', 150, 'A+'),        -- Web Development midterm
-- Sarah's completed course exam
(5, '2023-02-10 11:00:00', 90, 'A'),          -- Project Management midterm
(5, '2023-03-01 11:00:00', 120, 'A-'),        -- Project Management final
(6, '2023-03-05 10:30:00', 90, 'B+'),         -- Business Analytics midterm
-- Emily's exams
(7, '2023-02-28 15:00:00', 90, 'B'),          -- Computer Networks midterm
(8, '2023-02-05 14:00:00', 90, 'C+'),         -- Intro to Programming midterm (before dropping)
-- James's exams
(9, '2023-03-05 09:00:00', 180, 'A-'),        -- Full Stack Development midterm
(10, '2023-03-10 13:30:00', 150, 'B+'),       -- Mobile App Development midterm
-- Christopher's completed course exams
(11, '2023-02-20 10:00:00', 120, 'A'),        -- Cybersecurity midterm
(11, '2023-03-15 10:00:00', 150, 'A'),        -- Cybersecurity final
-- Daniel's exams
(12, '2023-03-08 14:00:00', 90, 'B'),         -- Machine Learning midterm
(13, '2023-03-01 13:00:00', 90, 'C'),         -- Project Management midterm (before dropping)
-- Sophia's exams
(14, '2023-03-15 10:30:00', 120, 'A-'),       -- UX/UI Design midterm
(15, '2023-03-20 14:30:00', 150, 'B+');       -- Data Science Fundamentals midterm

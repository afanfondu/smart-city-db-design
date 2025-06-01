-- 1) simple queries

-- 1. Retrieve all customers who have placed at least one order.
SELECT c.first_name, c.last_name FROM online_shopping_customers osc
JOIN citizens c ON c.id = osc.citizen_id
JOIN orders o ON o.customer_id = osc.id;

-- 2. Find students enrolled in a specific course.
SELECT c.first_name, c.last_name, cs.course_name FROM students s
JOIN citizens c ON c.id = s.citizen_id
JOIN enrollments e ON e.student_id = s.id
JOIN courses cs ON cs.id = e.course_id
WHERE cs.course_name LIKE 'Machine Learning%';

-- 3. Get all employees working in the IT department.
SELECT c.first_name, c.last_name, d.department_name FROM employees e
JOIN citizens c ON c.id = e.citizen_id
JOIN departments d ON d.id = e.department_id
WHERE d.department_name = 'Information Technology';

-- 2) Aggregate Functions

-- 4. Find total revenue generated from all orders.
SELECT SUM(total_amount) AS total_revenue FROM orders
WHERE status = 'paid' OR status = 'delivered';

-- 5. Calculate average salary per department.
SELECT d.id, d.department_name, AVG(s.total_salary) as average_salary FROM employees e
JOIN departments d ON d.id = e.department_id
JOIN salaries s ON s.employee_id = e.id
GROUP BY d.id;

-- 6. Retrieve top 3 highest-paid employees.
SELECT CONCAT_WS(' ', c.first_name, c.last_name) as employee_name, s.total_salary FROM employees e
JOIN citizens c ON c.id = e.citizen_id
JOIN salaries s ON s.employee_id = e.id
ORDER BY s.total_salary DESC
LIMIT 3;

-- 3) Joins
-- 7. Get customer names along with their order details using INNER JOIN.
SELECT c.first_name, c.last_name, o.id as order_id, o.order_date, o.status, o.total_amount 
FROM online_shopping_customers osc
INNER JOIN citizens c ON c.id = osc.citizen_id
INNER JOIN orders o ON o.customer_id = osc.id;

-- 8. Retrieve doctors and their patients using LEFT JOIN.
SELECT 
  CONCAT_WS(' ', cd.first_name, cd.last_name) as doctor, 
  CONCAT_WS(' ', cp.first_name, cp.last_name) as patient
FROM patients p
JOIN citizens cp ON cp.id = p.citizen_id
JOIN appointments a ON a.patient_id = p.id
JOIN doctors d ON d.id = a.doctor_id
JOIN citizens cd ON cd.id = d.citizen_id;

-- 9. List songs and users who have added them to playlists using RIGHT JOIN
SELECT 
  s.title as song_name,
  s.artist_name,
  CONCAT_WS(' ', c.first_name, c.last_name) as user_name,
  p.playlist_name
FROM music_service_users msu
JOIN citizens c ON c.id = msu.citizen_id
JOIN playlists p ON p.user_id = msu.id
JOIN playlist_songs ps ON ps.playlist_id = p.id
RIGHT JOIN songs s ON s.id = ps.song_id;

-- 4) Subqueries
-- 10. Find employees earning more than the company average salary.
SELECT c.first_name, c.last_name, s.total_salary FROM employees e
JOIN citizens c ON c.id = e.citizen_id
JOIN departments d ON d.id = e.department_id
JOIN service_providers sp ON sp.id = d.provider_id
JOIN salaries s ON s.employee_id = e.id
WHERE s.total_salary > (
    SELECT AVG(s.total_salary) FROM employees e
    JOIN departments d ON d.id = e.department_id
    JOIN service_providers sp ON sp.id = d.provider_id
    JOIN salaries s ON s.employee_id = e.id
    WHERE d.provider_id = 12
) AND d.provider_id = 12;

-- 11. Retrieve products that have been ordered more than 10 times.
SELECT p.id, p.title, p.price, COUNT(p.id) as product_count
FROM products p
JOIN order_items oi ON oi.product_id = p.id
GROUP BY p.id
HAVING COUNT(p.id) >= 2 -- due to limited orders
ORDER BY product_count DESC;

-- 12. Get users who have never placed an order.
SELECT c.first_name, c.last_name FROM online_shopping_customers osc
JOIN citizens c ON c.id = osc.citizen_id
LEFT JOIN orders o ON o.customer_id = osc.id
WHERE o.id IS NULL;

-- 5) String Functions
-- 13. Extract the first 3 characters of all user emails.
SELECT 
    c.id,
    c.email,
    LEFT(c.email, 3) AS email_prefix
FROM citizens c;

-- 14. Convert all product names to uppercase.
SELECT 
    id,
    UPPER(title) AS uppercase_name
FROM products;

-- 15. Replace 'Inc.' with 'Ltd.' in all company names
SELECT 
    id,
    provider_name,
    REPLACE(provider_name, 'Inc.', 'Ltd.') AS updated_name,
    status
FROM service_providers
WHERE provider_name LIKE '%Inc.%'
ORDER BY id;

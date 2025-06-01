-- Create a view of all active loans
CREATE VIEW active_loans_view AS
SELECT 
    l.id AS loan_id,
    CONCAT_WS(' ', c.first_name, c.last_name) as customer_name,
    a.account_number,
    b.bank_name,
    l.loan_amount,
    l.interest_rate,
    l.start_date,
    l.end_date
FROM loans l
JOIN accounts a ON l.account_id = a.id
JOIN bank_customers bc ON a.bank_customer_id = bc.id
JOIN citizens c ON bc.citizen_id = c.id
JOIN banks b ON a.bank_id = b.id
WHERE l.status = 'approved';

select * from active_loans_view;

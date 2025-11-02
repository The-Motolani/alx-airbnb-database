-- performance.sql

-- STEP 1: Initial complex query
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
JOIN 
    payments pay ON b.id = pay.booking_id;

-- STEP 2: Analyze query performance
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
JOIN 
    payments pay ON b.id = pay.booking_id;

-- STEP 3: Refactored query with indexes
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings (user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings (property_id);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments (booking_id);

SELECT 
    b.id AS booking_id,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount,
    pay.payment_status
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.id
INNER JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON b.id = pay.booking_id;

-- STEP 4: Re-analyze performance after optimization
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount,
    pay.payment_status
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.id
INNER JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON b.id = pay.booking_id;

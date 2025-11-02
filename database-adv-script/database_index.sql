-- Identify high-usage columns:
-- Commonly used in WHERE, JOIN, or ORDER BY clauses.

-- Users(id), Bookings(user_id, property_id, status), Properties(id, location), Payments(booking_id, status)

-- Step 1: Create indexes on frequently queried columns

CREATE INDEX idx_users_id ON users(id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_id ON properties(id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(status);

-- Step 2: Measure query performance BEFORE adding indexes
-- Example complex query joining multiple tables

EXPLAIN ANALYZE
SELECT b.id, u.name, p.title, pay.amount, pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id
WHERE pay.status = 'completed'
AND p.location = 'Lagos'
ORDER BY pay.amount DESC;

-- Step 3: Measure query performance AFTER adding indexes
-- Run the same query again after the indexes are created to compare runtime

EXPLAIN ANALYZE
SELECT b.id, u.name, p.title, pay.amount, pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id
WHERE pay.status = 'completed'
AND p.location = 'Lagos'
ORDER BY pay.amount DESC;

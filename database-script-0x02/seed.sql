-- Sample data for User
INSERT INTO users(user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  ('a1111111-1111-1111-1111-111111111111', 'Alice', 'Anderson', 'alice@example.com', 'hash_a1', '08012345678', 'guest', NOW()),
  ('b2222222-2222-2222-2222-222222222222', 'Bob',   'Brown',     'bob@example.com',   'hash_b2', '08087654321', 'host',  NOW()),
  ('c3333333-3333-3333-3333-333333333333', 'Charlie','Clark',   'charlie@example.com','hash_c3', NULL,        'admin', NOW());

-- Sample data for Property
INSERT INTO properties(property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  ('p4444444-4444-4444-4444-444444444444', 'b2222222-2222-2222-2222-222222222222', 'Cozy Beach House',  'A small house by the sea',        'Lagos Island, Lagos, NG', 150.00, NOW(), NOW()),
  ('p5555555-5555-5555-5555-555555555555', 'b2222222-2222-2222-2222-222222222222', 'Urban Studio Apartment','Modern studio in city centre','Ikeja, Lagos, NG',              80.00, NOW(), NOW());

-- Sample data for Booking
INSERT INTO bookings(booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  ('b6666666-6666-6666-6666-666666666666', 'p4444444-4444-4444-4444-444444444444', 'a1111111-1111-1111-1111-111111111111', '2025-11-10', '2025-11-15', 750.00, 'confirmed', NOW()),
  ('b7777777-7777-7777-7777-777777777777', 'p5555555-5555-5555-5555-555555555555', 'a1111111-1111-1111-1111-111111111111', '2025-12-01', '2025-12-05', 320.00, 'pending',   NOW());

-- Sample data for Payment
INSERT INTO payments(payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  ('pay8888888-8888-8888-8888-888888888888', 'b6666666-6666-6666-6666-666666666666', 750.00, NOW(), 'credit_card'),
  ('pay9999999-9999-9999-9999-999999999999', 'b7777777-7777-7777-7777-777777777777', 320.00, NOW(), 'paypal');

-- Sample data for Review
INSERT INTO reviews(review_id, property_id, user_id, rating, comment, created_at)
VALUES
  ('r1010101-0101-0101-0101-010101010101', 'p4444444-4444-4444-4444-444444444444', 'a1111111-1111-1111-1111-111111111111', 5,   'Fantastic stay! Highly recommend.', NOW()),
  ('r2020202-0202-0202-0202-020202020202', 'p5555555-5555-5555-5555-555555555555', 'a1111111-1111-1111-1111-111111111111', 4,   'Good location but a bit noisy.',      NOW());

-- Sample data for Message
INSERT INTO messages(message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  ('m3030303-0303-0303-0303-030303030303', 'a1111111-1111-1111-1111-111111111111', 'b2222222-2222-2222-2222-222222222222', 'Hi Bob, is the Beach House available for next weekend?', NOW()),
  ('m4040404-0404-0404-0404-040404040404', 'b2222222-2222-2222-2222-222222222222', 'a1111111-1111-1111-1111-111111111111', 'Yes Alice, it is available. Let me know your dates.',        NOW());

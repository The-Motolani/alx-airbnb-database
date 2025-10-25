-- User table
CREATE TABLE users (
  user_id      UUID        PRIMARY KEY,
  first_name   VARCHAR(255) NOT NULL,
  last_name    VARCHAR(255) NOT NULL,
  email        VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(50),
  role         VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
  created_at   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Additional index on email (though UNIQUE creates one)
CREATE INDEX idx_users_email ON users(email);

-- Property table
CREATE TABLE properties (
  property_id     UUID        PRIMARY KEY,
  host_id         UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  name            VARCHAR(255) NOT NULL,
  description     TEXT        NOT NULL,
  location        VARCHAR(255) NOT NULL,
  pricepernight   DECIMAL(10,2) NOT NULL,
  created_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Index to speed up lookups by host_id
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- Booking table
CREATE TABLE bookings (
  booking_id   UUID        PRIMARY KEY,
  property_id  UUID        NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
  user_id      UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  start_date   DATE        NOT NULL,
  end_date     DATE        NOT NULL,
  total_price  DECIMAL(10,2) NOT NULL,
  status       VARCHAR(10) NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
  created_at   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_status ON bookings(status);

-- Payment table
CREATE TABLE payments (
  payment_id     UUID        PRIMARY KEY,
  booking_id     UUID        NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,
  amount         DECIMAL(10,2) NOT NULL,
  payment_date   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card','paypal','stripe'))
);

-- Index on booking_id for fast joins
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- Review table
CREATE TABLE reviews (
  review_id    UUID        PRIMARY KEY,
  property_id  UUID        NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
  user_id      UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  rating       INTEGER     NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment      TEXT        NOT NULL,
  created_at   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for aggregation/lookup
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);

-- Message table
CREATE TABLE messages (
  message_id   UUID        PRIMARY KEY,
  sender_id    UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  recipient_id UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  message_body TEXT        NOT NULL,
  sent_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes to speed up inbox/outbox queries
CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id ON messages(recipient_id);

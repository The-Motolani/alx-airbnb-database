# Normalization Analysis – Airbnb Clone Database Schema  

## Project: Airbnb Clone Backend

---

## 1. Summary of Normalization Objective

I aim to ensure the database design satisfies **Third Normal Form (3NF)**. According to standard definitions:  

- A table must be in 2NF (no partial dependencies of non-key attributes on part of a composite key).  
- And must have **no transitive dependencies** of non-key attributes on other non-key attributes.  
In other words: every non-key attribute must depend *only* on the primary key.
This reduces redundancy, update/insertion/deletion anomalies and supports data integrity.

---

## 2. Review of Existing Schema

### User

- Primary Key: `user_id`  
- Non-key attributes: first_name, last_name, email, password_hash, phone_number, role, created_at  
- Each attribute depends directly on `user_id`. No attribute depends on another non-key attribute → meets 3NF.

### Property

- Primary Key: `property_id`  
- Foreign Key: `host_id` → User(user_id)  
- Non-key: name, description, location, pricepernight, created_at, updated_at  
- All depend on `property_id`. No transitive non-key attribute dependencies → meets 3NF.

### Booking

- Primary Key: `booking_id`  
- FKs: property_id → Property, user_id → User  
- Non-key: start_date, end_date, total_price, status, created_at  
- All directly about the booking. No partial or transitive dependencies → meets 3NF.

### Payment

- Primary Key: `payment_id`  
- FK: booking_id → Booking  
- Non-key: amount, payment_date, payment_method  
- Clearly describe payment record; no transitive link → meets 3NF.

### Review

- Primary Key: `review_id`  
- FKs: property_id → Property, user_id → User  
- Non-key: rating, comment, created_at  
- All depend on `review_id`, no non-key dependencies between them → meets 3NF.

### Message

- Primary Key: `message_id`  
- FKs: sender_id → User, recipient_id → User  
- Non-key: message_body, sent_at  
- Each attribute depends on `message_id`; no transitive non-key dependencies → meets 3NF.

---

## 3. Identification of Potential Redundancies or Violations

At this time, the schema as designed does **not** appear to have partial dependencies (since none of the tables uses a composite key with non-key attributes depending on only part of it) nor obvious transitive dependencies (non-key attributes depending on other non-key attributes).  
Given that, the design already satisfies 3NF.

One thing to be mindful of: when you **extend** the schema with additional attributes (for example profile_picture, is_verified, amenities, transaction_id, etc.) you must ensure these new attributes do *not* introduce transitive dependencies.  
For example, if you add `role_description` to User and it depends on `role`, then you’re introducing a dependency on a non-key (`role`) → this would be a transitive dependency and break 3NF. In that case you’d need a separate Role table.  
Similarly, if you add `amenity_name` or `amenity_description` and store repeated amenity data inside Property table, that might introduce redundancy and would benefit from splitting into a separate Amenities table.

---

## 4. Revised Schema with Enhancements (still in 3NF)

Below are the proposed enhancements, and how they maintain 3NF.

### Enhanced User  

```sql
User (
  user_id UUID PK,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR NULL,
  role ENUM('guest','host','admin') NOT NULL,
  is_verified BOOLEAN DEFAULT FALSE,
  profile_picture VARCHAR NULL,
  last_login TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
```

All new attributes (is_verified, profile_picture, last_login) depend only on user_id — no attribute depends on another non-key attribute. Remains in 3NF.

### Enhanced Property

```sql
Property (
  property_id UUID PK,
  host_id UUID FK → User(user_id),
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  pricepernight DECIMAL NOT NULL,
  property_type ENUM('apartment','house','villa','room','cabin') NOT NULL,
  bedrooms INTEGER NOT NULL,
  bathrooms INTEGER NOT NULL,
  amenities JSONB NULL,
  latitude DECIMAL(9,6) NULL,
  longitude DECIMAL(9,6) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
```

All new attributes describe the property directly and depend on property_id. amenities is a flexible JSONB list but still part of the property record — no transitive dependencies. Therefore still in 3NF.

### Enhanced Payment

```sql
Payment (
  payment_id UUID PK,
  booking_id UUID FK → Booking(booking_id),
  amount DECIMAL NOT NULL,
  currency VARCHAR(3) DEFAULT 'USD',
  transaction_id VARCHAR UNIQUE NOT NULL,
  payment_status ENUM('pending','success','failed','refunded') DEFAULT 'pending',
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
```

New attributes (currency, transaction_id, payment_status) still directly depend on payment_id as the key. No attribute depends on another non-key attribute. Remains in 3NF.

### Optional: Amenities(Separate Tables)

To further de-normalize or reduce redundancy for repeated amenities, you could create:

```sql
Amenity (
  amenity_id UUID PK,
  name VARCHAR NOT NULL,
  description TEXT
)

PropertyAmenity (
  property_id UUID FK → Property(property_id),
  amenity_id UUID FK → Amenity(amenity_id),
  PRIMARY KEY(property_id, amenity_id)
)
```

This breaks out the many-to-many relationship between properties and amenities, preventing repeating amenity names in each property record. Both tables maintain that all non-key attributes depend only on their primary key(s) → 3NF holds.

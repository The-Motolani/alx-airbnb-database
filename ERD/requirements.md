# ERD

```sql
    USER {
        UUID user_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email UNIQUE
        VARCHAR password_hash
        VARCHAR phone_number
        ENUM role (guest, host, admin)
        TIMESTAMP created_at
    }

    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        VARCHAR name
        TEXT description
        VARCHAR location
        DECIMAL pricepernight
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        DATE start_date
        DATE end_date
        DECIMAL total_price
        ENUM status (pending, confirmed, canceled)
        TIMESTAMP created_at
    }

    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        DECIMAL amount
        TIMESTAMP payment_date
        ENUM payment_method (credit_card, paypal, stripe)
    }

    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        INTEGER rating CHECK (1–5)
        TEXT comment
        TIMESTAMP created_at
    }

    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }

    %% Relationships

    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    PROPERTY ||--o{ BOOKING : "is booked for"
    BOOKING ||--|| PAYMENT : "has"
    USER ||--o{ REVIEW : "writes"
    PROPERTY ||--o{ REVIEW : "receives"
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"
```

## Explanation of Entities and Relationships

### 1. User

- **Primary Key:** `user_id`

- **Attributes:** first_name, last_name, email, password_hash, phone_number, role, created_at

- **Relationships:**

> - Can host multiple properties (`User → Property`)
> - Can make multiple bookings (`User → Booking`)
> - Can write reviews for properties (`User → Review`)
> - Can send and receive messages (`User → Message`)

### 2. Property

- **Primary Key:** `property_id`

- **Foreign Key:** `host_id → User(user_id)`

- **Attributes:** name, description, location, pricepernight, created_at, updated_at

- **Relationships:**

> - Belongs to a host (User)
> - Can have many bookings (`Property → Booking`)
> - Can receive many reviews (`Property → Review`)

### 3. Booking

- **Primary Key:** `booking_id`

- **Foreign Keys:**

> - `property_id → Property(property_id)`
> - `user_id → User(user_id)`

- **Attributes:** start_date, end_date, total_price, status, created_at

- **Relationships:**

- Made by a user

- Refers to a specific property

- Has one payment (`Booking → Payment`)

### 4. Payment

- **Primary Key:** `payment_id`

- **Foreign Key:** `booking_id → Booking(booking_id)`

- **Attributes:** amount, payment_date, payment_method

- **Relationship:** Each payment is linked to one booking.

### 5. Review

- **Primary Key:** `review_id`

- **Foreign Keys:**

`property_id → Property(property_id)`

`user_id → User(user_id)`

- **Attributes:** rating, comment, created_at

- **Relationships:**

> - Written by a user
> - Associated with a property

### 6. Message

- **Primary Key:** `message_id`

- **Foreign Keys:**

`sender_id → User(user_id)`

`recipient_id → User(user_id)`

- **Attributes:** message_body, sent_at

- **Relationships:**

> - A user can send many messages
> - A user can receive many messages

### Diagram Legend

- `||` means “exactly one”

- `o{` means “zero or many”

- Lines represent cardinality:

> - One-to-Many: `User ||--o{ Property`
> - One-to-One: `Booking ||--|| Payment`
> - Many-to-Many (resolved via Booking or Message table relationships)

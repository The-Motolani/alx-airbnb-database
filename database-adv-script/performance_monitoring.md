# Database Performance Monitoring and Refinement Report

## Objective

The goal of this task is to continuously monitor and refine the performance of the Airbnb database by analyzing execution plans and applying schema or index optimizations to reduce query time and improve efficiency.

## Step 1: Queries Monitored

The following frequently used queries were analyzed using `EXPLAIN ANALYZE`:

### Query 1 – Retrieve All Completed Bookings by User

```sql
EXPLAIN ANALYZE
SELECT b.id, u.name, p.title, b.start_date, b.end_date, pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id
WHERE pay.status = 'completed'
ORDER BY b.start_date DESC;
```

**Observation:**

- Total execution time: ~900 ms

- Sequential scans on `payments` and `bookings` tables

- Sorting operation on `b.start_date` caused additional overhead.

### Query 2 – Fetch Properties by Location with High Ratings

```sql
EXPLAIN ANALYZE
SELECT p.id, p.title, p.location, AVG(r.rating) AS avg_rating
FROM properties p
LEFT JOIN reviews r ON r.property_id = p.id
WHERE p.location = 'Lagos'
GROUP BY p.id
HAVING AVG(r.rating) > 4.0;
```

**Observation:**

- Execution time: ~700 ms

- Sequential scan on `reviews` table

- Filter condition on `location` without index support.

## Step 2: Identified Bottlenecks

|Problem Area|Cause|Impact|
|------------|-----|------|
|Slow filtering on `location`|No index on `properties.location`|High scan time|
|Sorting on `b.start_date`|No index on `start_date`|Increased sort cost|
|Full scan on `payments.status`|Missing index|Slower filtering for completed payments|
|Aggregation over `reviews`|Missing pre-aggregated data or index|Increased CPU usage|

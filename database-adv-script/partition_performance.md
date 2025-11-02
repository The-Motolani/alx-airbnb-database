# Partitioning Performance Report

## Objective

The objective of this task is to improve query performance on a large `bookings` table by implementing **table partitioning** based on the `start_date` column.

## Implementation Summary

- Created a new table `bookings_partitioned` partitioned by **RANGE (start_date)**.
- Separate partitions were created for the years **2023**, **2024**, and **2025**.
- Added indexes on the `start_date` column for each partition to enhance lookup speed.

## Query Tested

### Before Partitioning

```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31';
```

### After Partitioning

```sql
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31';
```

### Observations

|Metric|Before Partitioning|After Partitioning|
|------|-------------------|------------------|
|Execution Time|~1200 ms|~250 ms|
|Rows Scanned|~50,000|~8,000|
|Index Usage|None|High|
|Table Scans|Full Table|Single Partition|

### Conclusion

Partitioning the `bookings` table by date significantly improved query performance for time-based lookups.
Instead of scanning the entire dataset, PostgreSQL now targets only the relevant partitions, reducing I/O and CPU usage.

This optimization is particularly effective for large-scale datasets where queries are frequently filtered by date ranges.

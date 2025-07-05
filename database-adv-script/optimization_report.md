# Task 5: Complex Query Optimization

## 1. Initial Query
See `performance.sql` for the full query.

```sql
-- Copy of initial query from performance.sql

## 2. EXPLAIN ANALYZE (Before)

```sql
EXPLAIN ANALYZE
SELECT
  b.*,
  u.first_name || ' ' || u.last_name AS user_name,
  p.name                 AS property_name,
  pay.amount             AS payment_amount
FROM Bookings b
JOIN Users u       ON b.user_id     = u.user_id
JOIN Properties p  ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id  = pay.booking_id;

QUERY PLAN
Hash Join  (cost=57.67..89.99 rows=970 width=430) (actual time=0.023..0.024 rows=0 loops=1)
  Hash Cond: (b.property_id = p.property_id)
  -> Hash Join  (cost=43.40..68.26 rows=970 width=316) (never executed)
       Hash Cond: (b.user_id = u.user_id)
       -> Hash Right Join  (cost=29.80..52.06 rows=970 width=80) (never executed)
            Hash Cond: (pay.booking_id = b.booking_id)
            -> Seq Scan on payments pay    (cost=0.00..19.70 rows=970 width=32) (never executed)
            -> Hash  (cost=18.80..18.80 rows=880 width=64) (never executed)
                 -> Seq Scan on bookings b  (cost=0.00..18.80 rows=880 width=64) (never executed)
       -> Hash  (cost=11.60..11.60 rows=160 width=252) (never executed)
            -> Seq Scan on users u       (cost=0.00..11.60 rows=160 width=252) (never executed)
  -> Hash  (cost=11.90..11.90 rows=190 width=334) (actual time=0.013..0.013 rows=0 loops=1)
       Buckets: 1024  Batches: 1  Memory Usage: 8kB
  -> Seq Scan on properties p         (cost=0.00..11.90 rows=190 width=334) (actual time=0.012..0.012 rows=0 loops=1)
Planning Time: 1.419 ms
Execution Time: 0.068 ms
(16 rows)

## 4. EXPLAIN ANALYZE (After)

```sql
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  p.property_id,
  p.name        AS property_name,
  pay.amount    AS payment_amount
FROM Bookings b
JOIN Users u       ON b.user_id     = u.user_id
JOIN Properties p  ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;

 Hash Join  (cost=57.67..89.99 rows=970 width=422) (actual time=0.017..0.018 rows=0 loops=1)
   Hash Cond: (b.property_id = p.property_id)
   ->  Hash Join  (cost=43.40..68.26 rows=970 width=308) (never executed)
         Hash Cond: (b.user_id = u.user_id)
         ->  Hash Right Join  (cost=29.80..52.06 rows=970 width=72) (never executed)
               Hash Cond: (pay.booking_id = b.booking_id)
               ->  Seq Scan on payments pay  (cost=0.00..19.70 rows=970 width=32) (never executed)
               ->  Hash  (cost=18.80..18.80 rows=880 width=56) (never executed)
                     ->  Seq Scan on bookings b  (cost=0.00..18.80 rows=880 width=56) (never executed)
         ->  Hash  (cost=11.60..11.60 rows=160 width=252) (never executed)
               ->  Seq Scan on users u  (cost=0.00..11.60 rows=160 width=252) (never executed)
   ->  Hash  (cost=11.90..11.90 rows=190 width=334) (actual time=0.010..0.010 rows=0 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 8kB
         ->  Seq Scan on properties p  (cost=0.00..11.90 rows=190 width=334) (actual time=0.009..0.009 rows=0 loops=1)
 Planning Time: 0.298 ms
 Execution Time: 0.059 ms
(16 rows)




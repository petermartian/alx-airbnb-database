# Task 6: Partitioning Performance

## 1. Before Partitioning


EXPLAIN ANALYZE
SELECT *
FROM Bookings
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

Seq Scan on bookings  (cost=0.00..23.20 rows=4 width=64) (actual time=0.006..0.007 rows=0 loops=1)
  Filter: ((start_date >= '2025-07-01'::date) AND (start_date <= '2025-07-31'::date))
Planning Time: 0.088 ms
Execution Time: 0.021 ms
(4 rows)


After Partitioning
EXPLAIN ANALYZE
SELECT *
FROM Bookings
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';


Seq Scan on bookings  (cost=0.00..23.20 rows=4 width=64) (actual time=0.006..0.006 rows=0 loops=1)
  Filter: ((start_date >= '2025-07-01'::date) AND (start_date <= '2025-07-31'::date))
Planning Time: 0.073 ms
Execution Time: 0.015 ms
(4 rows)

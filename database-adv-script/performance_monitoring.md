# Task 7: Performance Monitoring & Refinement

## 1. Selected Queries

1. **Bookings by user**  
   ```sql
   SELECT * 
   FROM Bookings 
   WHERE user_id = '11111111-1111-1111-1111-111111111111';

Bitmap Heap Scan on bookings  (cost=4.18..12.64 rows=4 width=64) (actual time=0.011..0.011 rows=0 loops=1)
   Recheck Cond: (user_id = '11111111-1111-1111-1111-111111111111'::uuid)
   ->  Bitmap Index Scan on idx_bookings_user  (cost=0.00..4.18 rows=4 width=0) (actual time=0.003..0.004 rows=0 loops=1)
         Index Cond: (user_id = '11111111-1111-1111-1111-111111111111'::uuid)
 Planning Time: 0.107 ms
 Execution Time: 0.033 ms
(6 rows)


2. ** Bookings in date range**

	SELECT * 
FROM Bookings 
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

Seq Scan on bookings  (cost=0.00..23.20 rows=4 width=64) (actual time=0.009..0.009 rows=0 loops=1)
   Filter: ((start_date >= '2025-07-01'::date) AND (start_date <= '2025-07-31'::date))
 Planning Time: 0.142 ms
 Execution Time: 0.026 ms
(4 rows)


3. Identified Bottlenecks
Query 1 still does a Bitmap Heap Scan on Bookings → could benefit from a composite index on (user_id, start_date).

Query 2 is a simple Seq Scan on start_date → we have a single-column index, but on larger data a partitioned setup will help more.


4. Schema Adjustment
Add a composite index to speed up Query 1 when filtering by user and date:

CREATE INDEX idx_bookings_user_start 
  ON Bookings(user_id, start_date);


5. Re-Benchmark
Query 1 (after)

EXPLAIN ANALYZE
SELECT * 
FROM Bookings 
WHERE user_id = '11111111-1111-1111-1111-111111111111'
  AND start_date BETWEEN '2025-07-01' AND '2025-07-31';

 Index Scan using idx_bookings_user_start on bookings  (cost=0.15..8.17 rows=1 width=64) (actual time=0.002..0.003 rows=0 loops=1)
   Index Cond: ((user_id = '11111111-1111-1111-1111-111111111111'::uuid) AND (start_date >= '2025-07-01'::date) AND (start_date <= '2025-07-31'::date))
 Planning Time: 0.612 ms
 Execution Time: 0.014 ms
(4 rows)
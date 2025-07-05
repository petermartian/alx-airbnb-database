-- 1) Total bookings per user
SELECT
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  COUNT(b.booking_id) AS total_bookings
FROM Users u
LEFT JOIN Bookings b
  ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name;


-- 2) Rank properties by number of bookings
SELECT
  p.property_id,
  p.name AS property_name,
  COUNT(b.booking_id) AS bookings_count,
  RANK() OVER (
    ORDER BY COUNT(b.booking_id) DESC
  ) AS booking_rank
FROM Properties p
LEFT JOIN Bookings b
  ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;

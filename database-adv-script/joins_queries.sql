-- 1) INNER JOIN: all bookings with their users
SELECT
  b.booking_id,
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  b.start_date,
  b.end_date
FROM Bookings b
INNER JOIN Users u
  ON b.user_id = u.user_id;


-- 2) LEFT JOIN: all properties with their reviews (if any)
SELECT
  p.property_id,
  p.name AS property_name,
  r.review_id,
  r.rating,
  r.comment
FROM Properties p
LEFT JOIN Reviews r
  ON p.property_id = r.property_id;


-- 3) FULL OUTER JOIN: all users and all bookings
SELECT
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  b.booking_id,
  b.start_date
FROM Users u
FULL OUTER JOIN Bookings b
  ON u.user_id = b.user_id;

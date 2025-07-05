-- 1) Non‐correlated subquery: properties with avg rating > 4.0
SELECT *
FROM Properties p
WHERE (
  SELECT AVG(r.rating)
  FROM Reviews r
  WHERE r.property_id = p.property_id
) > 4.0;


-- 2) Correlated subquery: users with more than 3 bookings
SELECT u.user_id, u.first_name || ' ' || u.last_name AS user_name
FROM Users u
WHERE (
  SELECT COUNT(*)
  FROM Bookings b
  WHERE b.user_id = u.user_id
) > 3;

-- Add example users
INSERT INTO Users (user_id, first_name, last_name, email)
VALUES
  ('11111111-1111-1111-1111-111111111111','Alice','Anderson','alice@example.com'),
  ('22222222-2222-2222-2222-222222222222','Bob','Brown','bob@example.com');

-- Add example hosts
INSERT INTO Hosts (host_id, host_name, contact)
VALUES
  ('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1','Carol Host','carol@example.com'),
  ('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2','Dave Host','dave@example.com');

-- Add properties
INSERT INTO Properties (property_id, host_id, name, address)
VALUES
  ('prop-0001-0000-0000-000000000001','aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1','Cozy Cottage','123 Maple St'),
  ('prop-0002-0000-0000-000000000002','bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2','City Loft','456 Oak Ave');

-- Add bookings
INSERT INTO Bookings (booking_id, user_id, property_id, start_date, end_date)
VALUES
  ('book-0001-0000-0000-000000000001','11111111-1111-1111-1111-111111111111','prop-0001-0000-0000-000000000001','2025-07-10','2025-07-15'),
  ('book-0002-0000-0000-000000000002','22222222-2222-2222-2222-222222222222','prop-0002-0000-0000-000000000002','2025-08-01','2025-08-03');

-- Add payments
INSERT INTO Payments (payment_id, booking_id, amount)
VALUES
  ('pay-0001-0000-0000-000000000001','book-0001-0000-0000-000000000001', 500.00),
  ('pay-0002-0000-0000-000000000002','book-0002-0000-0000-000000000002', 300.00);

-- Task 6: Partition the Bookings table by start_date

-- 1) Rename the old table
ALTER TABLE Bookings RENAME TO bookings_old;

-- 2) Create a new partitioned parent
CREATE TABLE Bookings (
  booking_id  UUID       PRIMARY KEY,
  user_id     UUID       NOT NULL,
  property_id UUID       NOT NULL,
  start_date  DATE       NOT NULL,
  end_date    DATE       NOT NULL,
  created_at  TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 3) Create yearly partitions
CREATE TABLE bookings_2024 PARTITION OF Bookings
  FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF Bookings
  FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- 4) Move the data into the new structure
INSERT INTO Bookings SELECT * FROM bookings_old;

-- 5) Drop the old table
DROP TABLE bookings_old;

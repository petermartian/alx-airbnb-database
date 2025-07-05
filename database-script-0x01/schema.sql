-- Users of our Airbnb
CREATE TABLE Users (
  user_id   UUID PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50),
  email      VARCHAR(100) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hosts (property owners)
CREATE TABLE Hosts (
  host_id   UUID PRIMARY KEY,
  host_name VARCHAR(100) NOT NULL,
  contact   VARCHAR(100)
);

-- Properties listed on Airbnb
CREATE TABLE Properties (
  property_id UUID PRIMARY KEY,
  host_id     UUID NOT NULL REFERENCES Hosts(host_id),
  name        VARCHAR(150) NOT NULL,
  address     TEXT,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings made by users
CREATE TABLE Bookings (
  booking_id  UUID PRIMARY KEY,
  user_id     UUID NOT NULL REFERENCES Users(user_id),
  property_id UUID NOT NULL REFERENCES Properties(property_id),
  start_date  DATE NOT NULL,
  end_date    DATE NOT NULL,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payments for each booking
CREATE TABLE Payments (
  payment_id UUID PRIMARY KEY,
  booking_id UUID NOT NULL REFERENCES Bookings(booking_id),
  amount     DECIMAL(10,2) NOT NULL,
  paid_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index example for quick lookups
CREATE INDEX idx_bookings_user ON Bookings(user_id);

-- Greenway Gated Community Portal — Database Setup
-- Run this once before starting the application.

CREATE DATABASE IF NOT EXISTS gated_community;
USE gated_community;

-- Hibernate's hbm2ddl.auto=update will create the tables automatically on first run.
-- The two queries below are here for reference and for any manual inspection.

-- CREATE TABLE residents (
--     residentId   INT AUTO_INCREMENT PRIMARY KEY,
--     userName     VARCHAR(100) NOT NULL UNIQUE,
--     password     VARCHAR(255) NOT NULL,
--     email        VARCHAR(150) NOT NULL,
--     phoneNumber  VARCHAR(20)  NOT NULL,
--     role         VARCHAR(20)  NOT NULL DEFAULT 'Resident'
-- );

-- CREATE TABLE complaints (
--     complaintId  INT AUTO_INCREMENT PRIMARY KEY,
--     userId       INT          NOT NULL,
--     category     VARCHAR(100) NOT NULL,
--     subject      VARCHAR(200) NOT NULL,
--     description  TEXT         NOT NULL,
--     flatNo       INT          NOT NULL,
--     status       VARCHAR(50)  NOT NULL DEFAULT 'Open'
-- );

-- ── Seed an admin account ────────────────────────────────────────
-- Admin accounts cannot be created through the UI by design.
-- Insert one manually and use it to manage complaints.
--
-- INSERT INTO residents (userName, password, email, phoneNumber, role)
-- VALUES ('admin', 'changeme', 'admin@greenway.com', '9999999999', 'Admin');

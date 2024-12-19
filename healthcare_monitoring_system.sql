CREATE DATABASE IF NOT EXISTS healthcare_monitoring_system;
USE healthcare_monitoring_system;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS health_records;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS users;

-- Create tables
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    age INT NOT NULL,
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    contact_no VARCHAR(15) NOT NULL
);

CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE health_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    record_date DATE NOT NULL,
    blood_pressure VARCHAR(15),
    heart_rate INT,
    sugar_level DECIMAL(5,2),
    cholesterol_level DECIMAL(5,2),
    additional_notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert example data
INSERT INTO users (username, password, email, first_name, last_name, gender, age, height, weight, contact_no)
VALUES 
('john_doe', 'secure_password', 'john.doe@example.com', 'John', 'Doe', 'Male', 28, 175.5, 70.0, '+1234567890'),
('jane_doe', 'secure_password', 'jane.doe@example.com', 'Jane', 'Doe', 'Female', 25, 160.0, 55.0, '+0987654321');

INSERT INTO appointments (user_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES
(1, 101, '2024-12-20', '10:30:00', 'Scheduled', 'General Checkup'),
(2, 102, '2024-12-21', '15:00:00', 'Scheduled', 'Diabetes Management');

INSERT INTO health_records (user_id, record_date, blood_pressure, heart_rate, sugar_level, cholesterol_level, additional_notes)
VALUES
(1, '2024-12-01', '120/80', 72, 5.6, 200, 'All metrics normal.'),
(2, '2024-12-01', '130/85', 78, 7.2, 220, 'Monitor sugar levels closely.');


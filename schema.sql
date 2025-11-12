
-- MySQL schema for academy backend
CREATE DATABASE IF NOT EXISTS academy_db;
USE academy_db;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data (optional)
INSERT INTO users (name,email,password) VALUES ('Test User','test@example.com','{bcrypt_hash_here}');

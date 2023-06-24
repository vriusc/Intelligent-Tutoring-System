CREATE SCHEMA IF NOT EXISTS test;

-- Path: test.sql

USE test;

-- Create table for user(student)
CREATE TABLE IF NOT EXISTS student_user (
    id         INT AUTO_INCREMENT   PRIMARY KEY,
    username   VARCHAR(50)          NOT NULL,
    password   VARCHAR(255)         NOT NULL,
    email      VARCHAR(255)         NOT NULL,
    CONSTRAINT Email UNIQUE (email),
    CONSTRAINT Username UNIQUE (username)
);
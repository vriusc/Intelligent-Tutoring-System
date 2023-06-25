CREATE SCHEMA IF NOT EXISTS test;

-- Path: test.sql

USE test;

-- create table student-info
CREATE TABLE Users (
    Id INT AUTO_INCREMENT, -- Unique ID for each user
    Username VARCHAR(50) NOT NULL, -- Unique username
    Password VARCHAR(255) NOT NULL,  -- Hashed password
    Email VARCHAR(255) NOT NULL,    -- Unique email
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    Study_Time INT NOT NULL, -- Total study time in seconds
    PRIMARY KEY(id),    -- Set id as primary key
    UNIQUE(username),  -- Set username as unique
    UNIQUE(email)  -- Set email as unique
);
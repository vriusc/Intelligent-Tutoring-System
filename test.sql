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

-- CREATE TABLE Materials,used to store different educational materials
CREATE TABLE Materials (
    Materials_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each material
    File_Path VARCHAR(255) NOT NULL-- Path to the file
);

-- CREATE TABLE Listening_Judgement_By_Picture - check if the picture matches the audio
CREATE TABLE Listening_Judgement_By_Picture (
    Listening_Judgement_By_Picture_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Question VARCHAR(255) NOT NULL,      -- Description of the question Like "Does the picture match the audio?"
    Picture_File_Path INT NOT NULL,     -- Picture_File_Path
    Audio_File_Path INT NOT NULL, -- Path to the Audio
    Answer ENUM ('True', 'False') NOT NULL,    -- Answer
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Date of creation
    FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID),
    FOREIGN KEY (Audio_File_Path) REFERENCES Materials(Materials_ID)
);
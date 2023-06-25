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

-- CREATE TABLE Listening_Judgement_By_Picture - to see if the picture matches the audio
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

-- CREATE TABLE Listening_Choice_By_Picture - choose the option if the picture matches the audio
CREATE TABLE Listening_Choice_By_Picture (
    Listening_Choice_By_Picture_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Question VARCHAR(255) NOT NULL,    -- Description of the question Like "Choose the options that correspond to the audio"
    Picture_File_Path INT NOT NULL,     -- Picture_File_Path
    Audio_File_Path INT NOT NULL, -- Path to the Audio
    Answer ENUM ('A', 'B', 'C', 'E', 'F', 'G') NOT NULL,    -- Answer
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
    FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID),
    FOREIGN KEY (Audio_File_Path) REFERENCES Materials(Materials_ID)
);


-- CREATE TABLE Listen_Choice_Right_Word - choose the option if the description matches the audio
CREATE TABLE Listen_Choice_Right_Word (
    Listen_Choice_Right_Word_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Question VARCHAR(255) NOT NULL,      -- Description of the question Like "Choose corresponding words to the audio"
    Audio_File_Path INT NOT NULL, -- Path to the Audio
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
    FOREIGN KEY (Audio_File_Path) REFERENCES Materials(Materials_ID)
);

-- Choose the appropriate answer based on the questions asked in the audio
CREATE TABLE Listen_Choice_Right_Word_Answer (
    Listen_Choice_Right_Word_Answer_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Listen_Choice_Right_Word_ID INT NOT NULL,   -- Unique ID for each question
    Choice VARCHAR(255) NOT NULL,      -- Choice
    isRight ENUM ('True', 'False') NOT NULL,    -- isRight
    FOREIGN KEY (Listen_Choice_Right_Word_ID) REFERENCES Listen_Choice_Right_Word(Listen_Choice_Right_Word_ID)
);

-- Reading Judgement By Picture
CREATE TABLE Reading_Judgement_By_Picture (
    Reading_Judgement_By_Picture_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Question VARCHAR(255) NOT NULL,      -- Description of the question Like "judge correctness based on the picture"
    Picture_File_Path INT NOT NULL,     -- Picture_File_Path
    Answer ENUM ('True', 'False') NOT NULL,    -- Answer
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
    FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID)
);

-- Reading Choice the right Picture about the word
CREATE TABLE Reading_Choice_Right_Picture_About_Word (
    Reading_Choice_Right_Picture_About_Word_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Picture_File_Path INT NOT NULL,      -- Picture_File_Path
    Question VARCHAR(255) NOT NULL,      -- Question is a word to describe the picture
    Answer ENUM ('A', 'B', 'C','D','E','F') NOT NULL,    -- Answer
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
    FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID)
);

-- Reading Choice the right word about the question
CREATE TABLE Reading_Choice_Right_Answer_About_Question (
    Reading_Choice_Right_Answer_About_Question_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
    Question VARCHAR(255) NOT NULL,      -- Question is a word ,you need to choose the right choice to answer this question
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Date of creation
);



CREATE TABLE Reading_Choice_Right_Answer_About_Question_Answer(
    Reading_Choice_Right_Answer_About_Question_Answer_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
    Reading_Choice_Right_Answer_About_Question_ID INT NOT NULL,   -- Unique ID for each question
    Answer VARCHAR(255) NOT NULL,       -- Answer
    is_correct ENUM ('True', 'False') NOT NULL,   -- is correct
    FOREIGN KEY (Reading_Choice_Right_Answer_About_Question_ID) REFERENCES Reading_Choice_Right_Answer_About_Question(Reading_Choice_Right_Answer_About_Question_ID)
);


CREATE TABLE Reading_Choice_Right_Answer_About_Text(
    Reading_Choice_Right_Answer_About_Text_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
    Text VARCHAR(255) NOT NULL,       -- Text
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
    DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Date of creation
);

CREATE TABLE Reading_Choice_Right_Answer_About_Text_Question(
    Reading_Choice_Right_Answer_About_Text_Question_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
    Reading_Choice_Right_Answer_About_Text_ID INT NOT NULL,   -- Unique ID for each question
    Question VARCHAR(255) NOT NULL,       -- Question
    FOREIGN KEY (Reading_Choice_Right_Answer_About_Text_ID) REFERENCES Reading_Choice_Right_Answer_About_Text(Reading_Choice_Right_Answer_About_Text_ID)
);

CREATE TABLE Reading_Choice_Right_Answer_About_Text_Question_Answer(
    Reading_Choice_Right_Answer_About_Text_Question_Answer_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
    Reading_Choice_Right_Answer_About_Text_Question_ID INT NOT NULL,   -- Unique ID for each question
    Answer VARCHAR(255) NOT NULL,       -- Answer
    is_correct ENUM ('True', 'False') NOT NULL,   -- is correct
    FOREIGN KEY (Reading_Choice_Right_Answer_About_Text_Question_ID) REFERENCES Reading_Choice_Right_Answer_About_Text_Question(Reading_Choice_Right_Answer_About_Text_Question_ID)
);

CREATE TABLE Test (
    Test_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID
    Title VARCHAR(255) NOT NULL, -- Test title
    Type ENUM ('Reading', 'Listen') NOT NULL, -- Test type
    Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level of the test
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Creation date
);


-- Table for associating the type of questions as "Listening_Judgement_By_Picture"
CREATE TABLE Test_Listening_Judgement_By_Picture (
    Test_ID INT NOT NULL, -- Test ID
    Listening_Judgement_By_Picture_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Listening_Judgement_By_Picture_ID) REFERENCES Listening_Judgement_By_Picture(Listening_Judgement_By_Picture_ID)
);

-- Table for associating the question type as "Listening_Choice_By_Picture"
CREATE TABLE Test_Listening_Choice_By_Picture (
    Test_ID INT NOT NULL, -- Test ID
    Listening_Choice_By_Picture_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Listening_Choice_By_Picture_ID) REFERENCES Listening_Choice_By_Picture(Listening_Choice_By_Picture_ID)
);

-- Table for associating the question type as "Listening_Choice_Right_Word"
CREATE TABLE Test_Listen_Choice_Right_Word (
    Test_ID INT NOT NULL, -- Test ID
    Listen_Choice_Right_Word_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Listen_Choice_Right_Word_ID) REFERENCES Listen_Choice_Right_Word(Listen_Choice_Right_Word_ID)
);

-- Table for associating the question type as "Reading_Judgement_By_Picture"
CREATE TABLE Test_Reading_Judgement_By_Picture (
    Test_ID INT NOT NULL, -- Test ID
    Reading_Judgement_By_Picture_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Reading_Judgement_By_Picture_ID) REFERENCES Reading_Judgement_By_Picture(Reading_Judgement_By_Picture_ID)
);

-- Table for associating the question type as "Reading_Choice_Right_Picture_About_Word"
CREATE TABLE Test_Reading_Choice_Right_Picture_About_Word (
    Test_ID INT NOT NULL, -- Test ID
    Reading_Choice_Right_Picture_About_Word_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Reading_Choice_Right_Picture_About_Word_ID) REFERENCES Reading_Choice_Right_Picture_About_Word(Reading_Choice_Right_Picture_About_Word_ID)
);

-- Table for associating the question type as "Reading_Choice_Right_Answer_About_Question"
CREATE TABLE Test_Reading_Choice_Right_Answer_About_Question (
    Test_ID INT NOT NULL, -- Test ID
    Reading_Choice_Right_Answer_About_Question_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Reading_Choice_Right_Answer_About_Question_ID) REFERENCES Reading_Choice_Right_Answer_About_Question(Reading_Choice_Right_Answer_About_Question_ID)
);

-- Table for associating the question type as "Reading_Choice_Right_Answer_About_Text"
CREATE TABLE Test_Reading_Choice_Right_Answer_About_Text (
    Test_ID INT NOT NULL, -- Test ID
    Reading_Choice_Right_Answer_About_Text_ID INT NOT NULL, -- Question ID
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Reading_Choice_Right_Answer_About_Text_ID) REFERENCES Reading_Choice_Right_Answer_About_Text(Reading_Choice_Right_Answer_About_Text_ID)
);

CREATE TABLE Score (
    Score_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID
    Test_ID INT NOT NULL, -- Test ID
    User_ID INT NOT NULL, -- User ID
    Score INT NOT NULL, -- Score
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Test date
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(Id)
);

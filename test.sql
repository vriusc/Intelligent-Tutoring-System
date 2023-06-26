CREATE SCHEMA IF NOT EXISTS test;

-- Path: test.sql

USE test;


-- CREATE TABLE student_user to store information about the user
CREATE TABLE student_user (
    id         INT AUTO_INCREMENT   PRIMARY KEY, -- Unique ID for each user
    username   VARCHAR(50)          NOT NULL,   -- Unique username
    password   VARCHAR(255)         NOT NULL,  -- Hashed password
    email      VARCHAR(255)         NOT NULL,   -- Unique email
    CONSTRAINT Email UNIQUE (email),  -- Set email as unique
    CONSTRAINT Username UNIQUE (username)  -- Set username as unique
);

-- CREATE TABLE Subjects to store information about the subjects
CREATE TABLE  Subjects (
    subject_id      INT AUTO_INCREMENT  PRIMARY KEY,  -- Unique ID for each subject
    subject_name    VARCHAR(50)         NOT NULL,  -- Subject name
    level           VARCHAR(50)         NOT NULL, -- Subject level
    description     VARCHAR(255)        NOT NULL -- Subject description
);

-- CREATE TABLE student_subjects to store information about the subjects that the student is studying
CREATE TABLE  student_subjects (
    student_subject_id INT  AUTO_INCREMENT PRIMARY KEY, -- Unique ID for relation between each student and the subject
    student_id         INT  NOT NULL, -- ID of the student
    subject_id         INT  NOT NULL, -- ID of the subject
    progress           INT  NOT NULL, -- Progress of the student in the subject
    FOREIGN KEY (student_id) REFERENCES student_user (id), -- Set student_id as foreign key from table student_user's id
    FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id) -- Set subject_id as foreign key from table Subjects's subject_id
);

-- CREATE TABLE Units to store information about all units
CREATE TABLE  Units (
    unit_id         INT             AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each unit
    unit_name       VARCHAR(50)     NOT NULL,  -- Unit name
    subject_id      INT             NOT NULL,  -- ID of the subject
    Units_order     INT             NOT NULL,  -- Order of the unit
    description     VARCHAR(255)    NOT NULL,  -- Unit description
    materials_path  VARCHAR(255),  -- Path to the materials
    FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id) -- Set subject_id as foreign key from table Subjects's subject_id
);

-- CREATE TABLE question_types to types of questions
CREATE TABLE question_types (
    question_type_id    INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question type
    question_type       VARCHAR(255) NOT NULL -- Question type
);

-- CREATE TABLE questions to store information about all questions
CREATE TABLE questions (
    question_id         INT             AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
    question            VARCHAR(255)    NOT NULL, -- Contents of the question
    question_type_id    INT             NOT NULL, -- ID of the question type
    picture_path        VARCHAR(255), -- Path to the picture
    video_path          VARCHAR(255), -- Path to the video
    audio_path          VARCHAR(255), -- Path to the audio
    question_order      INT             NOT NULL, -- Order of the question
    explanation         VARCHAR(255)    NOT NULL, -- Explanation of the question
    FOREIGN KEY (question_type_id) REFERENCES question_types (question_type_id) -- Set question_type_id as foreign key from table question_types's question_type_id
);

-- CREATE TABLE question_units to store information about the relation between questions and units
CREATE TABLE question_units (
    question_unit_id    INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for relation between each question and unit
    question_id         INT NOT NULL, -- ID of the question
    unit_id             INT NOT NULL, -- ID of the unit
    FOREIGN KEY (question_id) REFERENCES questions (question_id), -- Set question_id as foreign key from table questions's question_id
    FOREIGN KEY (unit_id) REFERENCES Units (unit_id) -- Set unit_id as foreign key from table Units's unit_id
);















# -- create table student-info
# CREATE TABLE Users (
#     Id INT AUTO_INCREMENT, -- Unique ID for each user
#     Username VARCHAR(50) NOT NULL, -- Unique username
#     Password VARCHAR(255) NOT NULL,  -- Hashed password
#     Email VARCHAR(255) NOT NULL,    -- Unique email
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     Study_Time INT NOT NULL, -- Total study time in seconds
#     PRIMARY KEY(id),    -- Set id as primary key
#     UNIQUE(username),  -- Set username as unique
#     UNIQUE(email)  -- Set email as unique
# );
#
# -- CREATE TABLE Materials,used to store different educational materials
# CREATE TABLE Materials (
#     Materials_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each material
#     File_Path VARCHAR(255) NOT NULL-- Path to the file
# );
#
# -- CREATE TABLE Listening_Judgement_By_Picture - to see if the picture matches the audio
# CREATE TABLE Listening_Judgement_By_Picture (
#     Listening_Judgement_By_Picture_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Question VARCHAR(255) NOT NULL,      -- Description of the question Like "Does the picture match the audio?"
#     Picture_File_Path INT NOT NULL,     -- Picture_File_Path
#     Audio_File_Path INT NOT NULL, -- Path to the Audio
#     Answer ENUM ('True', 'False') NOT NULL,    -- Answer
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Date of creation
#     FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID),
#     FOREIGN KEY (Audio_File_Path) REFERENCES Materials(Materials_ID)
# );
#
# -- CREATE TABLE Listening_Choice_By_Picture - choose the option if the picture matches the audio
# CREATE TABLE Listening_Choice_By_Picture (
#     Listening_Choice_By_Picture_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Question VARCHAR(255) NOT NULL,    -- Description of the question Like "Choose the options that correspond to the audio"
#     Picture_File_Path INT NOT NULL,     -- Picture_File_Path
#     Audio_File_Path INT NOT NULL, -- Path to the Audio
#     Answer ENUM ('A', 'B', 'C', 'E', 'F', 'G') NOT NULL,    -- Answer
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
#     FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID),
#     FOREIGN KEY (Audio_File_Path) REFERENCES Materials(Materials_ID)
# );
#
#
# -- CREATE TABLE Listen_Choice_Right_Word - choose the option if the description matches the audio
# CREATE TABLE Listen_Choice_Right_Word (
#     Listen_Choice_Right_Word_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Question VARCHAR(255) NOT NULL,      -- Description of the question Like "Choose corresponding words to the audio"
#     Audio_File_Path INT NOT NULL, -- Path to the Audio
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
#     FOREIGN KEY (Audio_File_Path) REFERENCES Materials(Materials_ID)
# );
#
# -- Choose the appropriate answer based on the questions asked in the audio
# CREATE TABLE Listen_Choice_Right_Word_Answer (
#     Listen_Choice_Right_Word_Answer_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Listen_Choice_Right_Word_ID INT NOT NULL,   -- Unique ID for each question
#     Choice VARCHAR(255) NOT NULL,      -- Choice
#     isRight ENUM ('True', 'False') NOT NULL,    -- isRight
#     FOREIGN KEY (Listen_Choice_Right_Word_ID) REFERENCES Listen_Choice_Right_Word(Listen_Choice_Right_Word_ID)
# );
#
# -- Reading Judgement By Picture
# CREATE TABLE Reading_Judgement_By_Picture (
#     Reading_Judgement_By_Picture_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Question VARCHAR(255) NOT NULL,      -- Description of the question Like "judge correctness based on the picture"
#     Picture_File_Path INT NOT NULL,     -- Picture_File_Path
#     Answer ENUM ('True', 'False') NOT NULL,    -- Answer
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
#     FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID)
# );
#
# -- Reading Choice the right Picture about the word
# CREATE TABLE Reading_Choice_Right_Picture_About_Word (
#     Reading_Choice_Right_Picture_About_Word_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Picture_File_Path INT NOT NULL,      -- Picture_File_Path
#     Question VARCHAR(255) NOT NULL,      -- Question is a word to describe the picture
#     Answer ENUM ('A', 'B', 'C','D','E','F') NOT NULL,    -- Answer
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Date of creation
#     FOREIGN KEY (Picture_File_Path) REFERENCES Materials(Materials_ID)
# );
#
# -- Reading Choice the right word about the question
# CREATE TABLE Reading_Choice_Right_Answer_About_Question (
#     Reading_Choice_Right_Answer_About_Question_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each question
#     Question VARCHAR(255) NOT NULL,      -- Question is a word ,you need to choose the right choice to answer this question
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Date of creation
# );
#
#
#
# CREATE TABLE Reading_Choice_Right_Answer_About_Question_Answer(
#     Reading_Choice_Right_Answer_About_Question_Answer_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
#     Reading_Choice_Right_Answer_About_Question_ID INT NOT NULL,   -- Unique ID for each question
#     Answer VARCHAR(255) NOT NULL,       -- Answer
#     is_correct ENUM ('True', 'False') NOT NULL,   -- is correct
#     FOREIGN KEY (Reading_Choice_Right_Answer_About_Question_ID) REFERENCES Reading_Choice_Right_Answer_About_Question(Reading_Choice_Right_Answer_About_Question_ID)
# );
#
#
# CREATE TABLE Reading_Choice_Right_Answer_About_Text(
#     Reading_Choice_Right_Answer_About_Text_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
#     Text VARCHAR(255) NOT NULL,       -- Text
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level
#     DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Date of creation
# );
#
# CREATE TABLE Reading_Choice_Right_Answer_About_Text_Question(
#     Reading_Choice_Right_Answer_About_Text_Question_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
#     Reading_Choice_Right_Answer_About_Text_ID INT NOT NULL,   -- Unique ID for each question
#     Question VARCHAR(255) NOT NULL,       -- Question
#     FOREIGN KEY (Reading_Choice_Right_Answer_About_Text_ID) REFERENCES Reading_Choice_Right_Answer_About_Text(Reading_Choice_Right_Answer_About_Text_ID)
# );
#
# CREATE TABLE Reading_Choice_Right_Answer_About_Text_Question_Answer(
#     Reading_Choice_Right_Answer_About_Text_Question_Answer_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
#     Reading_Choice_Right_Answer_About_Text_Question_ID INT NOT NULL,   -- Unique ID for each question
#     Answer VARCHAR(255) NOT NULL,       -- Answer
#     is_correct ENUM ('True', 'False') NOT NULL,   -- is correct
#     FOREIGN KEY (Reading_Choice_Right_Answer_About_Text_Question_ID) REFERENCES Reading_Choice_Right_Answer_About_Text_Question(Reading_Choice_Right_Answer_About_Text_Question_ID)
# );
#
# CREATE TABLE Test (
#     Test_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID
#     Title VARCHAR(255) NOT NULL, -- Test title
#     Type ENUM ('Reading', 'Listen') NOT NULL, -- Test type
#     Level ENUM ('HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5', 'HSK6') NOT NULL, -- HSK level of the test
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Creation date
# );
#
#
# -- Table for associating the type of questions as "Listening_Judgement_By_Picture"
# CREATE TABLE Test_Listening_Judgement_By_Picture (
#     Test_ID INT NOT NULL, -- Test ID
#     Listening_Judgement_By_Picture_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Listening_Judgement_By_Picture_ID) REFERENCES Listening_Judgement_By_Picture(Listening_Judgement_By_Picture_ID)
# );
#
# -- Table for associating the question type as "Listening_Choice_By_Picture"
# CREATE TABLE Test_Listening_Choice_By_Picture (
#     Test_ID INT NOT NULL, -- Test ID
#     Listening_Choice_By_Picture_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Listening_Choice_By_Picture_ID) REFERENCES Listening_Choice_By_Picture(Listening_Choice_By_Picture_ID)
# );
#
# -- Table for associating the question type as "Listening_Choice_Right_Word"
# CREATE TABLE Test_Listen_Choice_Right_Word (
#     Test_ID INT NOT NULL, -- Test ID
#     Listen_Choice_Right_Word_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Listen_Choice_Right_Word_ID) REFERENCES Listen_Choice_Right_Word(Listen_Choice_Right_Word_ID)
# );
#
# -- Table for associating the question type as "Reading_Judgement_By_Picture"
# CREATE TABLE Test_Reading_Judgement_By_Picture (
#     Test_ID INT NOT NULL, -- Test ID
#     Reading_Judgement_By_Picture_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Reading_Judgement_By_Picture_ID) REFERENCES Reading_Judgement_By_Picture(Reading_Judgement_By_Picture_ID)
# );
#
# -- Table for associating the question type as "Reading_Choice_Right_Picture_About_Word"
# CREATE TABLE Test_Reading_Choice_Right_Picture_About_Word (
#     Test_ID INT NOT NULL, -- Test ID
#     Reading_Choice_Right_Picture_About_Word_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Reading_Choice_Right_Picture_About_Word_ID) REFERENCES Reading_Choice_Right_Picture_About_Word(Reading_Choice_Right_Picture_About_Word_ID)
# );
#
# -- Table for associating the question type as "Reading_Choice_Right_Answer_About_Question"
# CREATE TABLE Test_Reading_Choice_Right_Answer_About_Question (
#     Test_ID INT NOT NULL, -- Test ID
#     Reading_Choice_Right_Answer_About_Question_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Reading_Choice_Right_Answer_About_Question_ID) REFERENCES Reading_Choice_Right_Answer_About_Question(Reading_Choice_Right_Answer_About_Question_ID)
# );
#
# -- Table for associating the question type as "Reading_Choice_Right_Answer_About_Text"
# CREATE TABLE Test_Reading_Choice_Right_Answer_About_Text (
#     Test_ID INT NOT NULL, -- Test ID
#     Reading_Choice_Right_Answer_About_Text_ID INT NOT NULL, -- Question ID
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (Reading_Choice_Right_Answer_About_Text_ID) REFERENCES Reading_Choice_Right_Answer_About_Text(Reading_Choice_Right_Answer_About_Text_ID)
# );
#
# CREATE TABLE Score (
#     Score_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID
#     Test_ID INT NOT NULL, -- Test ID
#     User_ID INT NOT NULL, -- User ID
#     Score INT NOT NULL, -- Score
#     Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Test date
#     FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
#     FOREIGN KEY (User_ID) REFERENCES Users(Id)
# );

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
    text           VARCHAR(255)    ,  -- Text of the unit
    text_description LONGTEXT  ,  -- Text description
    FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id) -- Set subject_id as foreign key from table Subjects's subject_id
);

CREATE TABLE  student_units (
    student_unit_id     INT AUTO_INCREMENT PRIMARY KEY,
    student_id          INT NOT NULL,
    unit_id             INT NOT NULL,
    isFinished            BOOLEAN NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student_user (id),
    FOREIGN KEY (unit_id) REFERENCES Units (unit_id)
);


-- CREATE TABLE question_types to types of questions
-- reading, listening, writing, speaking
CREATE TABLE question_types (
    question_type_id    INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question type
    question_type       VARCHAR(255) NOT NULL -- Question type
);

-- CREATE TABLE questions to store information about all questions
# https://examenes.cervantes.es/es/dele/preparar-prueba
# https://mandarinbean.com/hsk-chinese-test-online/
CREATE TABLE questions (
    question_id         INT             AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each question
    question            VARCHAR(255)    NOT NULL, -- Contents of the question
    question_type_id    INT             NOT NULL, -- ID of the question type
    picture_path        VARCHAR(255), -- Path to the picture
    video_path          VARCHAR(255), -- Path to the video
    audio_path          VARCHAR(255), -- Path to the audio
    question_order      INT             NOT NULL, -- Order of the question
    explanation         VARCHAR(255)    NOT NULL, -- Explanation of the question
    description         VARCHAR(255) NOT NULL, -- Description of the question
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

-- CREATE TABLE options to store information about all options
CREATE TABLE options (
    option_id       INT             AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each option
    question_id     INT             NOT NULL, -- ID of the question
    `option`        VARCHAR(255)    NOT NULL, -- Contents of the option
    is_correct      BOOLEAN         NOT NULL, -- Whether the option is correct
    order_number    INT             NOT NULL, -- Order of the option
    description     VARCHAR(255)    NOT NULL, -- Description of the option
    FOREIGN KEY (question_id) REFERENCES questions (question_id) -- Set question_id as foreign key from table questions's question_id
);

-- ALTER TABLE options ADD COLUMN description VARCHAR(255) AFTER order_number;


-- CREATE TABLE record to store information about all records
create table record (
    record_id   INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each record
    student_id  INT NOT NULL, -- ID of the student
    question_id INT NOT NULL, -- ID of the question
    option_id   INT NOT NULL, -- ID of the option
    FOREIGN KEY (student_id) REFERENCES student_user (id), -- Set student_id as foreign key from table student_user's id
    FOREIGN KEY (question_id) REFERENCES questions (question_id), -- Set question_id as foreign key from table questions's question_id
    FOREIGN KEY (option_id) REFERENCES options (option_id) -- Set option_id as foreign key from table options's option_id
);



CREATE TABLE learning_style(
    learning_style_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id          INT NOT NULL UNIQUE,
    activist              INT NOT NULL,
    reflector             INT NOT NULL,
    theorist              INT NOT NULL,
    pragmatist            INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student_user (id)
);

CREATE TABLE comments(
    comment_id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id          INT NOT NULL,
    question_id         INT NOT NULL,
    comment             VARCHAR(255) NOT NULL,
    time                TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    likes               INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student_user (id),
    FOREIGN KEY (question_id) REFERENCES questions (question_id)
);




# insert data into student_user
INSERT INTO `student_user` (`id`, `username`, `password`, `email`) VALUES (1, 'test1', 'password1', 'test1@gmail.com');
INSERT INTO `student_user` (`id`, `username`, `password`, `email`) VALUES (2, 'test2', 'password2', 'test2@gmail.com');
INSERT INTO `student_user` (`id`, `username`, `password`, `email`) VALUES (3, 'test3', 'password3', 'test3@gmail.com');
INSERT INTO `student_user` (`id`, `username`, `password`, `email`) VALUES (4, 'test4', 'password4', 'test4@gmail.com');
INSERT INTO `student_user` (`id`, `username`, `password`, `email`) VALUES (5, 'test5', 'password5', 'test5@gmail.com');


# insert data into Subjects
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (1, 'English', 'Beginner', 'Beginner English');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (2, 'English', 'Intermediate', 'Intermediate English');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (3, 'English', 'Advanced', 'Advanced English');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (4, 'Mandarin', 'Beginner', 'Beginner Mandarin');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (5, 'Mandarin', 'Intermediate', 'Intermediate Mandarin');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (6, 'Mandarin', 'Advanced', 'Advanced Mandarin');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (7, 'Spanish', 'Beginner', 'Beginner Spanish');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (8, 'Spanish', 'Intermediate', 'Intermediate Spanish');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (9, 'Spanish', 'Advanced', 'Advanced Spanish');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (10, 'French', 'Beginner', 'Beginner French');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (11, 'French', 'Intermediate', 'Intermediate French');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (12, 'French', 'Advanced', 'Advanced French');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (13, 'Italian', 'Beginner', 'Beginner Italian');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (14, 'Italian', 'Intermediate', 'Intermediate Italian');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (15, 'Italian', 'Advanced', 'Advanced Italian');


# insert data into Units
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (1, 'Beginner English Unit 1', 1, 1, 'the 1st unit of Beginner English ', 'https://www.youtube-nocookie.com/embed/um3YrKRfsr0', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (2, 'Beginner English Unit 2', 1, 2, 'the 2nd unit of Beginner English ', 'https://www.youtube.com/embed/oFT45Oq7X9k', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (3, 'Beginner English Unit 3', 1, 3, 'the 3rd unit of Beginner English ', 'https://www.youtube.com/embed/KQt3jVyME-k', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (4, 'Beginner English Unit 4', 1, 4, 'the 4th unit of Beginner English ', 'https://www.youtube.com/embed/dNP6L6y7ZEM', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (5, 'Beginner English Unit 5', 1, 5, 'the 5th unit of Beginner English ', 'https://www.youtube.com/embed/jhzj9D73SZw', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (6, 'Intermediate English Unit 1', 2, 1, 'the 1st unit of Intermediate English ', 'https://www.youtube.com/embed/jul2urONzOQ', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (7, 'Intermediate English Unit 2', 2, 2, 'the 2nd unit of Intermediate English ', 'https://www.youtube.com/embed/56Gsym70j-A', 'https://tomatolearning.s3.amazonaws.com/test/unit6.png', '<p>Purchase a 12 month subscription to Vacation the Nation today and receive a free pair of Sunnies Sunglasses with your very own soft leather case.*</p>
<p>To get your free Sunnies, follow these 3 easy steps:</p>
<ol>
  <li>Purchase a copy of Vacation the Nation, New York\'s #1 Travel magazine.</li>
  <li>Fill out the application card (found in the center of the magazine).</li>
  <li>Mail the card and $21.95 US to the address provided.</li>
</ol>
<p>*This is a limited time offer only. Application and funds must be received no later than Dec 1st, 2004. Canadian residents should add $3 US for shipping. Offer not available for residents outside of North America.</p>');
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (8, 'Intermediate English Unit 3', 2, 3, 'the 3rd unit of Intermediate English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (9, 'Intermediate English Unit 4', 2, 4, 'the 4th unit of Intermediate English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (10, 'Intermediate English Unit 5', 2, 5, 'the 5th unit of Intermediate English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (11, 'Advanced English Unit 1', 3, 1, 'the 1st unit of Advanced English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (12, 'Advanced English Unit 2', 3, 2, 'the 2nd unit of Advanced English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (13, 'Advanced English Unit 3', 3, 3, 'the 3rd unit of Advanced English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (14, 'Advanced English Unit 4', 3, 4, 'the 4th unit of Advanced English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (15, 'Advanced English Unit 5', 3, 5, 'the 5th unit of Advanced English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (16, 'Beginner Mandarin Unit 1', 4, 1, 'the 1st unit of Beginner Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (17, 'Beginner Mandarin Unit 2', 4, 2, 'the 2nd unit of Beginner Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (18, 'Beginner Mandarin Unit 3', 4, 3, 'the 3rd unit of Beginner Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (19, 'Beginner Mandarin Unit 4', 4, 4, 'the 4th unit of Beginner Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (20, 'Beginner Mandarin Unit 5', 4, 5, 'the 5th unit of Beginner Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (21, 'Intermediate Mandarin Unit 1', 5, 1, 'the 1st unit of Intermediate Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (22, 'Intermediate Mandarin Unit 2', 5, 2, 'the 2nd unit of Intermediate Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (23, 'Intermediate Mandarin Unit 3', 5, 3, 'the 3rd unit of Intermediate Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (24, 'Intermediate Mandarin Unit 4', 5, 4, 'the 4th unit of Intermediate Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (25, 'Intermediate Mandarin Unit 5', 5, 5, 'the 5th unit of Intermediate Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (26, 'Advanced Mandarin Unit 1', 6, 1, 'the 1st unit of Advanced Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (27, 'Advanced Mandarin Unit 2', 6, 2, 'the 2nd unit of Advanced Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (28, 'Advanced Mandarin Unit 3', 6, 3, 'the 3rd unit of Advanced Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (29, 'Advanced Mandarin Unit 4', 6, 4, 'the 4th unit of Advanced Mandarin ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (30, 'Advanced Mandarin Unit 5', 6, 5, 'the 5th unit of Advanced Mandarin ', 'None', NULL, NULL);
INSERT INTO test.Units (unit_id, unit_name, subject_id, Units_order, description, materials_path, text, text_description) VALUES (31, 'Beginner Spanish Unit 1', 7, 1, 'the 1st unit of Beginner Spanish ', 'https://www.youtube.com/embed/1gTQRu2Weo4', null, null);
INSERT INTO test.Units (unit_id, unit_name, subject_id, Units_order, description, materials_path, text, text_description) VALUES (32, 'Beginner Spanish Unit 2', 7, 2, 'the 2nd unit of Beginner Spanish ', 'https://www.youtube.com/embed/McR7pDWlnJo', null, null);
INSERT INTO test.Units (unit_id, unit_name, subject_id, Units_order, description, materials_path, text, text_description) VALUES (33, 'Beginner Spanish Unit 3', 7, 3, 'the 3rd unit of Beginner Spanish ', 'https://www.youtube.com/embed/dOhtVXr05Gc', null, null);
INSERT INTO test.Units (unit_id, unit_name, subject_id, Units_order, description, materials_path, text, text_description) VALUES (34, 'Beginner Spanish Unit 4', 7, 4, 'the 4th unit of Beginner Spanish ', 'https://www.youtube.com/embed/kGYk2ka5IT0', null, null);
INSERT INTO test.Units (unit_id, unit_name, subject_id, Units_order, description, materials_path, text, text_description) VALUES (35, 'Beginner Spanish Unit 5', 7, 5, 'the 5th unit of Beginner Spanish ', 'https://www.youtube.com/embed/yd0Rer55J2c', null, null);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (36, 'Intermediate Spanish Unit 1', 8, 1, 'the 1st unit of Intermediate Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (37, 'Intermediate Spanish Unit 2', 8, 2, 'the 2nd unit of Intermediate Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (38, 'Intermediate Spanish Unit 3', 8, 3, 'the 3rd unit of Intermediate Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (39, 'Intermediate Spanish Unit 4', 8, 4, 'the 4th unit of Intermediate Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (40, 'Intermediate Spanish Unit 5', 8, 5, 'the 5th unit of Intermediate Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (41, 'Advanced Spanish Unit 1', 9, 1, 'the 1st unit of Advanced Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (42, 'Advanced Spanish Unit 2', 9, 2, 'the 2nd unit of Advanced Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (43, 'Advanced Spanish Unit 3', 9, 3, 'the 3rd unit of Advanced Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (44, 'Advanced Spanish Unit 4', 9, 4, 'the 4th unit of Advanced Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (45, 'Advanced Spanish Unit 5', 9, 5, 'the 5th unit of Advanced Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (46, 'Beginner French Unit 1', 10, 1, 'the 1st unit of Beginner French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (47, 'Beginner French Unit 2', 10, 2, 'the 2nd unit of Beginner French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (48, 'Beginner French Unit 3', 10, 3, 'the 3rd unit of Beginner French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (49, 'Beginner French Unit 4', 10, 4, 'the 4th unit of Beginner French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (50, 'Beginner French Unit 5', 10, 5, 'the 5th unit of Beginner French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (51, 'Intermediate French Unit 1', 11, 1, 'the 1st unit of Intermediate French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (52, 'Intermediate French Unit 2', 11, 2, 'the 2nd unit of Intermediate French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (53, 'Intermediate French Unit 3', 11, 3, 'the 3rd unit of Intermediate French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (54, 'Intermediate French Unit 4', 11, 4, 'the 4th unit of Intermediate French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (55, 'Intermediate French Unit 5', 11, 5, 'the 5th unit of Intermediate French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (56, 'Advanced French Unit 1', 12, 1, 'the 1st unit of Advanced French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (57, 'Advanced French Unit 2', 12, 2, 'the 2nd unit of Advanced French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (58, 'Advanced French Unit 3', 12, 3, 'the 3rd unit of Advanced French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (59, 'Advanced French Unit 4', 12, 4, 'the 4th unit of Advanced French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (60, 'Advanced French Unit 5', 12, 5, 'the 5th unit of Advanced French ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (61, 'Beginner Italian Unit 1', 13, 1, 'the 1st unit of Beginner Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (62, 'Beginner Italian Unit 2', 13, 2, 'the 2nd unit of Beginner Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (63, 'Beginner Italian Unit 3', 13, 3, 'the 3rd unit of Beginner Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (64, 'Beginner Italian Unit 4', 13, 4, 'the 4th unit of Beginner Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (65, 'Beginner Italian Unit 5', 13, 5, 'the 5th unit of Beginner Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (66, 'Intermediate Italian Unit 1', 14, 1, 'the 1st unit of Intermediate Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (67, 'Intermediate Italian Unit 2', 14, 2, 'the 2nd unit of Intermediate Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (68, 'Intermediate Italian Unit 3', 14, 3, 'the 3rd unit of Intermediate Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (69, 'Intermediate Italian Unit 4', 14, 4, 'the 4th unit of Intermediate Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (70, 'Intermediate Italian Unit 5', 14, 5, 'the 5th unit of Intermediate Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (71, 'Advanced Italian Unit 1', 15, 1, 'the 1st unit of Advanced Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (72, 'Advanced Italian Unit 2', 15, 2, 'the 2nd unit of Advanced Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (73, 'Advanced Italian Unit 3', 15, 3, 'the 3rd unit of Advanced Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (74, 'Advanced Italian Unit 4', 15, 4, 'the 4th unit of Advanced Italian ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (75, 'Advanced Italian Unit 5', 15, 5, 'the 5th unit of Advanced Italian ', 'None', NULL, NULL);

# insert into question_types table
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (1, 'text_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (2, 'text_picture');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (3, 'picture_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (4, 'audio_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (5, 'audio_picture');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (6, 'multi_text_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (7, 'multi_text_picture');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (8, 'multi_picture_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (9, 'multi_audio_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (10, 'multi_audio_picture');

# insert into questions table
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (1, 'What\'s the CAPITAL letter for "t"? ', 1, null, null, null, 1, 'The capital letter for "t" is "T"', 'What\'s the CAPITAL letter for "t"? ');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (2, 'What\'s the LOWERCASE letter for "R"? ', 2, null, null, null, 2, 'The lowercase letter for "R" is "r."', 'What\'s the LOWERCASE letter for "R"? ');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (3, 'What\'s the LOWERCASE letter for the alphabet shown below?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/D.png', null, null, 3, 'The lowercase letter for "D" is "d."', 'What\'s the CAPITAL letter for the alphabet shown below?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (4, 'What letter is in the audio?', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/g.mp3', 4, 'The audio plays the pronounciation of  letter "G/g".', 'The audio plays the pronounciation of  letter "G/g".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (5, 'What\'s the LOWERCASE letter for "Q" and "H"? ', 6, null, null, null, 5, 'The lowercase letters for "Q" and "H" are "q" and "h," respectively.', 'What\'s the LOWERCASE letter for "Q" and "H"? ');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (6, 'What color is shown in the picture below?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/yellow.png', null, null, 1, '"yellow"', 'It\'s a yellow picture.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (7, 'What color snow is?', 1, null, null, null, 2, '"white"', 'What color snow is?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (8, 'Choose what you hear.', 5, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/pink.mp3', 3, '"pink"', 'The audio plays "pink".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (9, 'Choose what you hear.', 10, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/blue_purple.mp3', 4, '"blue" "purple"', 'The audio plays "red and blue make purple".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (10, 'Choose the option(s) that describes the picture.', 8, 'https://tomatolearning.s3.amazonaws.com/picture/apple.png', null, null, 5, '"red" "apple" "green" "brown"', 'It\'s a picture of apple, there are red, green and brown color in the picture.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (11, 'What animals are in this picture?', 8, 'https://tomatolearning.s3.amazonaws.com/picture/dog_cat.png', null, null, 1, '"dog" and "cat"', 'It\'s a picture of dog and cat.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (12, 'Choose what you hear.', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/bear.mp3', 2, '"bear"', '"Bear" is shown in the video.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (13, 'What animals live under water?', 6, null, null, null, 3, '"shark" "octopus"', '"Shark" and "octopus" live under water.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (14, 'What animal is it in the picture?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/sheep.png', null, null, 4, '"sheep"', 'It\'s a picture of sheep.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (15, 'What animals are in the audio?', 9, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/giraffe_gorilla.mp3', 5, '"giraffe" "gorilla"', 'The audio plays "giraffe" and "gorilla".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (16, 'How to spell 23?', 1, null, null, null, 1, '"twenty-three"', 'The number "23" is spelled as "twenty-three."');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (17, 'What number is in the audio?', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/57.mp3', 2, '"57"', 'The audio plays "57".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (18, 'Choose the number(s) smaller than the number in the audio.', 9, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/39.mp3', 3, 'choose number smaller than 39', 'Choose the number(s) smaller than "39" which is played in the audio.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (19, 'Choose which is "Zero"', 1, null, null, null, 4, '"0"', '0 is "Zero".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (20, 'How to spell 100?', 1, null, null, null, 5, '"one hundred"', 'The number "100" is spelled as "one hundred."');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (21, 'What day comes right after Tuesday?', 1, null, null, null, 1, 'Wednesday', 'The day that comes after Tuesday is Wednesday.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (22, 'What\'s the last month of a year?', 1, null, null, null, 2, 'December', 'What\'s the last month of a year?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (23, 'What months come after May in a year?', 6, null, null, null, 3, 'June, July', 'What month comes after May in a year?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (24, 'Choose what day is it.', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/Thursday.mp3', 4, 'Thursday', 'The audio plays "Thursday".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (25, 'Choose what month is it.', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/November.mp3', 5, 'November', 'The audio plays "November".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (26, 'She ______ dogs.', 1, null, null, null, 1, 'She "likes" dogs.', 'she ____ dogs.
there are four options: is, are, like and likes.

which one is correct and explain why');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (27, 'Adam loves to _____ to music while running. ', 1, null, null, null, 2, 'Adam loves to listen to music while running. ', 'Adam loves to _____ to music while running.

there are four options: listen, listens, listening and listened.

which one is correct and explain why');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (28, 'Choose sentence(s) applied to the picture.', 8, 'https://tomatolearning.s3.amazonaws.com/picture/mother_baby.png', null, null, 3, 'A women is holding a baby on the beach and the weather is nice.', 'It\'s a picture of a women holding a baby on the beach and the weather is nice.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (29, 'Choose the option(s) corresponding to the description: He goes hiking every weekend.', 7, null, null, null, 4, '(B): he, (C) hike', 'Choose the option(s) corresponding to the description: He goes hiking every weekend.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (30, 'Choose the option(s) corresponding to the audio.', 10, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/she_strawberry.mp3', 5, '(A): strawberry, (D): she', 'Choose the option(s) corresponding to the audio: She likes strawberries, but she hardly ever eats them.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (31, 'What is this advertisement for?', 1, null, null, null, 1, 'C', 'What is this advertisement for?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (32, 'How much do the sunglasses cost?', 1, null, null, null, 2, 'A', 'How much do the sunglasses cost?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (33, 'Who cannot benefit from this special deal?', 1, null, null, null, 3, 'B', 'Who cannot benefit from this special deal?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (34, 'Choose the picture of sunglasses.', 2, null, null, null, 4, 'B', 'Choose the picture of sunglasses.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (35, 'Bob purchased a subscription to this on 3rd Oct, 2004. Which date is the subcription no longer valid?', 1, null, null, null, 5, 'B', 'The subscription starts on 3rd October and is valid for 12 months. Give me the expiration date and the order of month in a year.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (36, '"Table" in Spanish', 1, null, null, null, 1, 'A table in Spanish is called "mesa."', 'Table in Spanish?
A) Metal
B) Mesa
C) Meta
D) Melodía
and explain why');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (37, 'Choose what you hear.', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/spanish_g.mp3', 2, 'Audio of "g" in spanish.', 'It\'s an audio of "g" in spanish. ');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (38, 'What\'s in this picture?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/bread.jpeg', null, null, 3, 'This is a picture of "bread", "bread" in Spanish is "pan"', '"Choose \'bread\' in Spanish":

A) Pan
B) Peso
C) Perro
D) Piso
and explain why');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (39, 'Choose what you hear.', 5, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/spanish_ll.mp3', 4, 'Audio of "LL" in spanish.', 'It\'s an audio of "ll" in spanish. ');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (40, 'Choose what you hear.', 4, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/spanish_ch.mp3', 5, 'Audio of "ch" in spanish.', 'It\'s an audio of "ch" in spanish. ');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (41, 'What color is shown in the picture below?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/yellow.png', null, null, 1, '"amarillo"', 'It\'s a yellow picture.');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (42, 'What color snow is?', 1, null, null, null, 2, '"white"', 'What color snow is?');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (43, 'Choose what you hear.', 5, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/pink.mp3', 3, '"pink"', 'The audio plays "pink".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (44, 'Choose what you hear.', 10, null, null, 'https://tomatolearning.s3.amazonaws.com/audio/blue_purple.mp3', 4, '"blue" "purple"', 'The audio plays "red and blue make purple".');
INSERT INTO test.questions (question_id, question, question_type_id, picture_path, video_path, audio_path, question_order, explanation, description) VALUES (45, 'Choose the option(s) that describes the picture.', 8, 'https://tomatolearning.s3.amazonaws.com/picture/apple.png', null, null, 5, '"red" "apple" "green" "brown"', 'It\'s a picture of apple, there are red, green and brown color in the picture.');




# insert into questions_units table
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (1, 1, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (2, 2, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (3, 3, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (4, 4, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (5, 5, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (6, 6, 2);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (7, 7, 2);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (8, 8, 2);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (9, 9, 2);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (10, 10, 2);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (11, 11, 3);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (12, 12, 3);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (13, 13, 3);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (14, 14, 3);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (15, 15, 3);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (16, 16, 4);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (17, 17, 4);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (18, 18, 4);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (19, 19, 4);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (20, 20, 4);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (21, 21, 5);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (22, 22, 5);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (23, 23, 5);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (24, 24, 5);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (25, 25, 5);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (26, 26, 6);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (27, 27, 6);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (28, 28, 6);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (29, 29, 6);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (30, 30, 6);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (31, 31, 7);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (32, 32, 7);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (33, 33, 7);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (34, 34, 7);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (35, 35, 7);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (36, 36, 31);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (37, 37, 31);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (38, 38, 31);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (39, 39, 31);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (40, 40, 31);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (41, 41, 32);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (42, 42, 32);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (43, 43, 32);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (44, 44, 32);
INSERT INTO test.question_units (question_unit_id, question_id, unit_id) VALUES (45, 45, 32);




# insert data into options table

INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (1, 1, 'I', 0, 1, 'letter \"I/i\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (2, 1, 'T', 1, 2, 'letter \"T/t\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (3, 1, 'L', 0, 3, 'letter \"L/l\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (4, 1, 'F', 0, 4, 'letter \"F/f\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (5, 2, 'https://tomatolearning.s3.amazonaws.com/option/h.png', 0, 1, 'a picture of letter \"h\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (6, 2, 'https://tomatolearning.s3.amazonaws.com/option/e.png', 0, 2, 'a picture of letter \"e\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (7, 2, 'https://tomatolearning.s3.amazonaws.com/option/r.png', 1, 3, 'a picture of letter \"r\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (8, 2, 'https://tomatolearning.s3.amazonaws.com/option/q.png', 0, 4, 'a picture of letter \"q\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (9, 3, 'a', 0, 1, 'letter \"A/a\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (10, 3, 'o', 0, 2, 'letter \"O/o\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (11, 3, 'c', 0, 3, 'letter \"C/c\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (12, 3, 'd', 1, 4, 'letter \"D/d\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (13, 4, 'B/b', 0, 1, 'letter \"B/b\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (14, 4, 'V/v', 0, 2, 'letter \"V/v\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (15, 4, 'G/g', 1, 3, 'letter \"G/g\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (16, 4, 'Y/y', 0, 4, 'letter \"Y/y\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (17, 5, 'q', 1, 1, 'letter \"Q\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (18, 5, 'r', 0, 2, 'letter \"r\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (19, 5, 'p', 0, 3, 'letter \"p\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (20, 5, 'h', 1, 4, 'letter \"h\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (21, 6, 'yellow', 1, 1, 'yellow');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (22, 6, 'red', 0, 2, 'red');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (23, 6, 'purple', 0, 3, 'purple');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (24, 6, 'green', 0, 4, 'green');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (25, 7, 'black', 0, 1, 'black');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (26, 7, 'pink', 0, 2, 'pink');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (27, 7, 'white', 1, 3, 'white');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (28, 7, 'blue', 0, 4, 'blue');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (29, 8, 'https://tomatolearning.s3.amazonaws.com/option/orange.png', 0, 1, 'this is an orange picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (30, 8, 'https://tomatolearning.s3.amazonaws.com/option/purple.png', 0, 2, 'this is a purple picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (31, 8, 'https://tomatolearning.s3.amazonaws.com/option/pink.png', 1, 3, 'this is a pink picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (32, 8, 'https://tomatolearning.s3.amazonaws.com/option/blue.png', 0, 4, 'this is a blue picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (33, 9, 'https://tomatolearning.s3.amazonaws.com/option/orange.png', 0, 1, 'this is an orange picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (34, 9, 'https://tomatolearning.s3.amazonaws.com/option/purple.png', 1, 2, 'this is a purple picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (35, 9, 'https://tomatolearning.s3.amazonaws.com/option/pink.png', 0, 3, 'this is a pink picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (36, 9, 'https://tomatolearning.s3.amazonaws.com/option/blue.png', 1, 4, 'this is a blue picture');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (37, 10, 'green', 1, 1, 'green');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (38, 10, 'brown', 1, 2, 'brown');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (39, 10, 'apple', 1, 3, 'apple');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (40, 10, 'red', 1, 4, 'red');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (41, 11, 'rabbit', 0, 1, 'rabbit');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (42, 11, 'cat', 1, 2, 'cat');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (43, 11, 'dog', 1, 3, 'dog');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (44, 11, 'wolf', 0, 4, 'wolf');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (45, 12, 'fish', 0, 1, 'fish');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (46, 12, 'cat', 0, 2, 'cat');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (47, 12, 'horse', 0, 3, 'horse');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (48, 12, 'bear', 1, 4, 'bear');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (49, 13, 'shark', 1, 1, 'shark');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (50, 13, 'octopus', 1, 2, 'octopus');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (51, 13, 'tiger', 0, 3, 'tiger');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (52, 13, 'snake', 0, 4, 'snake');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (53, 14, 'cow', 0, 1, 'cow');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (54, 14, 'chicken', 0, 2, 'chicken');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (55, 14, 'sheep', 1, 3, 'sheep');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (56, 14, 'dolphin', 0, 4, 'dolphin');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (57, 15, 'goat', 0, 1, 'goat');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (58, 15, 'gorilla', 1, 2, 'gorilla');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (59, 15, 'goose', 0, 3, 'goose');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (60, 15, 'giraffe', 1, 4, 'giraffe');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (61, 16, 'twenty-tree', 0, 1, 'wrong spelling of 3 - should be \"three\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (62, 16, 'twenty-three', 1, 2, '\"23\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (63, 16, 'tewny-six', 0, 3, 'wrong spelling of 20 - should be \"twenty\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (64, 16, 'twenty-six', 0, 4, 'this is \"26\", not \"23\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (65, 17, '57', 1, 1, '57');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (66, 17, '45', 0, 2, '45');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (67, 17, '67', 0, 3, '67');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (68, 17, '47', 0, 4, '47');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (69, 18, '35', 1, 1, '35');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (70, 18, '48', 0, 2, '48');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (71, 18, '25', 1, 3, '25');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (72, 18, '58', 0, 4, '58');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (73, 19, '3', 0, 1, '3');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (74, 19, '5', 0, 2, '5');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (75, 19, '0', 1, 3, '0');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (76, 19, '8', 0, 4, '8');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (77, 20, 'one hundrad', 0, 1, 'wrong spelling');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (78, 20, 'one hudred', 0, 2, 'wrong spelling');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (79, 20, 'one hundroed', 0, 3, 'wrong spelling');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (80, 20, 'one hundred', 1, 4, 'correct spelling');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (81, 21, 'Wednesday', 1, 1, 'The day that comes right after Tuesday is Wednesday.');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (82, 21, 'Thursday', 0, 2, 'Thursday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (83, 21, 'Monday', 0, 3, 'Monday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (84, 21, 'Sunday', 0, 4, 'Sunday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (85, 22, 'January', 0, 1, 'January');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (86, 22, 'December', 1, 2, 'December');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (87, 22, 'September', 0, 3, 'September');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (88, 22, 'October', 0, 4, 'October');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (89, 23, 'July', 1, 1, 'July');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (90, 23, 'June', 1, 2, 'June');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (91, 23, 'March', 0, 3, 'March');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (92, 23, 'April', 0, 4, 'April');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (93, 24, 'Friday', 0, 1, 'Friday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (94, 24, 'Saturday', 0, 2, 'Saturday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (95, 24, 'Thursday', 1, 3, 'Thursday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (96, 24, 'Tuesday', 0, 4, 'Tuesday');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (97, 25, 'December', 0, 1, 'December');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (98, 25, 'October', 0, 2, 'October');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (99, 25, 'November', 1, 3, 'November');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (100, 25, 'September', 0, 4, 'September');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (101, 26, 'is', 0, 1, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (102, 26, 'are', 0, 2, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (103, 26, 'like', 0, 3, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (104, 26, 'likes', 1, 4, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (105, 27, 'listen', 1, 1, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (106, 27, 'listens', 0, 2, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (107, 27, 'listening', 0, 3, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (108, 27, 'listened', 0, 4, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (109, 28, 'They\'re on the beach.', 1, 1, '1');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (110, 28, 'The baby is crying.', 0, 2, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (111, 28, 'A woman is holding a baby.', 1, 3, '1');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (112, 28, 'It\'s raining.', 0, 4, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (113, 29, 'https://tomatolearning.s3.amazonaws.com/option/hockey.jpeg', 0, 1, 'it\'s hockey');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (114, 29, 'https://tomatolearning.s3.amazonaws.com/option/he.jpeg', 1, 2, 'it\'s a picture of a man, could represent \"he\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (115, 29, 'https://tomatolearning.s3.amazonaws.com/option/hike.jpeg', 1, 3, 'it\'s a picture of \"hike/hiking\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (116, 29, 'https://tomatolearning.s3.amazonaws.com/option/sofa.jpeg', 0, 4, 'it\'s a sofa');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (117, 30, 'https://tomatolearning.s3.amazonaws.com/option/strawberry.jpeg', 1, 1, 'picture of strawberry');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (118, 30, 'https://tomatolearning.s3.amazonaws.com/option/lemon.jpeg', 0, 2, 'lemon');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (119, 30, 'https://tomatolearning.s3.amazonaws.com/option/carrot.jpeg', 0, 3, 'carrot');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (120, 30, 'https://tomatolearning.s3.amazonaws.com/option/she.jpeg', 1, 4, 'it\'s a picture of a woman, could represent \"she\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (121, 31, 'A summer trip.', 0, 1, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (122, 31, 'A travel company.', 0, 2, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (123, 31, 'A special deal.', 1, 3, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (124, 31, 'A free magazine.', 0, 4, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (125, 32, 'They are free with a subscription.', 1, 1, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (126, 32, 'They cost $1.', 0, 2, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (127, 32, 'They cost $3 Canadian.', 0, 3, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (128, 32, 'They cost $21. 95 US.', 0, 4, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (129, 33, 'Canadians.', 0, 1, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (130, 33, 'UK residents.', 1, 2, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (131, 33, 'North Americans.', 0, 3, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (132, 33, 'US residents.', 0, 4, 'not true');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (133, 34, 'https://tomatolearning.s3.amazonaws.com/option/sun.jpeg', 0, 1, 'a picture of sun');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (134, 34, 'https://tomatolearning.s3.amazonaws.com/option/sunglasses.jpeg', 1, 2, 'a picture of sunglasses');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (135, 34, 'https://tomatolearning.s3.amazonaws.com/option/glasses.jpeg', 0, 3, 'a picture of glasses');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (136, 34, 'https://tomatolearning.s3.amazonaws.com/option/cone.jpeg', 0, 4, 'a picture of cone');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (137, 35, '12th Aug', 0, 1, '12th Aug');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (138, 35, '11th Nov', 1, 2, '11th Nov');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (139, 35, '23rd Apr', 0, 3, '23rd Apr');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (140, 35, '7th May', 0, 4, '7th May');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (141, 36, 'Metal', 0, 1, 'Metal means "material"');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (142, 36, 'Mesa', 1, 2, 'Mesa means "table"');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (143, 36, 'Meta', 0, 3, 'Meta means "goal" or "objective');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (144, 36, 'Melodía', 0, 4, 'Melodía means "melody" or "tune"');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (145, 37, 'W/w', 0, 1, 'W/w');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (146, 37, 'H/h', 0, 2, 'H/h');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (147, 37, 'G/g', 1, 3, 'G/g');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (148, 37, 'V/v', 0, 4, 'V/v');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (149, 38, 'Pan', 1, 1, ' "Pan," is the correct translation for "bread" in Spanish.');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (150, 38, 'Peso', 0, 2, '"Peso," means "weight" in Spanish.');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (151, 38, 'Perro', 0, 3, '"Perro," means "dog" in Spanish.');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (152, 38, 'Piso', 0, 4, '"Piso," means "floor" or "apartment" in Spanish.');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (153, 39, 'https://tomatolearning.s3.amazonaws.com/option/spanish_J.png', 0, 1, 'J/j');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (154, 39, 'https://tomatolearning.s3.amazonaws.com/option/spanish_Ñ.png', 0, 2, 'Ñ/ñ');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (155, 39, 'https://tomatolearning.s3.amazonaws.com/option/spanish_L.png', 0, 3, 'L/l');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (156, 39, 'https://tomatolearning.s3.amazonaws.com/option/spanish_LL.png', 1, 4, 'LL/ll');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (157, 40, 'LL/ll', 0, 1, 'LL/ll');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (158, 40, 'CH/ch', 2, 2, 'CH/ch');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (159, 40, 'Ñ/ñ', 0, 3, 'Ñ/ñ');
INSERT INTO test.options (option_id, question_id, `option`, is_correct, order_number, description) VALUES (160, 40, 'J/j', 0, 4, 'J/j');


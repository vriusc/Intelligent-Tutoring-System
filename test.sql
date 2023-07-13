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
    text_description VARCHAR(255)  ,  -- Text description
    FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id) -- Set subject_id as foreign key from table Subjects's subject_id
);

-- ALTER TABLE Units ADD COLUMN text VARCHAR(255) AFTER materials_path;
-- ALTER TABLE Units ADD COLUMN text_description VARCHAR(255) AFTER text;

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
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (1, 'Spanish', 'Beginner', 'Beginner Spanish');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (2, 'Spanish', 'Intermediate', 'Intermediate Spanish');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (3, 'Spanish', 'Advanced', 'Advanced Spanish');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (4, 'Mandarin', 'Beginner', 'Beginner Mandarin');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (5, 'Mandarin', 'Intermediate', 'Intermediate Mandarin');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (6, 'Mandarin', 'Advanced', 'Advanced Mandarin');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (7, 'English', 'Beginner', 'Beginner English');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (8, 'English', 'Intermediate', 'Intermediate English');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (9, 'English', 'Advanced', 'Advanced English');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (10, 'French', 'Beginner', 'Beginner French');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (11, 'French', 'Intermediate', 'Intermediate French');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (12, 'French', 'Advanced', 'Advanced French');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (13, 'Italian', 'Beginner', 'Beginner Italian');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (14, 'Italian', 'Intermediate', 'Intermediate Italian');
INSERT INTO `Subjects` (`subject_id`, `subject_name`, `level`, `description`) VALUES (15, 'Italian', 'Advanced', 'Advanced Italian');


# insert data into Units
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (1, 'Beginner English Unit 1', 1, 1, 'the 1st unit of Beginner English ', 'https://www.youtube.com/embed/7fAJ13DgvYM', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (2, 'Beginner English Unit 2', 1, 2, 'the 2nd unit of Beginner English ', NULL, NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (3, 'Beginner English Unit 3', 1, 3, 'the 3rd unit of Beginner English ', NULL, NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (4, 'Beginner English Unit 4', 1, 4, 'the 4th unit of Beginner English ', NULL, NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (5, 'Beginner English Unit 5', 1, 5, 'the 5th unit of Beginner English ', NULL, NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (6, 'Intermediate English Unit 1', 2, 1, 'the 1st unit of Intermediate English ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (7, 'Intermediate English Unit 2', 2, 2, 'the 2nd unit of Intermediate English ', 'None', NULL, NULL);
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
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (31, 'Beginner Spanish Unit 1', 7, 1, 'the 1st unit of Beginner Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (32, 'Beginner Spanish Unit 2', 7, 2, 'the 2nd unit of Beginner Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (33, 'Beginner Spanish Unit 3', 7, 3, 'the 3rd unit of Beginner Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (34, 'Beginner Spanish Unit 4', 7, 4, 'the 4th unit of Beginner Spanish ', 'None', NULL, NULL);
INSERT INTO `Units` (`unit_id`, `unit_name`, `subject_id`, `Units_order`, `description`, `materials_path`, `text`, `text_description`) VALUES (35, 'Beginner Spanish Unit 5', 7, 5, 'the 5th unit of Beginner Spanish ', 'None', NULL, NULL);
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


# insert into questions_units table
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (1, 1, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (2, 2, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (3, 3, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (4, 4, 1);
INSERT INTO `question_units` (`question_unit_id`, `question_id`, `unit_id`) VALUES (5, 5, 1);

# insert into question_types table
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (1, 'text_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (2, 'text_picture');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (3, 'picture_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (4, 'audio_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (5, 'audio_picture');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (6, 'muti_text_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (7, 'muti_text_picture');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (8, 'muti_picture_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (9, 'muti_audio_text');
INSERT INTO `question_types` (`question_type_id`, `question_type`) VALUES (10, 'muti_audio_picture');

# insert into questions table
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (1, 'What\'s the CAPITAL letter for \"t\"? ', 1, NULL, NULL, NULL, 1, 'To choose capital letter for \"t\" which is \"T\"', '');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (2, 'What\'s the LOWERCASE letter for \"R\"? ', 2, NULL, NULL, NULL, 2, 'To choose letter \"R\" in lowercase which is \"r\"', '');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (3, 'What\'s the CAPITAL letter for the alphabet shown below?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/D', NULL, NULL, 3, 'To choose letter \"D\" in lowercase which is \"d\"', '');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (4, 'What letter is being spoked in the audio?', 4, NULL, NULL, NULL, 4, '', '');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (5, 'What\'s the LOWERCASE letter for \"Q\" and \"H\"? ', 6, NULL, NULL, NULL, 5, '', '');

# insert data into options table
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (1, 1, 'I', 0, 1, 'letter \"I/i\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (2, 1, 'T', 1, 2, 'letter \"T/t\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (3, 1, 'L', 0, 3, 'letter \"L/l\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (4, 1, 'F', 0, 4, 'letter \"F/f\" in uppercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (5, 2, 'https://tomatolearning.s3.amazonaws.com/option/h', 0, 1, 'a picture of letter \"h\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (6, 2, 'https://tomatolearning.s3.amazonaws.com/option/e', 0, 2, 'a picture of letter \"e\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (7, 2, 'https://tomatolearning.s3.amazonaws.com/option/r', 1, 3, 'a picture of letter \"r\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (8, 2, 'https://tomatolearning.s3.amazonaws.com/option/q', 0, 4, 'a picture of letter \"q\" in lowercase');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (9, 3, 'a', 0, 1, 'letter \"A/a\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (10, 3, 'o', 0, 2, 'letter \"O/o\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (11, 3, 'c', 0, 3, 'letter \"C/c\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (12, 3, 'd', 1, 4, 'letter \"D/d\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (13, 4, 'B/b', 0, 1, 'letter \"B/b\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (14, 4, 'V/v', 0, 2, 'letter \"V/v\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (15, 4, 'W/w', 0, 3, 'letter \"W/w\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (16, 4, 'Y/y', 0, 4, 'letter \"Y/y\"');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (17, 5, 'q', 1, 1, NULL);
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (18, 5, 'r', 0, 2, NULL);
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (19, 5, 'p', 0, 3, NULL);
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (20, 5, 'g', 0, 4, NULL);







#
# # subjects:  5 subjects * 3 levels -> 15
# INSERT INTO test.subjects (subject_name, level, description) VALUES ('Spanish', 'Junior', 'Junior Spanish');
# INSERT INTO test.subjects (subject_name, level, description) VALUES ('Spanish', 'Intermediate', 'Intermediate Spanish');
# INSERT INTO test.subjects (subject_name, level, description) VALUES ('Mandarin', 'Junior', 'Junior Mandarin');
# INSERT INTO test.subjects (subject_name, level, description) VALUES ('Mandarin', 'Intermediate', 'Intermediate Mandarin');
# INSERT INTO test.subjects (subject_name, level, description) VALUES ('Mandarin', 'Advance', 'Advance Mandarin');
#
#
# # Unit: 5 subjects * 3 levels * 5 units -> 75 units
# INSERT INTO test.Units (unit_name, subject_id, units_order, description, materials_path) VALUES ('Spanish Junior Unit1', 1, 1, 'the 1st unit of junior spanish', 'https://www.youtube.com/embed/LGMKg6MUdxI');
# INSERT INTO test.Units (unit_name, subject_id, units_order, description, materials_path) VALUES ('Spanish Unit2', 1, 2, 'the 2nd unit of junior spanish', 'https://www.youtube.com/embed/LGMKg6MUdxI');
# INSERT INTO test.Units (unit_name, subject_id, units_order, description, materials_path) VALUES ('Spanish Unit3', 1, 3, 'the 3rd unit of junior spanish', 'https://www.youtube.com/embed/VSuFrFPNbzA');
# INSERT INTO test.Units (unit_name, subject_id, units_order, description, materials_path) VALUES ('Spanish Unit4', 1, 4, 'the 4st unit of junior spanish', 'https://www.youtube.com/embed/K6SUsWizytA');
# INSERT INTO test.Units (unit_name, subject_id, units_order, description, materials_path) VALUES ('Spanish Unit5', 1, 5, 'the 5st unit of junior spanish', 'https://www.youtube.com/embed/hsLYD1Jyf3A');
#
#
#
# #question_type:
# # https://examenes.cervantes.es/es/dele/preparar-prueba
# # https://mandarinbean.com/hsk-chinese-test-online/
# INSERT INTO test.question_types (question_type_id, question_type) VALUES (1, 'Judgement_by_picture');
# INSERT INTO test.question_types (question_type_id, question_type) VALUES (2, 'Judgement_by_audio');
#
#
# # question
# # download and trim the audio
# INSERT INTO test.questions (question, question_type_id, picture_path, video_path, audio_path, question_order, explanation) VALUES ('Is the picture a description of the ‘Ordenador’?' , 1, null, null, null, 1, 'The above descriptions are words is ');
# INSERT INTO test.questions (question, question_type_id, picture_path, video_path, audio_path, question_order, explanation) VALUES ('Is the audio a description of the ‘Teléfonos móviles’', 2, null, null, null, 2, 'The above descriptions are word is ');
#
# #question_units
# INSERT INTO test.question_units (question_id, unit_id) VALUES (1, 1);
# INSERT INTO test.question_units (question_id, unit_id) VALUES (2, 1);
#
# # options
# INSERT INTO test.options (question_id, `option`, is_correct, order_number) VALUES (1, 'TRUE', 1, 1);
# INSERT INTO test.options (question_id, `option`, is_correct, order_number) VALUES (1, 'FALSE', 0, 2);
#
# # options
# INSERT INTO test.options (question_id, `option`, is_correct, order_number) VALUES (2, 'TRUE', 0, 1);
# INSERT INTO test.options (question_id, `option`, is_correct, order_number) VALUES (2, 'FALSE', 1, 2);
#
#
#










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

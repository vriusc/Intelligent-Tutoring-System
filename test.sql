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
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (1, 'What\'s the CAPITAL letter for \"t\"? ', 1, NULL, NULL, NULL, 1, 'Capital letter for \"t\" is \"T\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (2, 'What\'s the LOWERCASE letter for \"R\"? ', 2, NULL, NULL, NULL, 2, 'Letter \"R\" in lowercase is \"r\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (3, 'What\'s the CAPITAL letter for the alphabet shown below?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/D', NULL, NULL, 3, 'Letter \"D\" in lowercase is \"d\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (4, 'What letter is in the audio?', 4, NULL, NULL, 'https://www.youtube.com/embed/PJV35b4cPgo?start=210&end=214', 4, '', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (5, 'What\'s the LOWERCASE letter for \"Q\" and \"H\"? ', 6, NULL, NULL, NULL, 5, '', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (6, 'What color is shown in the picture below?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/yellow', NULL, NULL, 1, '\"yellow\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (7, 'What color snow is?', 1, NULL, NULL, NULL, 2, '\"white\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (8, 'Choose what you hear.', 5, NULL, NULL, 'https://www.youtube.com/embed/0LNuoKsAtN8?start=73&end=75', 3, '\"pink\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (9, 'Choose what you hear.', 10, NULL, NULL, 'https://www.youtube.com/embed/ybt2jhCQ3lA?start=31&end=33', 4, '\"blue\" \"purple\"', '\"red and blue make purple\"');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (10, 'Choose the option(s) that describes the picture.', 8, 'https://tomatolearning.s3.amazonaws.com/picture/apple', NULL, NULL, 5, '\"red\" \"apple\" \"green\" \"brown\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (11, 'What animals are in this picture?', 8, 'https://tomatolearning.s3.amazonaws.com/picture/dog_cat', NULL, NULL, 1, '\"dog\" and \"cat\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (12, 'What animal is shown in this video?', 4, NULL, NULL, 'https://www.youtube.com/embed/H0xZ9DThon0?start=23&end=28', 2, '\"bear\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (13, 'What animals live under water?', 6, NULL, NULL, NULL, 3, '\"shark\" \"octopus\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (14, 'What animal is it in the picture?', 3, 'https://tomatolearning.s3.amazonaws.com/picture/sheep', NULL, NULL, 4, '\"sheep\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (15, 'What animals are in the audio?', 9, NULL, NULL, 'https://www.youtube.com/embed/H0xZ9DThon0?start=226&end=231', 5, '\"giraffe\" \"gorilla\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (16, 'How to spell 23?', 1, NULL, NULL, NULL, 1, '\"twenty-three\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (17, 'What number is in the audio?', 4, NULL, NULL, 'https://www.youtube.com/embed/dNP6L6y7ZEM?start=207&end=209', 2, '\"57\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (18, 'Choose the number(s) smaller than the number in the audio.', 9, NULL, NULL, 'https://www.youtube.com/embed/dNP6L6y7ZEM?start=144&end=146', 3, 'choose number smaller than 39', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (19, 'Choose which is \"Zero\"', 1, NULL, NULL, NULL, 4, '\"0\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (20, 'How to spell 100?', 1, NULL, NULL, NULL, 5, '\"one hundred\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (21, 'What day comes after Tuesday?', 1, NULL, NULL, NULL, 1, 'Wednesday', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (22, 'What\'s the last month of a year?', 1, NULL, NULL, NULL, 2, 'December', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (23, 'What month comes after June in a year?', 6, NULL, NULL, NULL, 3, 'July, August', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (24, 'Choose what day is it.', 4, NULL, NULL, 'https://www.youtube.com/embed/jhzj9D73SZw?start=31&end=34', 4, '\"Thursday\"', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (25, 'Choose what month is it.', 4, NULL, NULL, 'https://www.youtube.com/embed/jhzj9D73SZw?start=108&end=111', 5, 'November', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (26, 'She ______ dogs.', 1, NULL, NULL, NULL, 1, 'She \"likes\" dogs.', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (27, 'Adam loves to _____ to music while running. ', 1, NULL, NULL, NULL, 2, 'Adam loves to listen to music while running. ', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (28, 'Choose sentence(s) applied to the picture.', 6, 'https://tomatolearning.s3.amazonaws.com/picture/mother_baby.jpeg', NULL, NULL, 3, 'A women is holding a baby on the beach and the weather is nice.', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (29, 'Choose the option(s) corresponding to the description: He goes hiking every weekend.', 7, NULL, NULL, NULL, 4, 'zzz', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (30, 'Choose the option(s) corresponding to the audio.', 10, NULL, NULL, 'https://www.youtube.com/embed/jul2urONzOQ?start=891&end=895', 5, 'zzz', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (31, 'What is this advertisement for?', 1, NULL, NULL, NULL, 1, 'zzz', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (32, 'How much do the sunglasses cost?', 1, NULL, NULL, NULL, 2, 'zzz', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (33, 'Who cannot benefit from this special deal?', 1, NULL, NULL, NULL, 3, 'zzz', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (34, 'Choose the picture of sunglasses.', 2, NULL, NULL, NULL, 4, 'zzz', '1');
INSERT INTO `questions` (`question_id`, `question`, `question_type_id`, `picture_path`, `video_path`, `audio_path`, `question_order`, `explanation`, `description`) VALUES (35, 'Bob purchased a subscription to this on 3rd Oct, 2004. Which date is the subcription no longer valid?', 1, NULL, NULL, NULL, 5, 'zzz', '1');




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
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (21, 6, 'yellow', 1, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (22, 6, 'red', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (23, 6, 'purple', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (24, 6, 'green', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (25, 7, 'black', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (26, 7, 'pink', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (27, 7, 'white', 1, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (28, 7, 'blue', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (29, 8, 'https://tomatolearning.s3.amazonaws.com/option/orange.png', 0, 1, 'orange');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (30, 8, 'https://tomatolearning.s3.amazonaws.com/option/purple.png', 0, 2, 'purple');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (31, 8, 'https://tomatolearning.s3.amazonaws.com/option/pink.png', 1, 3, 'pink');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (32, 8, 'https://tomatolearning.s3.amazonaws.com/option/blue.png', 0, 4, 'blue');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (33, 9, 'orange', 0, 1, 'orange');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (34, 9, 'purple', 1, 2, 'purple');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (35, 9, 'pink', 0, 3, 'pink');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (36, 9, 'blue', 1, 4, 'blue');
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
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (77, 20, 'one hundrad', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (78, 20, 'one hudred', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (79, 20, 'one hundroed', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (80, 20, 'one hundred', 1, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (81, 21, 'Wednesday', 1, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (82, 21, 'Thursday', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (83, 21, 'Monday', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (84, 21, 'Sunday', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (85, 22, 'January', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (86, 22, 'December', 1, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (87, 22, 'September', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (88, 22, 'October', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (89, 23, 'July', 1, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (90, 23, 'June', 1, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (91, 23, 'March', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (92, 23, 'April', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (93, 24, 'Friday', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (94, 24, 'Saturday', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (95, 24, 'Thursday', 1, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (96, 24, 'Tuesday', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (97, 25, 'December', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (98, 25, 'October', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (99, 25, 'November', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (100, 25, 'September', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (101, 26, 'is', 0, 1, 'wrong');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (102, 26, 'are', 0, 2, 'wrong');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (103, 26, 'like', 0, 3, 'wrong');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (104, 26, 'likes', 1, 4, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (105, 27, 'listen', 1, 1, 'correct');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (106, 27, 'listens', 0, 2, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (107, 27, 'listening', 0, 3, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (108, 27, 'listened', 0, 4, 'wrong grammar');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (109, 28, 'They\'re on the beach.', 1, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (110, 28, 'The baby is crying.', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (111, 28, 'A woman is holding a baby.', 1, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (112, 28, 'It\'s raining.', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (113, 29, 'https://tomatolearning.s3.amazonaws.com/option/hockey.jpeg', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (114, 29, 'https://tomatolearning.s3.amazonaws.com/option/he.jpeg', 1, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (115, 29, 'https://tomatolearning.s3.amazonaws.com/option/hike.jpeg', 1, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (116, 29, 'https://tomatolearning.s3.amazonaws.com/option/sofa.jpeg', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (117, 30, 'https://tomatolearning.s3.amazonaws.com/option/strawberry.jpeg', 1, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (118, 30, 'https://tomatolearning.s3.amazonaws.com/option/lemon.jpeg', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (119, 30, 'https://tomatolearning.s3.amazonaws.com/option/carrot.jpeg', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (120, 30, 'https://tomatolearning.s3.amazonaws.com/option/she.jpeg', 1, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (121, 31, 'A summer trip.', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (122, 31, 'A travel company.', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (123, 31, 'A special deal.', 1, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (124, 31, 'A free magazine.', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (125, 32, 'They are free with a subscription.', 1, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (126, 32, 'They cost $1.', 0, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (127, 32, 'They cost $3 Canadian.', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (128, 32, 'They cost $21. 95 US.', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (129, 33, 'Canadians.', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (130, 33, 'UK residents.', 1, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (131, 33, 'North Americans.', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (132, 33, 'US residents.', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (133, 34, 'https://tomatolearning.s3.amazonaws.com/option/sun.jpeg', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (134, 34, 'https://tomatolearning.s3.amazonaws.com/option/sunglasses.jpeg', 1, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (135, 34, 'https://tomatolearning.s3.amazonaws.com/option/glasses.jpeg', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (136, 34, 'https://tomatolearning.s3.amazonaws.com/option/cone.jpeg', 0, 4, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (137, 35, '12th Aug', 0, 1, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (138, 35, '11th Nov', 1, 2, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (139, 35, '23rd Apr', 0, 3, 'zzz');
INSERT INTO `options` (`option_id`, `question_id`, `option`, `is_correct`, `order_number`, `description`) VALUES (140, 35, '7th May', 0, 4, 'zzz');





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

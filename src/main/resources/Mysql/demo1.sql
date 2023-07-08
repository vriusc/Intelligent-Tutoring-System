DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
use test;

CREATE TABLE student_user (
id         INT AUTO_INCREMENT PRIMARY KEY,
username   VARCHAR(50) NOT NULL,
password   VARCHAR(255) NOT NULL,
email      VARCHAR(255) NOT NULL,
CONSTRAINT Email UNIQUE (email),
CONSTRAINT Username UNIQUE (username)
);


CREATE TABLE  Subjects (
subject_id         INT AUTO_INCREMENT PRIMARY KEY,
subject_name       VARCHAR(50) NOT NULL,
level              VARCHAR(50) NOT NULL,
description        VARCHAR(255) NOT NULL
);


CREATE TABLE  student_subjects
(
    student_subject_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id         INT NOT NULL,
    subject_id         INT NOT NULL,
    progress           INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student_user (id),
    FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id)
);


CREATE TABLE  Units (
unit_id         INT AUTO_INCREMENT PRIMARY KEY,
unit_name       VARCHAR(50) NOT NULL,
subject_id      INT NOT NULL,
Units_order     INT NOT NULL,
description     VARCHAR(255) NOT NULL,
materials_path      VARCHAR(255),
FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id)
);

-- 创建题目类型表
CREATE TABLE question_types (
question_type_id INT AUTO_INCREMENT PRIMARY KEY,
question_type VARCHAR(255)
);

CREATE TABLE questions (
question_id         INT AUTO_INCREMENT PRIMARY KEY,
question            VARCHAR(255) NOT NULL,
question_type_id    INT NOT NULL,
picture_path        VARCHAR(255),
video_path          VARCHAR(255),
audio_path          VARCHAR(255),
question_order      INT NOT NULL,
explanation         VARCHAR(255) NOT NULL,
description         VARCHAR(255) NOT NULL,
FOREIGN KEY (question_type_id) REFERENCES question_types (question_type_id)
);

CREATE TABLE question_units (
question_unit_id    INT AUTO_INCREMENT PRIMARY KEY,
question_id         INT NOT NULL,
unit_id             INT NOT NULL,
FOREIGN KEY (question_id) REFERENCES questions (question_id),
FOREIGN KEY (unit_id) REFERENCES Units (unit_id)
);

CREATE TABLE options (
option_id       INT AUTO_INCREMENT PRIMARY KEY,
question_id     INT NOT NULL,
`option`          VARCHAR(255) NOT NULL,
is_correct      BOOLEAN NOT NULL,
order_number    INT NOT NULL,
FOREIGN KEY (question_id) REFERENCES questions (question_id)
);

CREATE TABLE record(
record_id           INT AUTO_INCREMENT PRIMARY KEY,
student_id          INT NOT NULL,
question_id         INT NOT NULL,
option_id           INT NOT NULL,
FOREIGN KEY (student_id) REFERENCES student_user (id),
FOREIGN KEY (question_id) REFERENCES questions (question_id),
FOREIGN KEY (option_id) REFERENCES options (option_id)
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

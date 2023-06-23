create schema test;

use test;

-- 创建学生用户表


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


create table record(
    record_id   int    auto_increment primary key,
    student_id int    not null,
    question_id int    not null,
    option_id int    not null,
    foreign key (student_id) references student_user (id),
    foreign key (question_id) references questions (question_id),
    foreign key (option_id) references options (option_id)
);

insert into student_user (username, password, email) values ('admin', 'admin', 'email');
insert into student_user (username, password, email) values ('student', 'student', 'email1');

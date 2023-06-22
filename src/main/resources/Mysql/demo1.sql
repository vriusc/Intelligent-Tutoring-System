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
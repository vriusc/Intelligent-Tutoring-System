### MYSQL 8.0.33


| Columns  | Data_type    | Constraints | Key         |
| -------- | ------------ | ----------- | ----------- |
| id       | INT          | AI          | PRIMARY KEY |
| username | VARCHAR(50)  | NOT NULL    |             |
| password | VARCHAR(255) | NOT NULL    |             |
| Email    | VARCHAR(255) | NOT NULL    |             |

Table 1: student_user table



| Columns      | Data_type    | Constraints | Key         |
| ------------ | ------------ | ----------- | ----------- |
| subject_id   | INT          | AI          | PRIMARY KEY |
| subject_name | VARCHAR(50)  | NOT NULL    |             |
| level        | VARCHAR(255) | NOT NULL    |             |
| description  | VARCHAR(255) | NOT NULL    |             |

Table 2: Subjects table



| Columns            | Data_type | Constraints | Key         |
| ------------------ | --------- | ----------- | ----------- |
| student_subject_id | INT       | AI          | PRIMARY KEY |
| student_id         | INT       | NOT NULL    | FOREIGN KEY |
| subject_id         | INT       | NOT NULL    | FOREIGN KEY |
| progress           | INT       | NOT NULL    |             |

Table 3: student_subjects



| Columns        | Data_type    | Constraints | Key         |
| -------------- | ------------ | ----------- | ----------- |
| unit_id        | INT          | AI          | PRIMARY KEY |
| unit_name      | VARCHAR(50)  | NOT NULL    |             |
| subject_id     | INT          | NOT NULL    | FOREIGN KEY |
| Units_order    | INT          | NOT NULL    |             |
| description    | VARCHAR(255) | NOT NULL    |             |
| materials_path | VARCHAR(255) |             |             |

Table 4: Units



| Columns          | Data_type    | Constraints | Key         |
| ---------------- | ------------ | ----------- | ----------- |
| question_type_id | INT          | AI          | PRIMARY KEY |
| question_type    | VARCHAR(255) | NOT NULL    |             |

Table 5: question_types



| Columns          | Data_type    | Constraints | Key         |
| ---------------- | ------------ | ----------- | ----------- |
| question_id      | INT          | AI          | PRIMARY KEY |
| question         | VARCHAR(255) | NOT NULL    |             |
| question_type_id | INT          | NOT NULL    | FOREIGN KEY |
| picture_path     | VARCHAR(255) |             |             |
| video_path       | VARCHAR(255) |             |             |
| audio_path       | VARCHAR(255) |             |             |
| question_order   | INT          | NOT NULL    |             |
| explanation      | VARCHAR(255) | NOT NULL    |             |

Table 6: questions



| Columns          | Data_type | Constraints | Key         |
| ---------------- | --------- | ----------- | ----------- |
| question_unit_id | INT       | AI          | PRIMARY KEY |
| question_id      | INT       | NOT NULL    | FOREIGN KEY |
| unit_id          | INT       | NOT NULL    | FOREIGN KEY |

Table 7: question_units



| Columns      | Data_type    | Constraints | Key         |
| ------------ | ------------ | ----------- | ----------- |
| option_id    | INT          | AI          | PRIMARY KEY |
| question_id  | INT          | NOT NULL    | FOREIGN KEY |
| option       | VARCHAR(255) | NOT NULL    |             |
| is_correct   | BOOLEAN      | NOT NULL    |             |
| order_number | INT          | NOT NULL    |             |

Table 8: options



| Columns     | Data_type | Constraints | Key         |
| ----------- | --------- | ----------- | ----------- |
| record_id   | INT       | AI          | PRIMARY KEY |
| student_id  | INT       | NOT NULL    | FOREIGN KEY |
| question_id | INT       | NOT NULL    | FOREIGN KEY |
| option_id   | INT       | NOT NULL    | FOREIGN KEY |

Table 9: record

MYSQL 8.0.33

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



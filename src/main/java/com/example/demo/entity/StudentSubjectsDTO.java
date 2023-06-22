package com.example.demo.entity;

import lombok.Data;

@Data
public class StudentSubjectsDTO {

    private Integer studentSubjectId;
    private Integer studentId;
    private Integer subjectId;
    private Integer progress;
    private RegisterResponseDTO student;
    private Subjects subject;
}

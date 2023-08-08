package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (StudentSubjects) entity
 *
 * @author qianyongru
 * @since 2023-06-22 06:25:52
 */
@Data
public class StudentSubjects implements Serializable {
    private static final long serialVersionUID = 738192947971207741L;
    
    private Integer studentSubjectId;
    
    private Integer studentId;
    
    private Integer subjectId;
    
    private Integer progress;

    private StudentUser student;

    private Subjects subject;
}


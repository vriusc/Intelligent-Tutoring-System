package com.example.demo.entity;

import lombok.Data;


/**
 * (StudentSubjectsDTO)实体类
 *
 * @author qianyongru
 * @since 2023-06-22 10:25:52
 */

@Data
public class StudentSubjectsDTO {

    private Integer studentSubjectId;
    private Integer studentId;
    private Integer subjectId;
    private Integer progress;
    private RegisterResponseDTO student;
    private Subjects subject;
}

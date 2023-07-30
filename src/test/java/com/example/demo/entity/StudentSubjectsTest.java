package com.example.demo.entity;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class StudentSubjectsTest {

        // lombok test
        @Test
        void testLombok() {
            StudentSubjects studentSubjects = new StudentSubjects();
            studentSubjects.setStudentSubjectId(1);
            studentSubjects.setStudentId(1);
            studentSubjects.setSubjectId(1);
            studentSubjects.setProgress(1);
            System.out.println(studentSubjects);
            assertEquals(1, studentSubjects.getStudentSubjectId());
            assertEquals(1, studentSubjects.getStudentId());
            assertEquals(1, studentSubjects.getSubjectId());
            assertEquals(1, studentSubjects.getProgress());
        }
}

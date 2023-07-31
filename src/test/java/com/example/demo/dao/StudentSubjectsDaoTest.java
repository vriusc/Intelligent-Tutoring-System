package com.example.demo.dao;

import com.example.demo.entity.StudentSubjects;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;


@SpringBootTest
@Transactional
public class StudentSubjectsDaoTest {

    @Autowired
    private StudentSubjectsDao studentSubjectsDao;

    private StudentSubjects studentSubjects;

    @BeforeEach
    public void setUp() {
        // Set up test data
        studentSubjects = new StudentSubjects();
        studentSubjects.setStudentSubjectId(99);
        studentSubjects.setStudentId(1);
        studentSubjects.setSubjectId(1);
        studentSubjects.setProgress(1);
        studentSubjectsDao.insert(studentSubjects);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        StudentSubjects result = studentSubjectsDao.queryById(studentSubjects.getStudentSubjectId());
        System.out.println(result);
        assertEquals(studentSubjects.getStudentSubjectId(), result.getStudentSubjectId());
    }
    @Test
    public void testQueryByStudentId(){
        // Call the method and verify the result
        List<StudentSubjects> results = studentSubjectsDao.queryByStudentId(1);
        System.out.println(results);
        assertTrue(results.size() > 0);
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        studentSubjectsDao.deleteById(studentSubjects.getStudentSubjectId());
    }

}

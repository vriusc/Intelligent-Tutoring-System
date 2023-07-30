package com.example.demo.dao;

import com.example.demo.entity.Subjects;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional
public class SubjectsDaoTest {

    @Autowired
    private SubjectsDao subjectsDao;

    private Subjects subjects;

    @BeforeEach
    public void setUp() {
        // Set up test data
        subjects = new Subjects();
        subjects.setSubjectId(1);
        subjects.setSubjectName("test");
        subjects.setLevel("test");
        subjects.setDescription("test");
        subjectsDao.insert(subjects);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        Subjects result = subjectsDao.queryById(subjects.getSubjectId());
        System.out.println(result);
        assertEquals(subjects.getSubjectId(), result.getSubjectId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        subjectsDao.deleteById(subjects.getSubjectId());
    }

}

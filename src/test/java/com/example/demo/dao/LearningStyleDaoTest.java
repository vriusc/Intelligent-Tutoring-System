package com.example.demo.dao;

import com.example.demo.entity.LearningStyle;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;


import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional
public class LearningStyleDaoTest {

    @Autowired
    private LearningStyleDao learningStyleDao;

    private LearningStyle learningStyle;

    @BeforeEach
    public void setUp() {
        // Set up test data
        learningStyle = new LearningStyle();
        learningStyle.setLearningStyleId(99);
        learningStyle.setStudentId(1);
        learningStyle.setActivist(1);
        learningStyle.setReflector(1);
        learningStyle.setTheorist(1);
        learningStyle.setPragmatist(1);
        learningStyleDao.insert(learningStyle);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        LearningStyle result = learningStyleDao.queryById(learningStyle.getLearningStyleId());
        System.out.println(result);
        assertEquals(learningStyle.getLearningStyleId(), result.getLearningStyleId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        learningStyleDao.deleteById(learningStyle.getLearningStyleId());
    }
}

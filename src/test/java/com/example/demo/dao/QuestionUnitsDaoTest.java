package com.example.demo.dao;

import com.example.demo.entity.QuestionUnits;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;


import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional
public class QuestionUnitsDaoTest {

        @Autowired
        private QuestionUnitsDao questionUnitsDao;

        private QuestionUnits questionUnits;

        @BeforeEach
        public void setUp() {
            // Set up test data
            questionUnits = new QuestionUnits();
            questionUnits.setQuestionUnitId(99);
            questionUnits.setQuestionId(1);
            questionUnits.setUnitId(1);
            questionUnitsDao.insert(questionUnits);
        }

        @Test
        public void testQueryById() {
            // Call the method and verify the result
            QuestionUnits result = questionUnitsDao.queryById(questionUnits.getQuestionUnitId());
            System.out.println(result);
            assertEquals(questionUnits.getQuestionUnitId(), result.getQuestionUnitId());
        }

        @AfterEach
        public void tearDown() {
            // Delete the test data after each test method
            questionUnitsDao.deleteById(questionUnits.getQuestionUnitId());
        }

}

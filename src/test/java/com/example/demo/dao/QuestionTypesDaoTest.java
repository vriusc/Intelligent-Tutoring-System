package com.example.demo.dao;

import com.example.demo.entity.QuestionTypes;
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

public class QuestionTypesDaoTest {

    @Autowired
    private QuestionTypesDao questionTypesDao;

    private QuestionTypes questionTypes;

    @BeforeEach
    public void setUp() {
        // Set up test data
        questionTypes = new QuestionTypes();
        questionTypes.setQuestionTypeId(99);
        questionTypes.setQuestionType("test");
        questionTypesDao.insert(questionTypes);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        QuestionTypes result = questionTypesDao.queryById(questionTypes.getQuestionTypeId());
        System.out.println(result);
        assertEquals(questionTypes.getQuestionTypeId(), result.getQuestionTypeId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        questionTypesDao.deleteById(questionTypes.getQuestionTypeId());
    }
}

package com.example.demo.dao;

import com.example.demo.entity.Questions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;


import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional
public class QuestionsDaoTest {

    @Autowired
    private QuestionsDao questionsDao;

    private Questions questions;

    @BeforeEach
    public void setUp() {
        // Set up test data
        questions = new Questions();
        questions.setQuestionId(99);
        questions.setQuestion("test");
        questions.setQuestionTypeId(1);
        questions.setPicturePath("test");
        questions.setVideoPath("test");
        questions.setAudioPath("test");
        questions.setDescription("test");
        questions.setQuestionOrder(1);
        questions.setExplanation("test");
        questionsDao.insert(questions);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        Questions result = questionsDao.queryById(questions.getQuestionId());
        System.out.println(result);
        assertEquals(questions.getQuestionId(), result.getQuestionId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        questionsDao.deleteById(questions.getQuestionId());
    }
}

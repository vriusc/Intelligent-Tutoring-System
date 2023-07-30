package com.example.demo.entity;

import com.example.demo.entity.QuestionTypes;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class QuestionTypesTest {
    @Test
    public void testQuestionTypes() {
        QuestionTypes questionTypes = new QuestionTypes();
        questionTypes.setQuestionTypeId(1);
        questionTypes.setQuestionType("text");
        assertEquals(1, questionTypes.getQuestionTypeId());
        assertEquals("text", questionTypes.getQuestionType());
    }
}

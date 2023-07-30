package com.example.demo;

import com.example.demo.entity.QuestionUnits;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class QuestionUnitsTest {
    // lombok test
    @Test
    void testLombok() {
        QuestionUnits questionUnits = new QuestionUnits();
        questionUnits.setQuestionUnitId(1);
        questionUnits.setQuestionId(1);
        questionUnits.setUnitId(1);
        System.out.println(questionUnits);
        assertEquals(1, questionUnits.getQuestionUnitId());
        assertEquals(1, questionUnits.getQuestionId());
        assertEquals(1, questionUnits.getUnitId());
    }
}

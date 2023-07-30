package com.example.demo.entity;

import com.example.demo.entity.LearningStyle;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class LearningStyleTest {
    @Test
    public void testLearningStyle() {
        LearningStyle learningStyle = new LearningStyle();
        learningStyle.setLearningStyleId(1);
        learningStyle.setStudentId(1);
        learningStyle.setActivist(1);
        learningStyle.setReflector(1);
        learningStyle.setTheorist(1);
        learningStyle.setPragmatist(1);
        assertEquals(1, learningStyle.getLearningStyleId());
        assertEquals(1, learningStyle.getStudentId());
        assertEquals(1, learningStyle.getActivist());
        assertEquals(1, learningStyle.getReflector());
        assertEquals(1, learningStyle.getTheorist());
        assertEquals(1, learningStyle.getPragmatist());
    }
}
